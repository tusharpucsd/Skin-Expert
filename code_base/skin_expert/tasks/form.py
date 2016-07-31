from django import forms
from django.utils.translation import ugettext_lazy as _
from patients.models import RATINGS, Episode, OPTION_CHOICES
from users.models import UserProfile
from users.models import Role


class QueryForm(forms.Form):
    def __init__(self, *args, **kwargs):
        super(QueryForm,self).__init__(*args, **kwargs)
        
    episode_no = forms.CharField(
                                 widget=forms.TextInput(attrs={"placeholder": _(u'Enter Episode Number')}),
                                 label=_(u'Episode No.'), required=True,
                                 )
    feedback = forms.CharField(
                               label=_('Feedback'), required=False, widget=forms.Textarea(attrs={'rows': 3}),
                               )
    

class TaskForm(forms.Form):
    def __init__(self, *args, **kwargs):
        super(TaskForm, self).__init__(*args, **kwargs)
        
    assigned_to = forms.ModelChoiceField(
                        queryset = UserProfile.objects.filter(role__code = 'doctor')
                   )
    
    ratings = forms.ChoiceField( 
                            label=_(u'RAG Ratings'),
                            choices = RATINGS
                           )
    
    completion_date = forms.DateField(
                          widget = forms.DateInput(),
                          label = _(u'Deadline')
                          )
    
    comments = forms.CharField(widget=forms.Textarea())

class TaskReviewForm(forms.Form):
    
    episode = forms.ModelChoiceField(queryset = Episode.objects.all(), widget = forms.HiddenInput(),)
    
    feedback = forms.CharField(widget=forms.Textarea())
    
    options = forms.ChoiceField( 
                            label=_(u'Options'),
                            choices = OPTION_CHOICES
                           )
MY_CHOICES = (
        ('opt0', 'This Week'),
        ('opt1', 'This Month'),
        ('opt2', 'Last 6 Months'),
    )


class TaskStaticsticsForm(forms.Form):
    
    def __init__(self, *args, **kwargs):
        """
        """
        super(TaskStaticsticsForm, self).__init__(*args, **kwargs)
        role_list = Role.objects.filter(code__in=['doctor', 'callcenter']).values_list('code', 'name')
        if 'data' in kwargs:
            self.fields['type'].initial = kwargs['data']['type']
            
            users_list = UserProfile.objects.filter(role__code = kwargs['data']['type']).values_list('user__id', 'user__username')
        else:    
            users_list = UserProfile.objects.values_list('user__id', 'user__username')
        
        users_list_total = [(0, 'Select'), ] 
        users_list_total.extend(users_list)
        
        self.fields['type'].choices = role_list
        self.fields['users'].choices = users_list_total

    type = forms.ChoiceField(
                            label='Type'
                           )
    users = forms.ChoiceField(
                            label='Users',
                            required = False
                            )
    from_date = forms.DateField(
                            error_messages={'required': _('Date is required.')},
                            widget=forms.DateInput(format='%d/%m/%Y', attrs={"data-date-format":"dd/mm/yyyy"}),
                                        input_formats=('%d/%m/%Y',),
                                        label = _(u'From'),
                                        required = False
                          )
    to_date = forms.DateField(
                            error_messages={'required': _('Date is required.')},
                            widget=forms.DateInput(format='%d/%m/%Y', attrs={"data-date-format":"dd/mm/yyyy"}),
                                        input_formats=('%d/%m/%Y',),
                                        label = _(u'To'),
                                        required = False
                          )
    time_choice = forms.ChoiceField(widget=forms.RadioSelect(attrs={'class':'time_choices'}), choices=MY_CHOICES, required = False)
    
    mode = forms.CharField(widget=forms.HiddenInput())
    
    def clean_to_date(self):
        """
            Validate that the sub-suburb is not already in use.
        """
        if self.cleaned_data['from_date'] != None: 
            if self.cleaned_data['to_date'] != None and self.cleaned_data['to_date'] <= self.cleaned_data['from_date']:
                raise forms.ValidationError(_("To date should be larger than from date."))
        elif self.cleaned_data['from_date'] == None and self.cleaned_data['to_date'] != None:
            raise forms.ValidationError(_("Please select from date."))
        
        return self.cleaned_data['to_date']