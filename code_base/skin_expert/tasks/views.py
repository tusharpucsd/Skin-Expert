# Create your views here.
from django.views.generic import FormView, ListView
from django.views.generic.base import TemplateView
from django.shortcuts import redirect
# from django.contrib.auth.models import User
from django.template import RequestContext
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from django.http import Http404

from patients.models import Task, Episode
# from users.models import UserProfile
from .form import TaskForm, TaskReviewForm, TaskStaticsticsForm, QueryForm
from patients.models import STATUS, RATINGS
from object_log.models import LogItem
from skin_expert.decorator import group_required
from skin_expert.common import *

from users.models import UserProfile

from tasks.models import Job, Query, ACTIONS, STATUS as JOB_STATUS
from django.db.models import F
import datetime
from django.core.paginator import InvalidPage
from users.models import UserProfile

import time
import random
from django.shortcuts import render_to_response, redirect
import xlsxwriter
from xlsxwriter.workbook import Workbook

from django.shortcuts import HttpResponse
import StringIO
import calendar
import re 

class TaskView(ListView):
	"""
	"""
	template_name = 'tasks/task_list.html'
	model = Job
	paginate_by = 10
	
	@method_decorator(login_required)
	@method_decorator(group_required('mgmtteam', 'sysadmin', 'callcenter', 'doctor'))
	def dispatch(self, *args, **kwargs):
		return super(TaskView, self).dispatch(*args, **kwargs)
	
	def get_context_data(self, **kwargs):
		context = super(TaskView, self).get_context_data(**kwargs)
			
		if self.request.user.profile.role and self.request.user.profile.role.code == 'doctor':
			self.template_name = 'tasks/task_list_doctor.html'
			context['status'] = STATUS
			context['ratings'] = RATINGS
		else:
			context['status'] = JOB_STATUS
			context['action'] = ACTIONS
		return context
	
	def get_queryset(self):
		if self.request.user.profile.role and self.request.user.profile.role.code == 'doctor':
			self.model = Task
		if self.request.user.profile.role and self.request.user.profile.role.code == 'doctor':
			tasks = Task.objects.all()
			tasks.filter(episode__completion_date__lt=timezone.now().date()).update(ratings=2)
			
			start_date = timezone.now().date()
			timezone_obj = timezone.get_current_timezone()  
			range = (timezone.make_aware(datetime.datetime.combine(start_date, datetime.time.min), timezone_obj), timezone.make_aware(datetime.datetime.combine(start_date, datetime.time.max), timezone_obj))
			tasks.filter(episode__completion_date__gte=timezone.now().date()).exclude(episode__submitted_at__range=range).exclude(ratings=2).update(ratings=1)
							
			return tasks.filter(assigned_to=self.request.user.profile, status='assigned').order_by('-ratings', 'episode__completion_date')\
				.prefetch_related('episode', 'episode__patient__profile__user', 'episode__patient__profile')
		else:
			return Job.objects.filter(assigned_to=self.request.user.profile).exclude(status='d').order_by('-submitted_at', 'status')
		
	
	def paginate_queryset(self, queryset, page_size):
		"""
		Paginate the queryset, if needed.
		"""
		
		paginator = self.get_paginator(queryset, page_size, allow_empty_first_page=self.get_allow_empty())
		page = self.kwargs.get('page') or self.request.GET.get('page') or 1
		try:
			page_number = int(page)
		except ValueError:
			if page == 'last':
				page_number = paginator.num_pages
			else:
				raise Http404(_(u"Page is not 'last', nor can it be converted to an int."))
		try:
			page = paginator.page(page_number)
		except InvalidPage:
			if page_number < 1:
				page = paginator.page(1)
			elif page_number > paginator.num_pages:
				page = paginator.page(paginator.num_pages)
			else:
				raise Http404(_(u'Invalid page (%(page_number)s)') % {
									'page_number': page_number
				})
		return (paginator, page, page.object_list, page.has_other_pages())
			

class TaskStaticsticsView(FormView):
	"""
	"""
	
	form_class = TaskStaticsticsForm
	http_method_names = ['get', 'post']
	success_url = 'task_staticstics'
	template_name = 'tasks/staticstics.html'
	
	data = {}
		
	@method_decorator(login_required)
	def dispatch(self, *args, **kwargs):
		return super(TaskStaticsticsView, self).dispatch(*args, **kwargs)
	
	
	def get_context_data(self, **kwargs):
		"""
		"""
		# Call the base implementation first to get a context
		context = super(TaskStaticsticsView, self).get_context_data(**kwargs)
		context.update(self.data)
		return context
	
	def chart_details(self, form_data):
		chartdata = {}
		chart_type = 'pieChart'
		x_is_date = False
		x_axis_format = ''
		y_axis_format = '.0'
		
		users = []
		users_name = []
		
		type = form_data['type']
		
		if type == 'doctor':
			users = UserProfile.objects.filter(role__code='doctor')
			users_name = ['Dr. %s' % u.capitalize() for u in users.values_list('user__first_name', flat=True)]
		else:
			users = UserProfile.objects.filter(role__code='callcenter')
			users_name = [u.user.first_name.capitalize() for u in users]
		
		if ('from_date' in form_data and form_data['from_date'] != None) or ('users' in form_data and form_data['users'] != '0') \
		or ('time_choice' in form_data and form_data['time_choice'] != ''):
			
			chart_type = 'lineChart'
			
			if form_data['users'] != '0':
				if type == 'doctor':
					users = users.filter(user__id=form_data['users'])
					users_name = ['Dr. %s' % (u.capitalize()) for u in users.values_list('user__first_name', flat=True)]
				else:
					users = users.filter(user__id=form_data['users'])
					users_name = [u.capitalize() for u in users.values_list('user__first_name', flat=True)]
			
			from_date = None
			
			if form_data['time_choice'] != '' and form_data['from_date'] == None:
				today = timezone.now().today()
				
				if form_data['time_choice'] == 'opt0':
					from_date = today - datetime.timedelta(today.weekday())
					to_date = today + datetime.timedelta(6 - today.weekday())
					
				elif form_data['time_choice'] == 'opt1':
					month_range = calendar.monthrange(today.year, today.month)
					from_date = timezone.make_aware(datetime.datetime(today.year, today.month, 1, 0, 0, 0), timezone.get_current_timezone())
					to_date = timezone.make_aware(datetime.datetime(today.year, today.month, month_range[1], 0, 0, 0), timezone.get_current_timezone())
					
				elif form_data['time_choice'] == 'opt2':
					first_month = first_year = None
					last_year = today.year
					last_month = today.month - 1
					
					if today.month - 6 < 1:
						first_year = today.year - 1
						first_month = 12 - 6 + today.month
					else:
						first_year = today.year
						first_month = today.month - 6
					
					if last_month < 1 :
						last_month = 12
						last_year = today.year - 1
					
					month_range = calendar.monthrange(last_year, last_month)
					from_date = timezone.make_aware(datetime.datetime(first_year, first_month, 1, 0, 0, 0), timezone.get_current_timezone())
					to_date = timezone.make_aware(datetime.datetime(last_year, last_month, month_range[1], 0, 0, 0), timezone.get_current_timezone())
			else:
				if form_data['from_date'] != None:
					from_date = timezone.make_aware(datetime.datetime.combine(form_data['from_date'], datetime.time.min), timezone.get_current_timezone())
						  
				else:
					if type == 'doctor':
						task = Task.objects.all().order_by('episode__submitted_at')[0]
						from_date = task.episode.submitted_at
					else:
						job = Job.objects.all().order_by('submitted_at')[0]
						from_date = timezone.make_aware(datetime.datetime.combine(job.submitted_at, datetime.time.min), timezone.get_current_timezone())
						
				to_date = form_data['to_date'] if form_data['to_date'] != None else timezone.now()
				to_date = timezone.make_aware(datetime.datetime.combine(to_date, datetime.time.min), timezone.get_current_timezone())
				
			to_date = to_date + datetime.timedelta(days=1) 
			nb_element = (to_date - from_date).days
			 
			if nb_element <= 6:
				nb_element = 7
				
			xdata = range(nb_element)
			xdata = map(lambda x: from_date + datetime.timedelta(days=x), xdata)
			xdata = [int(time.mktime(date.date().timetuple()) * 1000) for date in xdata]
				
			chartdata = {
				'x': xdata,
				'extra1': {"tooltip": {"y_start": "", "y_end": " case(s) handled"}},
			}
			  
			for index, user in enumerate(users):
				if type == 'doctor':
					ydata = self.get_success_ratio_doctor_duration(user, xdata, from_date, to_date)
				else:
					ydata = self.get_success_ratio_callcenter_duration(user, xdata, from_date, to_date)
					
				chartdata.update({'name%d' % (index + 1): users_name[index] , 'y%d' % (index + 1):  ydata})
				
			x_is_date = True
			x_axis_format = '%d %b %Y'
			y_axis_format = ''
			
		else:
			if  form_data['type'] == 'doctor':
				success_ratio = map(self.get_success_ratio_doctor, users)
				failure_ratio = map(self.get_failure_ratio, success_ratio)
				chartdata = {
					 'x': users_name,
					 'name1': 'Completed with time frame', 'y1': success_ratio,
					 'extra1': {"tooltip": {"y_start": "Completed ", "y_end": "% of allocated tasks"}},
					 }
			else:
				success_ratio = map(self.get_success_ration_call_center, users)
				failure_ratio = map(self.get_failure_ratio, success_ratio)
				
				chartdata = {
					 'x': users_name,
					 'name1': 'Completed with time frame', 'y1': success_ratio,
					 'extra1': {"tooltip": {"y_start": "Completed ", "y_end": "% of allocated tasks"}},
					 }
			
		charttype = chart_type
		
		data = {
				'charttype': charttype,
				'chartdata': chartdata,
				'extra': {
						  'x_is_date': x_is_date,
						  'x_axis_format': x_axis_format,
						  'y_axis_format': y_axis_format,
						  'tag_script_js': False,
						  'jquery_on_ready': False,

						  }
				
				}
		return data
			  
	def get(self, request, *args, **kwargs):
		form_class = self.get_form_class()
		form = self.get_form(form_class)
		
		self.data = self.chart_details({'type':'doctor'})
		return self.render_to_response(self.get_context_data(form=form, context_instance=RequestContext(request))) 
	
	def get_success_ratio_doctor(self, doctor): 
		tasks = Task.objects.filter(assigned_to=doctor).exclude(status__in=['assigned', 'nodoctor'])
		success_tasks = tasks.filter(episode__actual_completion_date__lte=F('episode__completion_date'))
		return (len(success_tasks) * 100 / len(tasks)) if len(tasks) != 0 else None
	
	def get_success_ratio_doctor_duration(self, doctor, xdata, from_date, to_date):
		
		sucess_ratio = []
		
		for date in xdata:
			date = timezone.make_aware(datetime.datetime.fromtimestamp(date / 1000), timezone.get_current_timezone())
			duration = [from_date, to_date]		
			tasks = Task.objects.filter(assigned_to=doctor, episode__submitted_at__range=duration).exclude(status__in=['assigned', 'nodoctor'])
			success_tasks = tasks.filter(episode__actual_completion_date=date, episode__actual_completion_date__lte=F('episode__completion_date'))
			sucess_ratio.append(len(success_tasks))
		return sucess_ratio
	
	def get_success_ratio_callcenter_duration(self, user, xdata, from_date, to_date):
		sucess_ratio = []
		for date in xdata:
			date = timezone.make_aware(datetime.datetime.fromtimestamp(date / 1000), timezone.get_current_timezone())
			duration = [from_date, to_date]		
			jobs = Job.objects.filter(assigned_to=user, submitted_at__range=duration, status='d')
			success_tasks = jobs.filter(actual_completed_date=date, actual_completed_date__lte=F('completion_date'))
			sucess_ratio.append(len(success_tasks))
		return sucess_ratio
	
	def get_success_ration_call_center(self, user):
		jobs = Job.objects.filter(assigned_to=user, status='d')
		success_jobs = jobs.filter(actual_completed_date__lte=F('completion_date'))
		return (len(success_jobs) * 100 / len(jobs)) if len(jobs) != 0 else None
	
	def get_failure_ratio(self, success_ratio):
		return 100 - success_ratio if success_ratio != None else None
	
	
	def post(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request form control.
		"""
		try:
			form_class = self.get_form_class()
			form = self.get_form(form_class)
			
			if request.POST['mode'] == 'export':
				return self.statistics_export(request, form)
			
			if form.is_valid():
				self.data = self.chart_details(form.cleaned_data)
				return self.render_to_response(self.get_context_data(form=form, context_instance=RequestContext(request)))
			else:
				return self.form_invalid(form)
		except Query.DoesNotExist, Episode.DoesNotExist:
			raise Http404
	
	def get_form_kwargs(self):
		"""
		Returns the keyword arguments for instanciating the form.
		"""
		kwargs = { }
		if self.request.method in ('POST', 'PUT'):
			kwargs.update({
				'data': self.request.POST, 				
			})
		return kwargs 
		
	
	def statistics_export(self, request, form):
		"""
			Export the statistics data to Excel file
		"""
		context = {}
		data = {}
		if request.method == 'POST' :
			output = StringIO.StringIO()
			book = Workbook(output)
			sheet = book.add_worksheet('Statistics')
			
			form_data = form.data.copy()
			
			if 'time_choice' not in form_data:
				form_data['time_choice'] = ''
			
			if form_data['from_date'] == '':
				form_data['from_date'] = None
			else:
				form_data['from_date'] = datetime.datetime.strptime(form_data['from_date'], "%d/%m/%Y")
			
			if form_data['to_date'] == '':
				form_data['to_date'] = None
			else:
				form_data['to_date'] = datetime.datetime.strptime(form_data['to_date'], "%d/%m/%Y")
				
			self.data = self.chart_details(form_data)
			
 			chart_type = 'pie' if self.data['charttype'] == 'pieChart' else 'line'
 			
 			chart = book.add_chart({'type': chart_type})
 			char = 'B'
 			if chart_type == 'pie':

  				if request.REQUEST.get('type') == 'doctor':
  				    sheet.write(0, 0, 'Doctors')
  				else:
  				 	sheet.write(0, 0, 'Call Center Operatives')
  			 	
  			 	sheet.write(0, 1, 'Tasks completed (%)')	
  			 	sheet.write_column('A2', self.data['chartdata']['x'])
  				sheet.write_column('B2', self.data['chartdata']['y1'])
 				
 				chart.add_series({'values': '=Statistics!$B$2:$B$%d' % (len(self.data['chartdata']['y1'])+1),
								  'categories': '=Statistics!$A$2:$A$%d' % (len(self.data['chartdata']['x'])+1),
								'marker': {'type': 'diamond'},
									})
 				chart.set_title({'name': 'Tasks completed within allocated time'})
 				chart.set_style(10)
 				
 			else:
 				keys = [key for key in self.data['chartdata'].keys() if re.search("^y\d+$", key) ]
 				
 				sheet.write(0, 0, 'Date')
 				dates = [datetime.datetime.fromtimestamp(date / 1000) for date in self.data['chartdata']['x']]
 				
 				date_format = book.add_format({'num_format': 'dd/mm/yyyy'})
 				sheet.set_column('A:A', 12)
 				sheet.write_column('A2', dates, date_format)
 				
 				
 				chart.set_x_axis({
						'date_axis': True,
                        'name': 'Tasks completed within time frame',
				})
 				
 				for index, key in enumerate(keys):
 					sheet.write(0, index + 1, self.data['chartdata']["name%d" % (index + 1)])
 					sheet.write_column('%s2' % char, self.data['chartdata'][key])
 					chart.add_series({'values': '=Statistics!$%s$2:$%s$%d' % (char, char, len(self.data['chartdata'][key])+1),
									'categories': '=Statistics!$A$2:$A$%d' % (len(self.data['chartdata'][key])+1),
								'marker': {'type': 'diamond'},
								'name':self.data['chartdata']["name%d" % (index + 1)]
									})
 					char = chr(ord(char) + 1)
			 	chart.set_size({'width': 750, 'height': 400})
			 				 	
			char = chr(ord(char) + 2)
			sheet.insert_chart('%s1' % char, chart)
			book.close()
			output.seek(0)
			response = HttpResponse(output.read(), mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
			response['Content-Disposition'] = "attachment; filename=Statistics.xlsx"
			return response
		return self.render_to_response(RequestContext(request),)   
			 
class TaskAuditView(ListView):
	"""
	"""
	success_url = 'login'
	template_name = 'tasks/task_audit.html'
	model = LogItem
	paginate_by = 10
	
	@method_decorator(login_required)
	@method_decorator(group_required('mgmtteam', 'sysadmin'))
	def dispatch(self, *args, **kwargs):
		return super(TaskAuditView, self).dispatch(*args, **kwargs)
	
# 	def get_queryset(self):
# 		return LogItem.objects.filter(user__profile__role__code__in=['callcenter', 'doctor']).exclude(user=self.request.user).order_by('-timestamp')

 	def get_queryset(self):
 		return LogItem.objects.order_by('-timestamp').select_related('user', 'action')

class TaskAddView(FormView):
	"""
		Base class for user registration views.
	"""
	form_class = TaskForm
	http_method_names = ['get', 'post']
	success_url = 'task_list'
	template_name = 'tasks/add.html'
	episode_no = None
	episode_obj = None
	query_obj = None
	
	@method_decorator(login_required)
	@method_decorator(group_required('callcenter', 'sysadmin', 'mgmtteam'))
	def dispatch(self, *args, **kwargs):
		return super(TaskAddView, self).dispatch(*args, **kwargs)
	   
	def get(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request	form control.
		"""
		try:
			self.episode_no = kwargs['episode_no']
			self.query_obj = Query.objects.get(episode_no=self.episode_no)
			self.episode_obj = Episode.objects.get(episode_no=self.episode_no)
			form_class = self.get_form_class()
			form = self.get_form(form_class)
			return self.render_to_response(self.get_context_data(form=form, episode_no=self.episode_no, context_instance=RequestContext(request)))
		except Query.DoesNotExist, Episode.DoesNotExist:
			raise Http404


	def post(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request form control.
		"""
		try:
			self.episode_no = kwargs['episode_no']
			self.query_obj = Query.objects.get(episode_no=self.episode_no)
			self.episode_obj = Episode.objects.get(episode_no=self.episode_no)
			self.episode_no = kwargs['episode_no']
			form_class = self.get_form_class()
			form = self.get_form(form_class)
			if form.is_valid():
				# Pass request to form_valid.
				return self.form_valid(request, form)
			else:
				return self.form_invalid(form)
		except Query.DoesNotExist, Episode.DoesNotExist:
			raise Http404
			 
		
	def get_form(self, form_class):
		"""
		Returns an instance of the form to be used in this view.
		"""
		return form_class(**self.get_form_kwargs())
	
	def get_form_kwargs(self):
		"""
		Returns the keyword arguments for instanciating the form.
		"""
		kwargs = {
			'initial': self.get_initial(),
		}
		if self.request.method in ('POST', 'PUT'):
			kwargs.update({
				'data': self.request.POST,
			})
		return kwargs
	
	
	def get_initial(self):
		"""
		"""
		initial = {}
		try:
			initial['comments'] = self.query_obj.feedback
		except Query.DoesNotExist :
			pass
			
		return initial
	
	def form_valid(self, request, form):
		"""
		"""
		self.episode_obj.tasks.update(status='abort')
		task = Task.objects.create(episode=self.episode_obj,
								   assigned_to=form.cleaned_data['assigned_to'],
								   created_by=request.user.profile,
								   ratings=form.cleaned_data['ratings'],
								   completion_date=form.cleaned_data['completion_date'],
								   status='assigned',
							   )
		Job.objects.filter(episode_no=self.episode_no).update(status='d')
		self.episode_obj.comments = form.cleaned_data['comments']
		self.episode_obj.save()
		
		data = {'msg': 'created task for %s ' % task.assigned_to.user.first_name.capitalize()}
 		LogItem.objects.log_action('CREATE', request.user, request.user, data=data)
		return redirect(TaskAddView.success_url)
	
	
class TaskReviewView(FormView):
	"""
		Base class for user registration views.
	"""
	form_class = TaskReviewForm
	http_method_names = ['get', 'post']
	success_url = 'task_list'
	template_name = 'tasks/review_patient.html'
	task_obj = None
	
	@method_decorator(login_required)
	def dispatch(self, *args, **kwargs):
		return super(TaskReviewView, self).dispatch(*args, **kwargs)
	   
	def get(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request	form control.
		"""
		self.task_obj = Task.objects.select_related().get(id=int(kwargs['id']))
		form_class = self.get_form_class()
		form = self.get_form(form_class)
		return self.render_to_response(self.get_context_data(form=form, context_instance=RequestContext(request)))


	def post(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request form control.
		"""
		self.task_obj = Task.objects.get(id=int(kwargs['id']))
		form_class = self.get_form_class()
		form = self.get_form(form_class)
		if form.is_valid():
			# Pass request to form_valid.
			return self.form_valid(request, form)
		else:
			return self.form_invalid(form) 
	
	def get_context_data(self, **kwargs):
		"""
		"""
		# Call the base implementation first to get a context
		context = super(TaskReviewView, self).get_context_data(**kwargs)
		context['task'] = self.task_obj
		return context
	  
	def get_form(self, form_class):
		"""
		Returns an instance of the form to be used in this view.
		"""
		return form_class(**self.get_form_kwargs())
	
	def get_initial(self):
		"""
		"""
		initial = {'episode': self.task_obj.episode, 'feedback': self.task_obj.episode.feedback}
		if self.task_obj.episode.status == 'completed': 
			initial['options'] = 'advice'
		elif self.task_obj.episode.status == 'inprogress':
			initial['options'] = 'followup'
		elif self.task_obj.episode.status == 'visit':
			initial['options'] = 'referral' 
		else:
			initial['options'] = 'advice'
		return initial
		
	def get_form_kwargs(self):
		"""
		Returns the keyword arguments for instanciating the form.
		"""
		kwargs = {
			'initial': self.get_initial(),
		}
		if self.request.method in ('POST', 'PUT'):
			kwargs.update({
				'data': self.request.POST,
			})
		return kwargs
	
	def form_valid(self, request, form):
		"""
		"""
		if form.cleaned_data['options'] == 'advice':
			self.task_obj.status = 'completed'
			self.task_obj.episode.status = 'completed'
			self.task_obj.episode.actual_completion_date = timezone.now()
		elif form.cleaned_data['options'] == 'followup':
			self.task_obj.status = 'inprogress'
			self.task_obj.episode.status = 'inprogress'
			self.task_obj.ratings = 2
			
			Job.objects.create(episode_no=self.task_obj.episode.episode_no,
							   assigned_to=UserProfile.objects.filter(role__code='callcenter').order_by('?')[0],
							   comments=form.cleaned_data['feedback'],
							   action='p',
							   )
			
		else:
			self.task_obj.status = 'visit'
			self.task_obj.episode.status = 'visit'
			self.task_obj.episode.actual_completion_date = timezone.now()
			self.task_obj.ratings = 2
			
			Job.objects.create(episode_no=self.task_obj.episode.episode_no,
							   assigned_to=UserProfile.objects.filter(role__code='callcenter').order_by('?')[0],
							   comments=form.cleaned_data['feedback'],
							   action='c',
							   )
			
		self.task_obj.episode.feedback = form.cleaned_data['feedback']
		self.task_obj.episode.save()
		self.task_obj.save()
			
		data = {'msg': 'reviewed Patient %s' % self.task_obj.episode.patient.profile.user.first_name.capitalize()}
# 		LogItem.objects.log_action('EDIT', request.user, request.user.profile, data=data)
		return redirect(TaskReviewView.success_url)	
	
	
	  
class QueryAddView(FormView):
	
	form_class = QueryForm
	http_method_names = ['get', 'post']
	success_url = 'add_task'
	template_name = 'tasks/add_query.html'
	episode_no = None
	episode_obj = None
	
	
	@method_decorator(login_required)
	@method_decorator(group_required('callcenter', 'sysadmin', 'mgmtteam'))
	def dispatch(self, *args, **kwargs):
		return super(QueryAddView, self).dispatch(*args, **kwargs)

	def post(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request form control.
		"""
		form_class = self.get_form_class()
		form = self.get_form(form_class)
 		
		if form.is_valid():
			#Pass request to form valid
			return self.form.form_valid(request, form)
		else:
			return self.form_invalid(form)
 		
 		
	def form_valid(self, request, form):
		"""
		"""
 		
 		
 		
	def get_form(self, form_class):
		"""
		Returns an instance of the form to be used in this view.
		"""
		return form_class(**self.get_form_kwargs())
 
 		

	

	