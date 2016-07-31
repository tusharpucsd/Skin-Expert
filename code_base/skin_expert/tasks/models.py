from django.db import models
from users.models import UserProfile
from django.utils.translation import ugettext_lazy as _
from datetime import timedelta
from django.utils import timezone


STATUS  = (
          ('a', _('Active')),
          ('i', _('In progress')),
          ('d', _('Done')),
          )

ACTIONS = (
           ('a', _('Assign to Doctor')),
           ('c', _('Book appointment')),
           ('p', _('Contact Patient')),
         )

class Query(models.Model):
    episode_no = models.CharField(max_length=90)
    feedback = models.TextField()
    


class Job(models.Model):
    #query = models.OneToOneField(Query)
    episode_no = models.CharField(max_length=90)
    assigned_to = models.ForeignKey(UserProfile)
    status = models.CharField(max_length=128, choices=STATUS, blank=True, null=True, default='a')
    comments = models.TextField()
    submitted_at = models.DateField(blank=True, null=True, auto_now_add=True)
    action = models.CharField(max_length=128, choices=ACTIONS, blank=True, null=True, default='a')
    call_date = models.DateField(blank=True, null=True)
    summary = models.TextField(blank=True, null=True)
    completion_date = models.DateField(blank=True, null=True)
    actual_completed_date = models.DateField(blank=True, null=True)
   
    
    def save(self, *args, **kwargs):
        if not self.completion_date:
            self.submitted_at = timezone.now()
            self.completion_date = self.submitted_at.date() + timedelta(days=2)
        super(Job, self).save(*args, **kwargs)
    
    
    
