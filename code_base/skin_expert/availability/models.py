from datetime import datetime

from django.utils.translation import ugettext_lazy as _
from django.db import models
from users.models import UserProfile

from dateutil import rrule
from django.db import IntegrityError

#===============================================================================
class OccurrenceManager(models.Manager):
    
    use_for_related_fields = True
    
    #---------------------------------------------------------------------------
    def daily_occurrences(self, dt=None):
        '''
        Returns a queryset of for instances that have any overlap with a 
        particular day.
        
        * ``dt`` may be either a datetime.datetime, datetime.date object, or
          ``None``. If ``None``, default to the current day.
        
        '''
        dt = dt or datetime.now()
        
        qs = self.filter(
            date = dt
        )
        
        return qs
    
    def add_occurrences(self, doctor, date, **rrule_params):
        '''
        Add one or more occurences to the event using a comparable API to 
        ``dateutil.rrule``. 
        
        If ``rrule_params`` does not contain a ``freq``, one will be defaulted
        to ``rrule.DAILY``.
        
        Because ``rrule.rrule`` returns an iterator that can essentially be
        unbounded, we need to slightly alter the expected behavior here in order
        to enforce a finite number of occurrence creation.
        
        If both ``count`` and ``until`` entries are missing from ``rrule_params``,
        only a single ``Occurrence`` instance will be created using the exact
        ``start_time`` and ``end_time`` values.
        '''       
        rrule_params.setdefault('freq', rrule.DAILY)
        
        status = True
        if 'count' in rrule_params and rrule_params['count'] == 1 and 'until' not in rrule_params:
            try:
                Occurrence.objects.create(doctor=doctor, date=date)
            except IntegrityError:
                status = False
                
        else:
            
            for ev in rrule.rrule(dtstart=date, **rrule_params):
                
                try:
                    Occurrence.objects.create(doctor=doctor, date=ev)
                except IntegrityError as e:
                    print e
                    status = False
                    break
        return status


#===============================================================================
class Occurrence(models.Model):
    '''
    Represents the start end time for a specific occurrence of a master ``Event``
    object.
    '''
    doctor = models.ForeignKey(UserProfile)
    date = models.DateField()
    objects = OccurrenceManager()

    #===========================================================================
    class Meta:
        verbose_name = _('occurrence')
        verbose_name_plural = _('occurrences')
        unique_together = ('doctor', 'date')

    #---------------------------------------------------------------------------
    def __unicode__(self):
        return u'%s: %s' % (self.doctor, self.date.isoformat())


    

   
