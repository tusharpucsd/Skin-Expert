# Create your models here.
from django.db import models
from django.utils.translation import ugettext_lazy as _

from users.models import UserProfile

from datetime import timedelta
from django.utils import timezone
from skin_expert.config import episode_number_limit, initial_episode_id



OPTION_CHOICES = (
          ('advice', _('Advice & no follow up')),
          ('followup', _('Advice & follow up')),
          ('referral', _('Advice & urgent referral')),
          )

RATINGS = (
          (0, _('Green')),
          (1, _('Yellow')),
          (2, _('Red')),
          )

STATUS  = (
          ('assigned', _('Assigned to doctor')),
          ('invalid', _('Take no action')),
          ('inprogress', _('Need follow up')),
          ('visit', _('See a Dermatologist')),
          ('completed', _('Done')),
          ('abort', _('Abort')),
          ('nodoctor', _('No Doctor available')),
          )

FLAGS = (
         ('A', _('Active')),
         ('I', _('InActive')),
         ('D', _('Deleted')),
         )


def _generate_job_number():
    
    month, year = "%0.2d" % (timezone.now().month), str(((timezone.now()).year))[-2:]
    episode_no = "EP%s%s" % (year, month)
    try:
        episode_last_digit = int((Episode.objects.filter(episode_no__startswith=episode_no).latest("submitted_at").episode_no)[6:])
        if episode_last_digit > episode_number_limit:  
            episode_last_digit = episode_last_digit + 1
        else:  
            episode_last_digit = "%0.3d" % (episode_last_digit + 1)
        episode_no = "%s%s" % (episode_no, episode_last_digit)
    except:
        episode_no = "%s%s" % (episode_no, initial_episode_id)

    try:
        episode_obj = Episode.objects.get(episode_no=episode_no)
        if episode_obj:
            _generate_job_number()
    except:
        pass

    return episode_no 

class Patient(models.Model):
    profile = models.OneToOneField(UserProfile, related_name='patient')
    dob = models.DateField(_('Date of Birth'))
    code = models.CharField(max_length=10, db_index=True)
    ethnic_origin = models.CharField(max_length=255, blank=True, null=True)
    
    smokes = models.BooleanField(_('Do you smoke'))
    alcohol = models.BooleanField(_('Do you drink'))
    
    allergies = models.TextField(_('Known allergies'), blank=True, null=True)
    prev_disease  = models.TextField(_('Previous diagnoses of skin disease'),
                                     blank=True, null=True)
    
    current_medication = models.TextField(_('Current medication (if any)'), blank=True, null=True)
    family_history = models.TextField(_('Family history of skin disease'), blank=True, null=True)
    
    alcohol_quantity = models.CharField(_('How much you drink'),max_length=255, 
                                        blank=True, null=True)
    
    smoke_frequency = models.CharField(_('How oftenly you smoke'),max_length=255, 
                                        blank=True, null=True)
    
    other_disease = models.TextField(_('Other Disease'), blank=True, null=True)
    
    is_activated = models.BooleanField()
    
    def __unicode__(self):
        return self.profile.user.username
    
    def get_full_name(self):
        return "%s %s"%(self.profile.user.first_name, self.profile.user.last_name)
    
    def do_smokes(self):
        return "True" if self.smokes else "False"
    
    def do_alcohol(self):
        return "True" if self.alcohol else "False"
    

class Episode(models.Model):
    patient = models.ForeignKey(Patient, related_name='episodes')
    image1 = models.ImageField(upload_to='uploads/%Y/%m/%d', blank=True, null=True)
    image2 = models.ImageField(upload_to='uploads/%Y/%m/%d', blank=True, null=True)
    submitted_at = models.DateTimeField(blank=True, null=True)
    completion_date = models.DateField(blank=True, null=True)
    actual_completion_date = models.DateField(blank=True, null=True)
    feedback = models.TextField(blank=True, null=True)
    episode_no = models.CharField(max_length=90, default=_generate_job_number, unique=True, blank=True, null=True)
    comments = models.TextField(blank=True, null=True)
    status = models.CharField(max_length=128, choices=STATUS, blank=True, null=True)
    smokes = models.BooleanField(_('Do you smoke'))
    alcohol = models.BooleanField(_('Do you drink'))
    
    allergies = models.TextField(_('Known allergies'), blank=True, null=True)
    prev_disease  = models.TextField(_('Previous diagnoses of skin disease'),
                                     blank=True, null=True)
    
    current_medication = models.TextField(_('Current medication (if any)'), blank=True, null=True)
    family_history = models.TextField(_('Family history of skin disease'), blank=True, null=True)
    
    alcohol_quantity = models.CharField(_('How much you drink'),max_length=255, 
                                        blank=True, null=True)
    
    smoke_frequency = models.CharField(_('How oftenly you smoke'),max_length=255, 
                                        blank=True, null=True)
    
    other_disease = models.TextField(_('Other Disease'), blank=True, null=True)
    
    class Meta:
        ordering = ['-submitted_at', '-episode_no']
    
    def __unicode__(self):
        return "%s-%s"%(self.patient, self.submitted_at.isoformat())
    
    def save(self, *args, **kwargs):
        if not self.completion_date:
            self.submitted_at = timezone.now()
            self.completion_date = self.submitted_at.date() + timedelta(days=2)
        super(Episode, self).save(*args, **kwargs)
    
    def get_title(self):
        return "Test"
    
    def get_image1(self):
        return self.image1.url
    
    def get_image2(self):
        return self.image2.url if self.image2 else "None"
    
    def get_feedback(self):
        return self.feedback if self.feedback else "None"


class Task(models.Model):
    episode = models.ForeignKey(Episode, related_name='tasks')
    assigned_to = models.ForeignKey(UserProfile, related_name='tasks')
    created_by = models.ForeignKey(UserProfile, related_name='created_by', blank=True, null=True)
    ratings = models.IntegerField(choices=RATINGS, blank=True, null=True, default=0)
    completion_date = models.DateField(blank=True, null=True)
    status = models.CharField(max_length=128, choices=STATUS, blank=True, null=True)
    
#    class Meta:
#        ordering = ['-completion_date', '-episode__submitted_at']
    
    def save(self, *args, **kwargs):
        if not self.id and not self.completion_date:
            self.completion_date = self.episode.completion_date
        super(Task, self).save(*args, **kwargs)
        
        
class Question(models.Model):
    question = models.TextField()
    flag = models.CharField(choices=FLAGS, max_length=1, blank=True, null=True, default='A')
    
    def __unicode__(self):
        return self.question
    
    
class Option(models.Model):
    question = models.ForeignKey(Question)
    content = models.TextField()
    flag = models.CharField(choices=FLAGS, max_length=1, blank=True, null=True)
    
    def __unicode__(self):
        return self.content
    
    
class EpisodeQuestionOption(models.Model):
    question = models.ForeignKey(Question)
    episode = models.ForeignKey(Episode, related_name='episode')
    option = models.ForeignKey(Option)