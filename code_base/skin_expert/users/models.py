from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from address.models import City

# Create your models here.
class Role(models.Model):
    code = models.CharField(max_length=20)
    name = models.CharField(max_length=128)
    
    def __unicode__(self):
        return self.name
    
class UserProfile(models.Model):
    user = models.OneToOneField(User, related_name='profile')
    role = models.ForeignKey(Role, verbose_name =_('Group'), blank=True, null=True)
    mobile_no = models.CharField(_('Mobile No'), blank=True, null=True, max_length=30)
    phone_no = models.CharField(_('Phone No'), blank=True, null=True, max_length=30)
    address = models.TextField(_('Address'), blank=True, null=True)
    street = models.CharField(_('Street'), blank=True, null=True, max_length=255)
    landmark = models.CharField(_('Landmark'), blank=True, null=True, max_length=255)
    city = models.ForeignKey(City)
    pincode = models.CharField(_('ZipCode/ Pincode'), blank=True, null=True, max_length=10)
#     mobile_code = models.PositiveSmallIntegerField('mobile_code', blank=True, null=True, max_length=10)
#     phone_code = models.PositiveSmallIntegerField('phone_code',blank=True, null=True,  max_length=10)
    
    def __unicode__(self):
        return self.user.username.capitalize()
            