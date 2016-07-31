from django.db import models
from django.utils.translation import ugettext as _

# Create your models here.
class Country(models.Model):
	
	name = models.CharField(max_length=200, unique=True)
	dial_code = models.CharField(max_length=200, blank=True, null=True)
	code = models.CharField(max_length=200)
	
	def __unicode__(self):
		return self.name.capitalize()
	
	class Meta:
		verbose_name_plural = _('Countries')
		ordering = ['dial_code']


class State(models.Model):
	
	country = models.ForeignKey(Country)
	name = models.CharField(max_length=200)
	
	class Meta:
		unique_together = ('country', 'name')
		
	def __unicode__(self):
		return self.name.capitalize()
		
		
class City(models.Model):
	
	state = models.ForeignKey(State)
	name = models.CharField(max_length=200)
	
	class Meta:
		unique_together = ('state', 'name')
	
	def __unicode__(self):
		return "%s (%s)"%(self.name.capitalize(), self.state.name)