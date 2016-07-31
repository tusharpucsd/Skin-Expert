# Create your views here.
from django.views.generic import FormView, ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import DeleteView
from django.shortcuts import redirect
from django.contrib.auth.models import User
from django.template import RequestContext
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse_lazy
from django.template.loader import render_to_string 
from .form import RegisterPatientForm,CallCentreReportForm
from .models import Patient, Episode, STATUS, RATINGS
from users.models import UserProfile
from object_log.models import LogItem
from skin_expert.decorator import group_required
from tasks.models import Job
import random
import string
from django.conf import settings
from django.core.mail import EmailMessage
from skin_expert.common import *
from django.contrib import messages
from django.utils import timezone

from address.manager import AddressManager

from django.contrib.sites.models import get_current_site

#from .models import reversion


class PatientView(ListView):
	"""
	"""
	template_name = 'patient_management/patient_list.html'
	model = Patient
	paginate_by = 10
	
	@method_decorator(login_required)
	@method_decorator(group_required('mgmtteam','sysadmin', 'callcenter'))
	def dispatch(self, *args, **kwargs):
		return super(PatientView, self).dispatch(*args, **kwargs)
	
	def get_context_data(self, **kwargs):
		context = super(PatientView, self).get_context_data(**kwargs)
		context['status'] = STATUS
		context['ratings'] = RATINGS
		return context
	
	def get_queryset(self):
		return Patient.objects.all().prefetch_related('episodes', 'profile__user', 'episodes__tasks', 'episodes__tasks__assigned_to', 'episodes__tasks__assigned_to__user')
 
class PatientDetailView(DetailView):
	model = Patient
	template_name = 'patient_management/patient_detail.html'
	
	@method_decorator(login_required)
	@method_decorator(group_required('mgmtteam','sysadmin', 'callcenter'))
	def dispatch(self, *args, **kwargs):
		return super(PatientDetailView, self).dispatch(*args, **kwargs)

	def get_object(self):
		"""Returns the BlogPost instance that the view displays"""
		return Episode.objects.get(episode_no=self.kwargs.get("id")).patient
	

   
class RegisterPatientView(FormView):
	"""
		Base class for user registration views.
	"""
	form_class = RegisterPatientForm
	http_method_names = ['get', 'post']
	success_url = 'patient_list'
	template_name = 'patient_management/register.html'
	id = None
	
	@method_decorator(login_required)
	@method_decorator(group_required('mgmtteam','sysadmin', 'callcenter'))
	def dispatch(self, *args, **kwargs):
		return super(RegisterPatientView, self).dispatch(*args, **kwargs)
	
	def get(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request	form control.
		"""
		self.id = kwargs['id'] if 'id' in kwargs else None
		form_class = self.get_form_class()
		form = self.get_form(form_class)
		
		return self.render_to_response(self.get_context_data(form=form, context_instance= RequestContext(request)))
	 
#	@reversion.create_on_success()
	def post(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request form control.
		"""
		self.id = kwargs['id'] if 'id' in kwargs else None
		form_class = self.get_form_class()
		form = self.get_form(form_class)
		if form.is_valid():
			# Pass request to form_valid.
			return self.form_valid(request, form)
		else:
			return self.form_invalid(form) 
	
	def get_context_data(self, **kwargs):
		context = super(FormView, self).get_context_data(**kwargs)
		if self.id:
			context['edit'] = True
			context['id'] = self.id
		else:
			context['edit'] = False
		
		return context
	
	def get_initial(self):
		"""
		"""
		initial = {}
		if self.id:
			patient = Patient.objects.get(id=self.id)
			initial['username'] = patient.profile.user.username
			initial['first_name'] = patient.profile.user.first_name
			initial['last_name'] = patient.profile.user.last_name
			initial['email'] = patient.profile.user.email
			initial['code'] = patient.code
			initial['dob'] = patient.dob
			
			initial['ethnic_origin'] = patient.ethnic_origin
			initial['smokes'] = patient.smokes
			initial['alcohol'] = patient.alcohol
			initial['allergies'] = patient.allergies
			initial['prev_disease'] = patient.prev_disease
			initial['current_medication'] = patient.current_medication
			initial['family_history'] = patient.family_history
			initial['other_disease'] = patient.other_disease
			
			initial['phone_no'] =  patient.profile.phone_no
			initial['country'] =  patient.profile.city.state.country.name
			initial['state'] =  patient.profile.city.state.name
			initial['city'] =  patient.profile.city.name
			initial['street'] =  patient.profile.street
			initial['landmark'] =  patient.profile.landmark
			initial['pincode'] =  patient.profile.pincode
#			initial['address'] =  patient.profile.address
			initial['mobile_no'] =  patient.profile.mobile_no
			initial['alcohol_quantity'] =  patient.alcohol_quantity
			initial['smoke_frequency'] =  patient.smoke_frequency
# 			initial['mobile_code'] = patient.profile.mobile_code
# 			initial['phone_code'] = patient.profile.phone_code	  
		return initial
	
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
			'id': self.id,
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
		if self.id:
			patient = Patient.objects.get(id=self.id)
			patient.dob = form.cleaned_data['dob']
			patient.ethnic_origin = form.cleaned_data['ethnic_origin']
			patient.smokes = form.cleaned_data['smokes']
			patient.alcohol = form.cleaned_data['alcohol']
			
			
			user = patient.profile.user
			user.username = form.cleaned_data['username']
			user.first_name = form.cleaned_data['first_name']
			user.last_name = form.cleaned_data['last_name']
			user.email = form.cleaned_data['email']
			user.save()
			
			add_mng = AddressManager()
			
			user_profile = patient.profile
			user_profile.city = add_mng.save_address(form.cleaned_data)
			user_profile.pincode = form.cleaned_data['pincode']
# 			user_profile.mobile_code = form.cleaned_data['mobile_code']
# 			user_profile.phone_code = form.cleaned_data['phone_code']
			messages.info(request, 'Patient\'s details updated successfully')
		else:
			user = User.objects.create(username = form.cleaned_data['username'],
								   first_name = form.cleaned_data['first_name'],
								   last_name = form.cleaned_data['last_name'],
								   email = form.cleaned_data['email'],
								   
								   )
			password = ''.join(random.choice(string.ascii_lowercase + string.digits) for x in range(10))
			user.set_password(password)
			user.save()
			
			add_mng = AddressManager()
			city = add_mng.save_address(form.cleaned_data)
			
			user_profile = UserProfile.objects.create(user = user, pincode = form.cleaned_data['pincode'], city=city)
		
			patient = Patient.objects.create(
										 profile = user_profile,
										 dob = form.cleaned_data['dob'],
										 code = form.cleaned_data['code'],
										 ethnic_origin = form.cleaned_data['ethnic_origin'],
										 smokes = form.cleaned_data['smokes'],
										 alcohol = form.cleaned_data['alcohol'],
										 alcohol_quantity = form.cleaned_data['alcohol_quantity'] ,
										 smoke_frequency = form.cleaned_data['smoke_frequency'],
										 
										 )
			data={'msg': 'created account for patient %s successfully' % patient.profile.user.first_name.capitalize()+ " " +patient.profile.user.last_name.capitalize() }
			LogItem.objects.log_action('CREATE', request.user, request.user, data=data)
			current_site = get_current_site(request)
			SUBJECT = 'Welcome to Skin Experts'
			CONTENT = render_to_string('patient_management/welcome_mail.html', {'username': form.cleaned_data['username'], 'password': password,
																				'passcode' :  form.cleaned_data['code'],
																				'current_site' : current_site, 
                                                                          		'host': request.META['HTTP_HOST']},
                                       								   			context_instance= RequestContext(request))

# 			CONTENT = 'Your account is created at SkinExperts.com<br/ > Account details are as following. <br />Username : %s <br /> Password : %s <br /> Random Access Code: %s <br />' % (form.cleaned_data['username'], password, form.cleaned_data['code'])
			
			email = EmailMessage(SUBJECT, CONTENT, settings.EMAIL_HOST_USER, to=[form.cleaned_data['email']])
			email.content_subtype = "html"
			email.send()
			
			messages.info(request, 'Patient\'s details added successfully')
			
		patient.allergies = form.cleaned_data['allergies']
		patient.prev_disease = form.cleaned_data['prev_disease']
		patient.current_medication = form.cleaned_data['current_medication']
		patient.family_history = form.cleaned_data['family_history']
		patient.other_disease = form.cleaned_data['other_disease']
		patient.alcohol_quantity = form.cleaned_data['alcohol_quantity']
		patient.smoke_frequency = form.cleaned_data['smoke_frequency']
		patient.save()
		
		user_profile.mobile_no = form.cleaned_data['mobile_no']
		user_profile.phone_no = form.cleaned_data['phone_no']
#		user_profile.address = form.cleaned_data['address']
		user_profile.street = form.cleaned_data['street']
		user_profile.landmark = form.cleaned_data['landmark']
# 		user_profile.mobile_code = form.cleaned_data['mobile_code']
# 		user_profile.phone_code = form.cleaned_data['phone_code']
		user_profile.save() 
		return redirect(RegisterPatientView.success_url)   

class PatientDeleteView(DeleteView):
	model = Patient
	success_url = reverse_lazy('patient_list')
	ids = None
	
	def post(self, request, *args, **kwargs):
		self.ids = request.POST.getlist('id[]', [])
		patient_obj = self.get_object().get()
		patient_obj.profile.delete()
		patient_obj.profile.user.delete()
		return self.delete(request, *args, **kwargs)
	
	def get_object(self, queryset=None):
		"""
		Returns the queryset with all the objects matching requested slug fields
		"""
		
		if queryset is None:
			queryset = self.get_queryset()
		
		if self.ids is not None:
			queryset = queryset.filter(id__in =self.ids)
		
		else:
			raise AttributeError("Error while deleting records. Id not found.")
		return queryset
		
class CallReportView(FormView):
	"""
		Base class for user registration views.
	"""
	form_class = CallCentreReportForm
	http_method_names = ['get', 'post']
	success_url = 'task_list'
	template_name = 'patient_management/callreporting.html'
	edit = False
	#id = None
	
	@method_decorator(login_required)
	@method_decorator(group_required('mgmtteam','sysadmin','callcenter'))
	def dispatch(self, *args, **kwargs):
		return super(CallReportView, self).dispatch(*args, **kwargs)
	   
	def get(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request	form control.
		"""
		self.id = kwargs['id'] if 'id' in kwargs else None
		form_class = self.get_form_class()
		form = self.get_form(form_class)
		return self.render_to_response(self.get_context_data(form=form, context_instance=RequestContext(request)))

	
	def get_context_data(self, **kwargs):
		context = super(FormView, self).get_context_data(**kwargs)
		if self.id:
			patient = Episode.objects.select_related().get(episode_no=self.id)
			context['patient'] = patient
		return context
	
	def post(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request form control.
		"""
		self.id = kwargs['id'] if 'id' in kwargs else None
		form_class = self.get_form_class()
		form = self.get_form(form_class)
		if form.is_valid():
			# Pass request to form_valid.
			return self.form_valid(request, form)
		else:
			return self.form_invalid(form) 
		
	def get_form(self, form_class):
		"""
		Returns an instance of the form to be used in this view.
		"""
		return form_class(**self.get_form_kwargs())
	
	def get_initial(self):
		"""
		"""
		initial = {}
		if self.id:
			patient = Job.objects.select_related().get(episode_no=self.id)
			initial['status'] = patient.status
			initial['call_time'] = patient.call_date
			initial['summary'] = patient.summary
		return initial
	
	def form_valid(self, request, form):
		"""
		"""
		if self.id:
			job = Job.objects.get(episode_no=self.id)
			job.call_date = form.cleaned_data['call_time']
			job.summary =  form.cleaned_data['summary']
			job.status = form.cleaned_data['status']
			job.actual_completed_date =  timezone.now().date()
			job.save()
		else:
			pass
		return redirect(CallReportView.success_url)   

class PatientHistoryDetailView(FormView):
	#model = Patient
	http_method_names = ['get', 'post']
	success_url = 'task_list'
	template_name = 'patient_management/patient_history.html'
	id = None
	form_class = CallCentreReportForm
	
	@method_decorator(login_required)
	@method_decorator(group_required('mgmtteam','sysadmin', 'callcenter'))
	def dispatch(self, *args, **kwargs):
		return super(PatientHistoryDetailView, self).dispatch(*args, **kwargs)
	
	def get_context_data(self, **kwargs):
		context = super(PatientHistoryDetailView, self).get_context_data(**kwargs)
		if self.id:
			patient = Patient.objects.select_related('profile', 'profile__user').prefetch_related('episodes', 'episodes__tasks', 'episodes__tasks__assigned_to')\
			.get(episodes__episode_no=self.kwargs.get("id"))
			
			context['object'] = patient
			context['episode_no']=  self.kwargs.get("id")
		context['status'] = STATUS
		
		return context
	
	def get(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request	form control.
		"""
		self.id = kwargs['id'] if 'id' in kwargs else None
		form_class = self.get_form_class()
		form = self.get_form(form_class)
		return self.render_to_response(self.get_context_data(form=form, context_instance=RequestContext(request)))
	
	def post(self, request, *args, **kwargs):
		"""
			Pass request to get_form_class and get_form for per-request form control.
		"""
		self.id = kwargs['id'] if 'id' in kwargs else None
		form_class = self.get_form_class()
		form = self.get_form(form_class)
		if form.is_valid():
			# Pass request to form_valid.
			return self.form_valid(request, form)
		else:
			return self.form_invalid(form) 
		
	def get_form(self, form_class):
		"""
		Returns an instance of the form to be used in this view.
		"""
		return form_class(**self.get_form_kwargs())
	
	def get_initial(self):
		"""
		"""
		initial = {}
		if self.id:
			patient = Job.objects.get(episode_no=self.id)
			initial['call_time'] = patient.call_date
			initial['summary'] = patient.summary
			initial['status'] = patient.status
		return initial
	
	def form_valid(self, request, form):
		"""
		"""
		if self.id:
			job = Job.objects.get(episode_no=self.id)
			job.call_date = form.cleaned_data['call_time']
			job.summary =  form.cleaned_data['summary']
			job.status = form.cleaned_data['status']
			job.actual_completed_date =  timezone.now().date()
			job.save()
		else:
			pass
		return redirect(PatientHistoryDetailView.success_url) 