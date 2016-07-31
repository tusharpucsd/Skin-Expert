'''
Convenience forms for adding and updating ``Event`` and ``Occurrence``s.

'''
from datetime import datetime, date, time, timedelta

from django import forms
from django.utils.translation import ugettext_lazy as _
from django.forms.extras.widgets import SelectDateWidget

from dateutil import rrule
from availability.conf import settings as swingtime_settings
from availability import utils
from availability.models import Occurrence

from users.models import UserProfile

WEEKDAY_SHORT = (
    (7, _(u'Sun')),
    (1, _(u'Mon')),
    (2, _(u'Tue')),
    (3, _(u'Wed')),
    (4, _(u'Thu')),
    (5, _(u'Fri')),
    (6, _(u'Sat'))
)

WEEKDAY_LONG = (
    (7, _(u'Sunday')),
    (1, _(u'Monday')),
    (2, _(u'Tuesday')),
    (3, _(u'Wednesday')),
    (4, _(u'Thursday')),
    (5, _(u'Friday')),
    (6, _(u'Saturday'))
)

MONTH_LONG = (
    (1,  _(u'January')),
    (2,  _(u'February')),
    (3,  _(u'March')),
    (4,  _(u'April')),
    (5,  _(u'May')),
    (6,  _(u'June')),
    (7,  _(u'July')),
    (8,  _(u'August')),
    (9,  _(u'September')),
    (10, _(u'October')),
    (11, _(u'November')),
    (12, _(u'December')),
)

MONTH_SHORT = (
    (1,  _(u'Jan')),
    (2,  _(u'Feb')),
    (3,  _(u'Mar')),
    (4,  _(u'Apr')),
    (5,  _(u'May')),
    (6,  _(u'Jun')),
    (7,  _(u'Jul')),
    (8,  _(u'Aug')),
    (9,  _(u'Sep')),
    (10, _(u'Oct')),
    (11, _(u'Nov')),
    (12, _(u'Dec')),
)


ORDINAL = (
    (1,  _(u'first')),
    (2,  _(u'second')),
    (3,  _(u'third')),
    (4,  _(u'fourth')),
    (-1, _(u'last'))
)

FREQUENCY_CHOICES = (
    (rrule.DAILY,   _(u'Day(s)')),
    (rrule.WEEKLY,  _(u'Week(s)')),
    (rrule.MONTHLY, _(u'Month(s)')),
    (rrule.YEARLY,  _(u'Year(s)')),
)

REPEAT_CHOICES = (
    ('count', _(u'By count')),
    ('until', _(u'Until date')),
)

ISO_WEEKDAYS_MAP = (
    None,
    rrule.MO,
    rrule.TU,
    rrule.WE,
    rrule.TH,
    rrule.FR,
    rrule.SA,
    rrule.SU
)

MINUTES_INTERVAL = swingtime_settings.TIMESLOT_INTERVAL.seconds // 60
SECONDS_INTERVAL = utils.time_delta_total_seconds(swingtime_settings.DEFAULT_OCCURRENCE_DURATION)

#===============================================================================
class MultipleIntegerField(forms.MultipleChoiceField):
    '''
    A form field for handling multiple integers.
    
    '''
    
    #---------------------------------------------------------------------------
    def __init__(self, choices, size=None, label=None, widget=None):
        if widget is None:
            widget = forms.SelectMultiple(attrs={'size' : size or len(choices)})
        super(MultipleIntegerField, self).__init__(
            required=False,
            choices=choices,
            label=label,
            widget=widget,
        )

    #---------------------------------------------------------------------------
    def clean(self, value):
        return [int(i) for i in super(MultipleIntegerField, self).clean(value)]


#===============================================================================
class MultipleOccurrenceForm(forms.Form):
    doctor = forms.ModelChoiceField(queryset= UserProfile.objects.filter(role__code = 'doctor'),
                                    widget = forms.HiddenInput(),
                                    )
    
    day = forms.DateField(
        label=_(u'Date'),
        initial=date.today,
        widget=SelectDateWidget()
    )
    # recurrence options
    repeats = forms.ChoiceField(
        choices=REPEAT_CHOICES,
        initial='count',
        label=_(u'Occurrences'),
        widget=forms.RadioSelect()
    )

    count = forms.IntegerField(
        label=_(u'Total Occurrences'),
        initial=1,
        required=False,
        widget=forms.TextInput(attrs=dict(size=2, max_length=2))
    )

    until = forms.DateField(
        required=False,
        initial=date.today,
        widget=SelectDateWidget()
    )
    
    freq = forms.IntegerField(
        label=_(u'Frequency'),
        initial=rrule.WEEKLY,
        widget=forms.RadioSelect(choices=FREQUENCY_CHOICES),
    )

    interval = forms.IntegerField(
        required=False,
        initial='1',
        widget=forms.TextInput(attrs=dict(size=3, max_length=3))
    )
    
    # weekly options
    week_days = MultipleIntegerField(
        WEEKDAY_SHORT, 
        label=_(u'Weekly options'),
        widget=forms.CheckboxSelectMultiple
    )
    
    # monthly  options
    month_option = forms.ChoiceField(
        choices=(('on',_(u'On the')), ('each',_(u'Each:'))),
        initial='each',
        widget=forms.RadioSelect(),
        label=_(u'Monthly options')
    )
    
    month_ordinal = forms.IntegerField(widget=forms.Select(choices=ORDINAL))
    month_ordinal_day = forms.IntegerField(widget=forms.Select(choices=WEEKDAY_LONG))
    each_month_day = MultipleIntegerField(
        [(i,i) for i in range(1,32)], 
        widget=forms.CheckboxSelectMultiple
    )
    
    # yearly options
    year_months = MultipleIntegerField(
        MONTH_SHORT, 
        label=_(u'Yearly options'),
        widget=forms.CheckboxSelectMultiple
    )
    
    is_year_month_ordinal = forms.BooleanField(required=False)
    year_month_ordinal = forms.IntegerField(widget=forms.Select(choices=ORDINAL))
    year_month_ordinal_day = forms.IntegerField(widget=forms.Select(choices=WEEKDAY_LONG))
    
    #---------------------------------------------------------------------------
    def __init__(self, *args, **kws):
        super(MultipleOccurrenceForm, self).__init__(*args, **kws)
        dtstart = self.initial.get('dtstart', None)
        
        if 'initial' in kws:
            self.fields['doctor'].initial = kws['initial']['doctor']
            
        if dtstart:
            dtstart = dtstart.replace(
                minute=((dtstart.minute // MINUTES_INTERVAL) * MINUTES_INTERVAL),
                second=0, 
                microsecond=0
            )

            weekday = dtstart.isoweekday()
            ordinal = dtstart.day // 7
            ordinal = u'%d' % (-1 if ordinal > 3 else ordinal + 1,)
            offset = (dtstart - datetime.combine(dtstart.date(), time(0))).seconds
            
            self.initial.setdefault('day', dtstart)
            self.initial.setdefault('week_days', u'%d' % weekday)
            self.initial.setdefault('month_ordinal', ordinal)
            self.initial.setdefault('month_ordinal_day', u'%d' % weekday)
            self.initial.setdefault('each_month_day', [u'%d' % dtstart.day])
            self.initial.setdefault('year_months', [u'%d' % dtstart.month])
            self.initial.setdefault('year_month_ordinal', ordinal)
            self.initial.setdefault('year_month_ordinal_day', u'%d' % weekday)
            self.initial.setdefault('start_time_delta', u'%d' % offset)
            self.initial.setdefault('end_time_delta', u'%d' % (offset + SECONDS_INTERVAL,))

    #---------------------------------------------------------------------------
    
    
    def clean_day(self):
        try:
            day = datetime.combine(self.cleaned_data['day'], time(0))
            Occurrence.objects.get(doctor = self.cleaned_data['doctor'], date = day)
            raise forms.ValidationError(_("You have already set your availability for this date."))
        except Occurrence.DoesNotExist:
            return self.cleaned_data['day']
            
        
    #---------------------------------------------------------------------------
    def save(self):
        if self.cleaned_data['repeats'] == 'no':
            params = {}
        else:
            params = self._build_rrule_params()

        status = Occurrence.objects.add_occurrences(
            self.cleaned_data['doctor'], 
            self.cleaned_data['day'],
            **params
        )
        return status
    #---------------------------------------------------------------------------
    def _build_rrule_params(self):
        iso = ISO_WEEKDAYS_MAP
        data = self.cleaned_data
        params = dict(
            freq=data['freq'],
            interval=data['interval'] or 1
        )
        
        if self.cleaned_data['repeats'] == 'count':
            params['count'] = data['count']
        elif self.cleaned_data['repeats'] == 'until':
            params['until'] = data['until']

        if params['freq'] == rrule.WEEKLY:
            params['byweekday'] = [iso[n] for n in data['week_days']]

        elif params['freq'] == rrule.MONTHLY:
            if 'on' == data['month_option']:
                ordinal = data['month_ordinal']
                day = iso[data['month_ordinal_day']]
                params['byweekday'] = day(ordinal)
            else:
                params['bymonthday'] = data['each_month_day']

        elif params['freq'] == rrule.YEARLY:
            params['bymonth'] = data['year_months']
            if data['is_year_month_ordinal']:
                ordinal = data['year_month_ordinal']
                day = iso[data['year_month_ordinal_day']]
                params['byweekday'] = day(ordinal)
                
        elif params['freq'] != rrule.DAILY:
            raise NotImplementedError(_(u'Unknown interval rule %s') % params['freq'])

        return params
        

