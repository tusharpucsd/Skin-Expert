from django import forms
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User

from .models import Role
from address.models import Country

from django.core.mail import EmailMessage
from django.contrib.auth.tokens import default_token_generator
from django.utils.http import int_to_base36
from django.contrib.auth.hashers import UNUSABLE_PASSWORD, is_password_usable, get_hasher
from django.contrib.sites.models import get_current_site
from django.template.loader import render_to_string
from django.template import RequestContext
from django.core.exceptions import ValidationError

class RegisterForm(forms.Form):
		
	def __init__(self, *args, **kwargs):	   
		self.id = kwargs.pop('id', None)
		
		super(RegisterForm, self).__init__(*args, **kwargs)
		if self.id:
			self.fields['username'].widget.attrs['readonly'] = True
# 		self.fields['mobile_code'].choices =  Country.objects.all().order_by('dial_code').values_list('id', 'dial_code').exclude(dial_code=None)
# 		self.fields['phone_code'].choices = Country.objects.all().order_by('dial_code').values_list('id', 'dial_code').exclude(dial_code=None)
	#id =None
	username = forms.CharField( 
							widget=forms.TextInput(attrs={"placeholder": _(u'User Name')}),
							label=_(u'User Name'),max_length=30,
						   )	

	first_name = forms.CharField( 
							widget=forms.TextInput(attrs={"placeholder": _(u'First Name')}),
							label=_(u'First Name'),max_length=20,
						   )
	
	last_name = forms.CharField( 
							widget=forms.TextInput(attrs={"placeholder": _(u'Last Name')}),
							label=_(u'Last Name'),max_length=20,
						   )
	
	email = forms.EmailField(
							label=_(u'Email'),max_length=30,
						)

	role = forms.ModelChoiceField(
							queryset=Role.objects.all(),
							label='Group'
						   )
	
	phone_no = forms.RegexField(regex="^\+?[0-9]{0,3}\s?[0-9]{8,10}", label=_('Phone No'), required = False,
							   widget=forms.TextInput(attrs={"placeholder": _(u'PhoneNumber')}),
							   error_messages={"invalid":"Please provide valid phone number."}
							   )
	#phone_code = forms.ChoiceField(required=False,widget=forms.Select(attrs={"class": 'input-small'}))
	
	mobile_no = forms.RegexField(regex="^\+?[0-9]{0,3}\s?[0-9]{8,10}", label=_('Mobile No'), required=False,
								widget=forms.TextInput(attrs={"placeholder": _(u'MobileNumber')}),
								error_messages={"invalid":"Please provide valid mobile number."}
								)
	#mobile_code = forms.ChoiceField(required=False,widget=forms.Select(attrs={"class": 'input-small'}))
	
	#address = forms.CharField(label=_('Address'), required=False, widget=forms.Textarea(attrs={'rows': 2}))
	
	street = forms.CharField(label=_('Street'), required=False,
							 widget=forms.TextInput(attrs={"placeholder": _(u'Street')}),
							 )
	
	landmark = forms.CharField(label=_('Landmark'), required=False,
							   widget=forms.TextInput(attrs={"placeholder": _(u'Landmark')}),
							   )
	
	country = forms.CharField(label=_('Country'), 
							  widget=forms.TextInput(attrs={"placeholder": _(u'Country')})
							  )
	
	state = forms.CharField(label=_('State/Region'), required=False,
							 widget=forms.TextInput(attrs={"placeholder": _(u'State/Region')})
							 )
	
	city = forms.CharField(label=_('City/Location'), required=False,
						   widget=forms.TextInput(attrs={"placeholder": _(u'City/Location')})
						   )
	
	pincode = forms.CharField(label=_('ZipCode/ Pincode'),max_length=6, required=False,
							  widget=forms.TextInput(attrs={"placeholder": _(u'Zipcode/Pincode')})
							  )
	
	
	def clean_username(self):
		"""
			Validate that the sub-suburb is not already in use.
		"""
		if not self.id:
			try:
				User.objects.get(username__iexact=self.cleaned_data['username'])
				raise forms.ValidationError(_("Username already exists."))
			except User.DoesNotExist:
				return self.cleaned_data['username']
		else:
			return self.cleaned_data['username']
	
	  
   
	def clean_mobile_no(self):
		"""
			Validate that the sub-suburb is not already in use.
		"""
		if 'mobile_no' in self.cleaned_data and 'phone_no' in self.cleaned_data:
			if (self.cleaned_data['mobile_no'] == None or self.cleaned_data['mobile_no'] == "") and (self.cleaned_data['phone_no'] == None or self.cleaned_data['phone_no'] == ""):
				raise forms.ValidationError(_("Please provide atleast one contact number."))
			else:
				return self.cleaned_data['mobile_no']
		else:
			return self.cleaned_data['mobile_no']
	
	def clean_email(self):
		if self.id:
			# Edit
			try:
				usr_obj = User.objects.get(email__iexact=self.cleaned_data['email'])
				if self.id == str(usr_obj.profile.id) and  usr_obj.email == self.cleaned_data['email']:
					return self.cleaned_data['email']
				else:
					raise forms.ValidationError(_("Email already exists."))
			except User.DoesNotExist:
				return self.cleaned_data['email']
			except User.MultipleObjectsReturned:
				raise forms.ValidationError(_("Email already exists."))
		else:
			# Add functionality
			try:
				usr_obj = User.objects.get(email__iexact=self.cleaned_data['email'])
				raise forms.ValidationError(_("Email already exists."))
			except User.DoesNotExist:
				return self.cleaned_data['email']
			except User.MultipleObjectsReturned:
				raise forms.ValidationError(_("Email already exists."))
		

class LoginForm(forms.Form): 
		
	username = forms.CharField( 
							widget=forms.TextInput(attrs={"placeholder": _(u'User Name')}),
							label=_(u'User Name')
						   )
	
	password = forms.CharField(
							widget=forms.PasswordInput(attrs={"placeholder": _(u'Password')}),
							label=_(u'Password')
							)
			

class ProfileForm(forms.Form):
	
	def __init__(self, *args, **kwargs):
		super(ProfileForm, self).__init__(*args, **kwargs)
		
		self.fields['first_name'].initial = kwargs['initial']['first_name']
		self.fields['last_name'].initial = kwargs['initial']['last_name']
		self.fields['email'].initial = kwargs['initial']['email']
		self.fields['role'].initial = kwargs['initial']['role']
		self.id =  kwargs['initial']['id']
		
# 		self.fields['mobile_code'].choices = Country.objects.all().order_by('dial_code').values_list('id', 'dial_code').exclude(dial_code=None)
# 		self.fields['phone_code'].choices = Country.objects.all().order_by('dial_code').values_list('id', 'dial_code').exclude(dial_code=None)
   
	first_name = forms.CharField( 
							widget=forms.TextInput(attrs={"placeholder": _(u'First Name')}),
							label=_(u'First Name'),max_length=20,
						   )
	
	last_name = forms.CharField( 
							widget=forms.TextInput(attrs={"placeholder": _(u'Last Name')}),
							label=_(u'Last Name'),max_length=20,
						   )
	
	email = forms.EmailField(
							label=_(u'Email'),max_length=30,
						)

	role = forms.ModelChoiceField(
							queryset=Role.objects.all(),
							label='Group'
						   )
	
	phone_no = forms.RegexField(regex="^\+?[0-9]{0,3}\s?[0-9]{8,10}", label=_('Phone No'), required = False,
							   widget=forms.TextInput(attrs={"placeholder": _(u'Phone Number')}),
							   error_messages={"invalid":"Please provide valid phone number."}
							   )
#	phone_code = forms.ChoiceField(required=False,widget=forms.Select(attrs={"class": 'input-small'}))
	 
	mobile_no = forms.RegexField(regex="^\+?[0-9]{0,3}\s?[0-9]{8,10}", label=_('Mobile No'), 
								widget=forms.TextInput(attrs={"placeholder": _(u'Mobile Number')}),
								required = False,
								error_messages={"invalid":"Please provide valid mobile number."}
								)
	
#	mobile_code = forms.ChoiceField(required=False,widget=forms.Select(attrs={"class": 'input-small'}))
	
	address = forms.CharField(label=_('Address'), required=False, widget=forms.Textarea(attrs={'rows': 3}))
	
	street = forms.CharField(label=_('Street'), required=False,
							 widget=forms.TextInput(attrs={"placeholder": _(u'Street')}),
							 )
	
	landmark = forms.CharField(label=_('Landmark'), required=False,
							   widget=forms.TextInput(attrs={"placeholder": _(u'Landmark')}),
							   )
	
	country = forms.CharField(label=_('Country'), 
							  widget=forms.TextInput(attrs={"placeholder": _(u'Country')})
							  )
	
	state = forms.CharField(label=_('State/Region'), required=False,
							 widget=forms.TextInput(attrs={"placeholder": _(u'State/Region')})
							 )
	
	city = forms.CharField(label=_('City/Location'), required=False,
						   widget=forms.TextInput(attrs={"placeholder": _(u'City/Location')})
						   )
	
	pincode = forms.CharField(label=_('ZipCode/ Pincode'),max_length=6, required=False,
							  widget=forms.TextInput(attrs={"placeholder": _(u'Zipcode/Pincode')})
							  )
	
	def clean_mobile_no(self):
		"""
			Validate that the sub-suburb is not already in use.
		"""
		if 'mobile_no' in self.cleaned_data and 'phone_no' in self.cleaned_data:
			if (self.cleaned_data['mobile_no'] == None or self.cleaned_data['mobile_no'] == "") and (self.cleaned_data['phone_no'] == None or self.cleaned_data['phone_no'] == ""):
				raise forms.ValidationError(_("Please provide atleast one contact number."))
			else:
				return self.cleaned_data['mobile_no']
		else:
			return self.cleaned_data['mobile_no']
	
	def clean_email(self):
		# Edit
		try:
			usr_obj = User.objects.get(email__iexact=self.cleaned_data['email'])
			if self.id == usr_obj.profile.id and  usr_obj.email == self.cleaned_data['email']:
				return self.cleaned_data['email']
			else:
				raise forms.ValidationError(_("Email already exists."))
		except User.DoesNotExist:
			return self.cleaned_data['email']
		except User.MultipleObjectsReturned:
				raise forms.ValidationError(_("Email already exists."))
				
class ForgotPasswordForm(forms.Form):	 
	
	email = forms.EmailField( label=_(u'Email') )
	
	def clean_email(self):
		try:
			User.objects.get(email = self.data['email'])
			return self.data['email']
		except User.DoesNotExist:
			raise forms.ValidationError(_("User with this email does not exists."))
		

class ChangePasswordForm(forms.Form):
	
	password = forms.CharField(
							widget=forms.PasswordInput(attrs={"placeholder": _(u'Password')}),
							label=_(u'Password')
							)
	
	confirm_password = forms.CharField(
							widget=forms.PasswordInput(attrs={"placeholder": _(u'Password')}),
							label=_(u'Confirm Password')
							)
	
	def clean_password(self):
		
		if self.data['password'] != self.data['confirm_password']:
			raise forms.ValidationError('Passwords do not match')
		return self.data['password']


class CustomPasswordResetForm(forms.Form):
	error_messages = {
		'unknown': _("That e-mail address doesn't have an associated "
					 "user account. Are you sure you've registered?"),
		'unusable': _("The user account associated with this e-mail "
					  "address cannot reset the password."),
	}
	email = forms.EmailField(label=_("E-mail"), max_length=75)

	def clean_email(self):
		"""
		Validates that an active user exists with the given email address.
		"""
		email = self.cleaned_data["email"]
		self.users_cache = User.objects.filter(email__iexact=email,
											   is_active=True)
		if not len(self.users_cache):
			raise forms.ValidationError(self.error_messages['unknown'])
		if any((user.password == UNUSABLE_PASSWORD)
			   for user in self.users_cache):
			raise forms.ValidationError(self.error_messages['unusable'])
		return email

	def save(self, domain_override=None,
			 subject_template_name='registration/password_reset_subject.txt',
			 email_template_name='registration/password_reset_email.html',
			 use_https=False, token_generator=default_token_generator,
			 from_email=None, request=None):
		"""
		Generates a one-use only link for resetting password and sends to the
		user.
		"""
		for user in self.users_cache:
			if not domain_override:
				current_site = get_current_site(request)
				site_name = current_site.name
				domain = current_site.domain
			else:
				site_name = domain = domain_override
			c = {
				'email': user.email,
				'domain': domain,
				'site_name': site_name,
				'uid': int_to_base36(user.id),
				'user': user,
				'token': token_generator.make_token(user),
				'protocol': use_https and 'https' or 'http',
				'host': request.META['HTTP_HOST'],
			}
			subject = "Password reset on Skin Experts"
			
			content = render_to_string(email_template_name, c, context_instance= RequestContext(request))
			
			
			email = EmailMessage(subject, content, from_email, to=[user.email])
			email.content_subtype = "html"
			email.send()
			 
			