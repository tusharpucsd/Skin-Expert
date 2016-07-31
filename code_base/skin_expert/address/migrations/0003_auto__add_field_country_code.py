# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding field 'Country.code'
        db.add_column(u'address_country', 'code',
                      self.gf('django.db.models.fields.CharField')(default=datetime.datetime(2014, 1, 10, 0, 0), max_length=200),
                      keep_default=False)


    def backwards(self, orm):
        # Deleting field 'Country.code'
        db.delete_column(u'address_country', 'code')


    models = {
        u'address.city': {
            'Meta': {'unique_together': "(('state', 'name'),)", 'object_name': 'City'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'state': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['address.State']"})
        },
        u'address.country': {
            'Meta': {'object_name': 'Country'},
            'code': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'dial_code': ('django.db.models.fields.IntegerField', [], {'default': '0', 'unique': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '200'})
        },
        u'address.state': {
            'Meta': {'unique_together': "(('country', 'name'),)", 'object_name': 'State'},
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['address.Country']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        }
    }

    complete_apps = ['address']