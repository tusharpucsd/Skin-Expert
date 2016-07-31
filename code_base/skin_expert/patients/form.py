from django import forms
import random
import string
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User
from address.models import Country
from patients.models import Patient
from tasks.models import STATUS
from django.core.exceptions import ValidationError

ETHNIC_CHOICES = (
				
				(_('White'), (
							#(_('0'), _('English / Welsh / Scottish / Northern Irish / British'),),
							(_('0'), _('British'),),
							(_('1'), _('Irish'),),
							#(_('2'), _('Gypsy'),),
							(_('2'), _('European'),),
							(_('3'), _('Any other White background'),),
							)
				),
				(_('Mixed / Multiple ethnic groups'), (
							(_('4'), _('White and Black Caribbean'),),
							(_('5'), _('White and Black African'),),
							(_('6'), _('White and Asian'),),
							(_('7'), _('Any other Mixed / Multiple ethnic background'),),
							)
				),
				(_('Asian'), (
							(_('8'), _('Indian'),),
							(_('9'), _('Pakistani'),),
							(_('10'), _('Bangladeshi'),),
							(_('11'), _('Chinese'),),
							(_('12'), _('Any other Asian background'),),
							)
				),
				(_('Black / African / Caribbean'), (
							(_('14'), _('African'),),
							(_('15'), _('Caribbean'),),
							(_('16'), _('Any other Black / African / Caribbean background'),),
							)
				),
				(_('Other ethnic group'), (
							(_('17'), _('Arab'),),
							(_('18'), _('Any other ethnic group'),),
							
							)
				)
				)

class RegisterPatientForm(forms.Form):
	
	
	def __init__(self, *args, **kwargs):
		self.id = kwargs.pop('id', None)
		super(RegisterPatientForm, self).__init__(*args, **kwargs)
		self.fields['code'].initial  = ''.join(random.choice(string.ascii_lowercase + string.digits) for x in range(10))
		if self.id:
			self.fields['username'].widget.attrs['readonly'] = True
		
# 		self.fields['mobile_code'].choices = Country.objects.all().order_by('dial_code').values_list('id', 'dial_code').exclude(dial_code=None)
# 		self.fields['phone_code'].choices = Country.objects.all().order_by('dial_code').values_list('id', 'dial_code').exclude(dial_code=None)
	
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
	
	dob = forms.DateField(
						 error_messages={'required': _('Date of Birth is required.')},
						widget=forms.DateInput(format='%d/%m/%Y', attrs={"data-date-format":"dd/mm/yyyy"}),
										input_formats=('%d/%m/%Y',),
						  label = _(u'Date of Birth')
						  )
	
	code = forms.CharField(widget=forms.TextInput(attrs={"placeholder": _(u'Random Code'), 
							"readonly" : True}), label=_(u'Random Code'), required = True,
							max_length =10
						   )
	
	ethnic_origin = forms.ChoiceField(
									choices = ETHNIC_CHOICES, 
									label=_(u'Ethnic Origin'),
									required = False
									)
	   
	smokes = forms.BooleanField(label=_(u'Do you smoke'), required=False)
	
	alcohol = forms.BooleanField(label=_(u'Do you drink'), required=False)
	
	allergies = forms.CharField(label=_('Known allergies'),
								widget=forms.Textarea(attrs={'rows': 2}),
								required= False
								)
								
	alcohol_quantity = forms.CharField(label=_('How much do you drink each week?'),
								required= False
								)
	
	smoke_frequency = forms.CharField(label=_('How much do you smoke each day?'),
								required= False
								)
	
	other_disease = forms.CharField(label=_('Other Disease'),
								widget=forms.Textarea(attrs={'rows': 3}),
								required= False
								)
	
	prev_disease = forms.CharField(label=_('Previous diagnoses of skin disease'),
								widget=forms.Textarea(attrs={'rows': 3}),
								required= False
								)
	
	current_medication = forms.CharField(label=_('Current medication (if any)'),
								widget=forms.Textarea(attrs={'rows': 2}),
								required= False
								)
	
	family_history = forms.CharField(label=_('Family history of skin disease'),
								widget=forms.Textarea(attrs={'rows': 3}),
								required= False
								)
	
	phone_no = forms.RegexField(regex="^\+?[0-9]{0,3}\s?[0-9]{8,10}", label=_('Phone No'), required=False,
							   widget=forms.TextInput(attrs={"placeholder": _(u'Phone Number'),"class": 'input-small'}),
							   error_messages={"invalid":"Please provide valid phone number."}
							   )
# 	phone_code = forms.ChoiceField(required=False,widget=forms.Select(attrs={"class": 'input-small'}))
	
	mobile_no = forms.RegexField(regex="^\+?[0-9]{0,3}\s?[0-9]{8,10}", label=_('Mobile No'), required=False,
								widget=forms.TextInput(attrs={"placeholder": _(u'Mobile Number'),"class": 'input-small'}),
								error_messages={"invalid":"Please provide valid mobile number."}
								)
# 	mobile_code = forms.ChoiceField(required=True,widget=forms.Select(attrs={"class": 'input-small'}))
	
	#address = forms.CharField(label=_('Address'), required=False, widget=forms.Textarea(attrs={'rows': 2}))
	
	street = forms.CharField(label=_('Street'), required=False,max_length=50,
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
		
	
	def clean_ethnic_origin(self):
		if self.data['ethnic_origin'] == 'Select':
			raise forms.ValidationError('Please select proper ethnic origin.')
		return self.data['ethnic_origin']
	
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
	
	
class CallCentreReportForm(forms.Form):
	"""
	"""
	status = forms.ChoiceField(choices = STATUS, 
									label=_(u'Status'),
									required = True
							   )
	call_time = forms.DateField(label=_(u'Time of call'),error_messages={'required': _('Time of call is required.')},
										widget=forms.DateInput(format='%d/%m/%Y', attrs={"data-date-format":"dd/mm/yyyy"}),
										input_formats=('%d/%m/%Y',))
	summary = forms.CharField(label=_(u'Summary'),widget=forms.Textarea(attrs={"placeholder": _(u'Call Summary'), "rows":3}))