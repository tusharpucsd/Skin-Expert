# Create your views here....
from django.views.generic import FormView, View, ListView
from django.views.generic.edit import DeleteView
from django.shortcuts import redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.template import RequestContext
from django.http import HttpResponseRedirect, HttpResponse
from django.core.urlresolvers import reverse_lazy
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.utils import simplejson
from django.template.loader import render_to_string
from django.contrib import messages
from django.core.urlresolvers import resolve

from .form import RegisterForm, LoginForm, ProfileForm, ChangePasswordForm
from .models import UserProfile
from object_log.models import LogItem 
from skin_expert.decorator import group_required
from skin_expert.common import *
import random
import string
from django.conf import settings
from django.core.mail import EmailMessage

from address.manager import AddressManager
import urlparse

from django.contrib.sites.models import get_current_site

class UserListView(ListView):
    """
    """
    success_url = 'login'
    template_name = 'registration/user_list.html'
    model = UserProfile
    paginate_by = 10
    
    @method_decorator(login_required)
    @method_decorator(group_required('mgmtteam','sysadmin'))
    def dispatch(self, *args, **kwargs):
        return super(UserListView, self).dispatch(*args, **kwargs)
    
    def get_queryset(self):
        return UserProfile.objects.exclude(role = None).exclude(user=self.request.user).select_related('user', 'role')
    
class RegisterView(FormView):
    """
        Base class for user registration views.
    """
    form_class = RegisterForm
    http_method_names = ['get', 'post']
    success_url = 'users_list'
    template_name = 'registration/register.html'
    edit = False
    id = None
    
    @method_decorator(login_required)
    @method_decorator(group_required('mgmtteam','sysadmin'))
    def dispatch(self, *args, **kwargs):
        return super(RegisterView, self).dispatch(*args, **kwargs)
       
    def get(self, request, *args, **kwargs):
        """
            Pass request to get_form_class and get_form for per-request    form control.
        """
        self.id = kwargs['id'] if 'id' in kwargs else None
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        return self.render_to_response(self.get_context_data(form=form, context_instance=RequestContext(request)))

    
    def get_context_data(self, **kwargs):
        context = super(FormView, self).get_context_data(**kwargs)
        if self.id:
            context['edit'] = True
            context['id'] = self.id
        else:
            context['edit'] = False
        
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
    
    def get_initial(self):
        """
        """
        initial = {}
        if self.id:
            user = UserProfile.objects.select_related('user', 'city', 'city__state', 'city__state__country', 'role').get(id=self.id)
            initial['username'] = user.user.username
            initial['first_name'] = user.user.first_name
            initial['last_name'] = user.user.last_name
            initial['email'] = user.user.email
            initial['role'] = user.role
            initial['phone_no'] = user.phone_no
            initial['country'] = user.city.state.country.name
            initial['state'] = user.city.state.name
            initial['city'] = user.city.name
            initial['street'] = user.street
            initial['landmark'] = user.landmark
            initial['pincode'] = user.pincode
#            initial['address'] = user.address
            initial['mobile_no'] = user.mobile_no
#             initial['mobile_code'] = user.mobile_code
#             initial['phone_code'] = user.phone_code
        return initial
    
    def form_valid(self, request, form):
        """
        """
        if self.id:
            userprofile = UserProfile.objects.get(id=self.id)
            userprofile.role = form.cleaned_data['role']
            
            
            userprofile.user.first_name=form.cleaned_data['first_name']
            userprofile.user.last_name=form.cleaned_data['last_name']
            userprofile.user.email=form.cleaned_data['email']
            
            userprofile.user.save()
            
            add_mng = AddressManager()
            userprofile.city = add_mng.save_address(form.cleaned_data)
            
            userprofile.pincode = form.cleaned_data['pincode']
            userprofile.save()
            
            data = {'msg': 'has been updated %s %s account successfully' % (userprofile.role.name ,userprofile.user.first_name.capitalize())}
            LogItem.objects.log_action('EDIT', request.user, userprofile, data=data)
        
            messages.info(request, 'User account updated successfully')
        else:
            user = User.objects.create(username=form.cleaned_data['username'],
                                   first_name=form.cleaned_data['first_name'],
                                   last_name=form.cleaned_data['last_name'],
                                   email=form.cleaned_data['email'],
                                   
                                   )
            password = ''.join(random.choice(string.ascii_lowercase + string.digits) for x in range(10))
            user.set_password(password)
            user.save()
            
            add_mng = AddressManager()
            city = add_mng.save_address(form.cleaned_data)
            
            userprofile = UserProfile.objects.create(user=user, role=form.cleaned_data['role'],
                                                     city =city,
                                                     pincode=form.cleaned_data['pincode'],
                                                     )
        
            data={'msg': 'created account for %s with role %s successfully' % (user.first_name.capitalize(), userprofile.role.name)}
            LogItem.objects.log_action('CREATE', request.user, userprofile, data=data)
            
            current_site = get_current_site(request)
            SUBJECT = 'Welcome to Skin Experts'
            CONTENT = render_to_string('registration/welcome_mail.html', {'username': form.cleaned_data['username'], 'password': password,
                                                                          'current_site': current_site, 
                                                                          'host': request.META['HTTP_HOST']},
                                       context_instance= RequestContext(request))
            email = EmailMessage(SUBJECT, CONTENT, settings.EMAIL_HOST_USER, to=[form.cleaned_data['email']])
            email.content_subtype = "html"
            email.send()
                
            messages.info(request, 'User Registered successfully')
        
        userprofile.mobile_no = form.cleaned_data['mobile_no']
        userprofile.phone_no = form.cleaned_data['phone_no']
#        userprofile.address = form.cleaned_data['address']
        userprofile.street = form.cleaned_data['street']
        userprofile.landmark = form.cleaned_data['landmark']
        
        userprofile.save()  
        return redirect(RegisterView.success_url)   
    
class LoginView(FormView):
    """
        Base class for user registration views.
    """
    form_class = LoginForm
    http_method_names = ['get', 'post']
    success_url = 'task_list'
    template_name = 'registration/login.html'
       
    def get(self, request, *args, **kwargs):
        """
            Pass request to get_form_class and get_form for per-request    form control.
        """
#         current_url = resolve(request.path_info).url_name
#         if current_url == 'home' and request.user.is_authenticated():
#             return redirect('/task')
#        logout(request)
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        return self.render_to_response(self.get_context_data(form=form, context_instance=RequestContext(request)))


    def post(self, request, *args, **kwargs):
        """
            Pass request to get_form_class and get_form for per-request form control.
        """
        form_class = self.get_form_class()
        form = self.get_form(form_class)
       
            
        if form.is_valid():
            user = authenticate(username=form.cleaned_data['username'], password=form.cleaned_data['password'])
            if user is not None:
                if user.is_active:
                    login(request, user)
                    data={'msg': 'Logged In Successfully.' }
                    if user.profile.role and user.profile.role.code == 'mgmtteam':
                        self.success_url = 'system_update'
                    LogItem.objects.log_action('LOGIN', request.user, request.user, data=data)
                    
                    result = urlparse.urlparse(request.META['HTTP_REFERER'])
                    try:
                        return redirect(result.query.split('=')[1])
                    except:
                        return redirect(self.success_url)  
                else:
                    return self.render_to_response(self.get_context_data(form=form, message="Your account seems to locked. Please contact admin."))
            else:
                return self.render_to_response(self.get_context_data(form=form, message="User name or password is not correct."))
        else:
            return self.form_invalid(form) 
        
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

class LogoutView(View):
    def get(self, request, *args, **kwargs):
        data={'msg': 'Logged Out Successfully.'}
        LogItem.objects.log_action('LOGOUT', request.user, request.user, data=data)
        logout(request)
        return HttpResponseRedirect(reverse_lazy('login'))
    
    
class EditProfileView(FormView):
    """
        Base class for user registration views.
    """
    form_class = ProfileForm
    http_method_names = ['get', 'post']
    success_url = 'myprofile'
    template_name = 'registration/myprofile.html'
    edit = False
    role_name = ''
    
    @method_decorator(login_required)
    @method_decorator(group_required('mgmtteam','sysadmin','callcenter','doctor'))
    def dispatch(self, *args, **kwargs):
        return super(EditProfileView, self).dispatch(*args, **kwargs)
       
    def get(self, request, *args, **kwargs):
        """
            Pass request to get_form_class and get_form for per-request form control.
        """
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        if 'e' in request.GET:
            self.edit = True
        return self.render_to_response(self.get_context_data(form=form, edit=self.edit, role_name = self.role_name, context_instance=RequestContext(request)))


    def post(self, request, *args, **kwargs):
        """
            Pass request to get_form_class and get_form for per-request form control.
        """
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        if form.is_valid():
            # Pass request to form_valid.
            return self.form_valid(request, form)
        else:
            return self.render_to_response(self.get_context_data(form=form, edit='t'))
        
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
        user_obj = UserProfile.objects.select_related('user', 'role', 'city', 'city__state', 'city__state__country')\
        .get(user__id = self.request.user.id)       
        initial['first_name'] = user_obj.user.first_name
        initial['last_name'] = user_obj.user.last_name
        initial['email'] = user_obj.user.email
        initial['id'] = user_obj.id

        try:
            initial['role'] = user_obj.role
            self.role_name = user_obj.role.name if user_obj.role else ''
        except UserProfile.DoesNotExist:
            initial['role'] = ''
        
        initial['phone_no'] =  user_obj.phone_no
        initial['country'] =  user_obj.city.state.country.name
        initial['state'] =  user_obj.city.state.name
        initial['city'] =  user_obj.city.name
        initial['street'] =  user_obj.street
        initial['landmark'] =  user_obj.landmark
        initial['pincode'] =  user_obj.pincode
        initial['address'] =  user_obj.address
        initial['mobile_no'] =  user_obj.mobile_no
#         initial['mobile_code'] = user_obj.profile.mobile_code
#         initial['phone_code'] = user_obj.profile.phone_code
        return initial       

    def form_valid(self, request, form):
        """
        """
        user = request.user
        user.first_name = form.cleaned_data['first_name']
        user.last_name = form.cleaned_data['last_name']
        user.email = form.cleaned_data['email']
        user.save()
        
        try:
            profile = user.profile
            profile.role = form.cleaned_data['role']
            profile.save()
        except UserProfile.DoesNotExist:
            profile = UserProfile.objects.create(user=user, role=form.cleaned_data['role'])
        
        profile.pincode = form.cleaned_data['pincode']
        profile.mobile_no = form.cleaned_data['mobile_no']
        profile.phone_no = form.cleaned_data['phone_no']
        profile.address = form.cleaned_data['address']
        profile.street = form.cleaned_data['street']
        profile.landmark = form.cleaned_data['landmark']
#         profile.mobile_code = form.cleaned_data['mobile_code']
#         profile.phone_code = form.cleaned_data['phone_code']
        
        add_mng = AddressManager()
        profile.city = add_mng.save_address(form.cleaned_data)
        profile.save()    
        
        LogItem.objects.log_action('EDIT', request.user, user, data={'msg': 'updated his/her profile.'})
        messages.info(request, "User profile updated successfully.")
        return redirect(EditProfileView.success_url)   

class ChangePasswordView(FormView):
    """
        Base class for user registration views.
    """
    form_class = ChangePasswordForm
    http_method_names = ['get', 'post']
    success_url = 'login'
    template_name = 'registration/change-password.html'
    
    def get(self, request, *args, **kwargs):
        """
            Pass request to get_form_class and get_form for per-request form control.
        """
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        return self.render_to_response(self.get_context_data(form=form, context_instance=RequestContext(request)))


    def post(self, request, *args, **kwargs):
        """
            Pass request to get_form_class and get_form for per-request form control.
        """
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        
        if form.is_valid():
            # Pass request to form_valid.
            return self.form_valid(request, form)
        else:
            return self.form_invalid(request, form) 
        
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
    
    def form_valid(self, request, form):
        """
        """
        password = form.cleaned_data['password']
        request.user.set_password(password);
        request.user.save() 
        data={'msg': 'applied for change password.'}
        LogItem.objects.log_action('LOGIN', request.user, request.user, data=data)     
        return HttpResponse(simplejson.dumps({'stat': True}))
    
    def form_invalid(self, request, form):
        """
        """ 
        response_text = render_to_string(self.template_name, self.get_context_data(form=form),  context_instance=RequestContext(request))
        return HttpResponse(simplejson.dumps({'stat': False, 'data': response_text}))
    
class UserDeleteView(DeleteView):
    model = UserProfile
    success_url = reverse_lazy('users_list')
    ids = None
    
    def post(self, request, *args, **kwargs):
        self.ids = request.POST.getlist('id[]', [])
        User.objects.filter(profile__id__in=self.ids).delete()
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
        
