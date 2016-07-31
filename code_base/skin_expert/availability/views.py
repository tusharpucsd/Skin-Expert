import calendar
import itertools
from datetime import datetime, timedelta

from django.shortcuts import render, redirect
from django.http import Http404
from availability.models import Occurrence
from availability import utils, forms
from availability.conf import settings as swingtime_settings

from dateutil import parser
from skin_expert.decorator import group_required
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
import operator
from django.http import HttpResponse
from django.template import RequestContext
from django.utils import simplejson
 
if swingtime_settings.CALENDAR_FIRST_WEEKDAY is not None:
    calendar.setfirstweekday(swingtime_settings.CALENDAR_FIRST_WEEKDAY)

@login_required
@group_required('mgmtteam','sysadmin','callcenter','doctor')
def set_event(
    request, 
    template='availability/event_popup.html'
):
    '''
    Add a new ``Event`` instance and 1 or more associated ``Occurrence``s.
    
    Context parameters:
    
    dtstart
        a datetime.datetime object representing the GET request value if present,
        otherwise None
    
    event_form
        a form object for updating the event

    recurrence_form
        a form object for adding occurrences
    
    '''
    if request.method=="GET":
        date = request.GET.get('date')
        date = datetime.strptime(date, '%d-%m-%Y')
        context = RequestContext(request, {'date':date})

        return render(
                      request,
                      template,
                      context
                      )
    else:
        date = datetime.strptime(request.POST.get('date'), '%d-%m-%Y')
        until= datetime.strptime(request.POST.get('until'), '%d-%m-%Y')
        params = {'until': until}
        status = Occurrence.objects.add_occurrences(
            request.user.profile, 
            date,
            **params
        )
        return HttpResponse(simplejson.dumps({'stat': status}))
    
#-------------------------------------------------------------------------------
@login_required
@group_required('mgmtteam','sysadmin','callcenter','doctor')
def add_event(
    request, 
    template='availability/add_event.html',
    recurrence_form_class=forms.MultipleOccurrenceForm
):
    '''
    Add a new ``Event`` instance and 1 or more associated ``Occurrence``s.
    
    Context parameters:
    
    dtstart
        a datetime.datetime object representing the GET request value if present,
        otherwise None
    
    event_form
        a form object for updating the event

    recurrence_form
        a form object for adding occurrences
    
    '''   
   
    dtstart = None
    if request.method == 'POST':        
        recurrence_form = recurrence_form_class(request.POST)
        if recurrence_form.is_valid():
            status = recurrence_form.save()
            if status:
                return redirect('today')
            else:
                raise Http404
    else:
        if 'dtstart' in request.GET:
            try:
                dtstart = parser.parse(request.GET['dtstart'])
            except:
                # TODO A badly formatted date is passed to add_event
                pass
        
        dtstart = dtstart or datetime.now()
        recurrence_form = recurrence_form_class(initial={'dtstart': dtstart, 'doctor': request.user })
            
    return render(
        request,
        template,
        {'dtstart': dtstart, 'recurrence_form': recurrence_form}
    )


#-------------------------------------------------------------------------------
@login_required
@group_required('mgmtteam','sysadmin','callcenter','doctor')
def _datetime_view(
    request, 
    template, 
    dt, 
    timeslot_factory=None, 
    items=None,
    params=None
):
    '''
    Build a time slot grid representation for the given datetime ``dt``. See
    utils.create_timeslot_table documentation for items and params.
    
    Context parameters:
    
    day
        the specified datetime value (dt)
        
    next_day
        day + 1 day
        
    prev_day
        day - 1 day
        
    timeslots
        time slot grid of (time, cells) rows
        
    '''
    timeslot_factory = timeslot_factory or utils.create_timeslot_table
    params = params or {}
    
    return render(request, template, {
        'day':       dt, 
        'next_day':  dt + timedelta(days=+1),
        'prev_day':  dt + timedelta(days=-1),
        'timeslots': timeslot_factory(dt, items, **params)
    })


#-------------------------------------------------------------------------------
@login_required
@group_required('mgmtteam','sysadmin','callcenter','doctor')
def year_view(request, year, template='availability/yearly_view.html', queryset=None):
    '''

    Context parameters:
    
    year
        an integer value for the year in questin
        
    next_year
        year + 1
        
    last_year
        year - 1
        
    by_month
        a sorted list of (month, occurrences) tuples where month is a 
        datetime.datetime object for the first day of a month and occurrences
        is a (potentially empty) list of values for that month. Only months 
        which have at least 1 occurrence is represented in the list
        
    '''
    year = int(year)
    queryset = queryset._clone() if queryset else Occurrence.objects.select_related()
    if request.user.profile.role and request.user.profile.role.code == 'doctor':
        occurrences = queryset.filter(date__year=year, doctor=request.user.profile)
    else:
        occurrences = sorted(queryset.filter(date__year=year), key=operator.attrgetter('date'))

    def group_key(o):
        return datetime(
            year,
            o.date.month,
            1
        )

    return render(request, template, {
        'year': year,
        'by_month': [(dt, list(o)) for dt,o in itertools.groupby(occurrences, group_key)],
        'next_year': year + 1,
        'last_year': year - 1
        
    })


#-------------------------------------------------------------------------------
@login_required
@group_required('mgmtteam','sysadmin','callcenter','doctor')
def month_view(
    request, 
    year=datetime.today().year, 
    month=datetime.today().month, 
    template='availability/monthly_view.html',
    queryset=None
):
    '''
    Render a tradional calendar grid view with temporal navigation variables.

    Context parameters:
    
    today
        the current datetime.datetime value
        
    calendar
        a list of rows containing (day, items) cells, where day is the day of
        the month integer and items is a (potentially empty) list of occurrence
        for the day
        
    this_month
        a datetime.datetime representing the first day of the month
    
    next_month
        this_month + 1 month
    
    last_month
        this_month - 1 month
    
    '''
    
    year, month = int(year), int(month)
    cal         = calendar.monthcalendar(year, month)
    dtstart     = datetime(year, month, 1)
    last_day    = max(cal[-1])
    dtend       = datetime(year, month, last_day)
    can_add = False

    # TODO Whether to include those occurrences that started in the previous
    # month but end in this month?
    queryset = queryset._clone() if queryset else Occurrence.objects.select_related()
    if request.user.profile.role and request.user.profile.role.code == 'doctor':
        can_add = True
        occurrences = queryset.filter(date__year=year, date__month=month, doctor=request.user.profile)
    else:
        occurrences = sorted(queryset.filter(date__year=year, date__month=month), key=operator.attrgetter('date'))
        
    def date(o):
        return o.date.day
           
    by_day = dict([(dt, list(o) ) for dt,o in itertools.groupby(occurrences, date)])
    
        
    data = {
        'today':      datetime.now(),
        'calendar':   [[(d, by_day.get(d, [])) for d in row] for row in cal], 
        'this_month': dtstart,
        'next_month': dtstart + timedelta(days=+last_day),
        'last_month': dtstart + timedelta(days=-1),
        'can_add': can_add
    }
    
    return render(request, template, data)

