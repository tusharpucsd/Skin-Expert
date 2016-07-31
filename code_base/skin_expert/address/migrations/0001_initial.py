# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Country'
        db.create_table(u'address_country', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(unique=True, max_length=200)),
            ('code', self.gf('django.db.models.fields.IntegerField')(default=0, unique=True)),
        ))
        db.send_create_signal(u'address', ['Country'])

        # Adding model 'State'
        db.create_table(u'address_state', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('country', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['address.Country'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=200)),
        ))
        db.send_create_signal(u'address', ['State'])

        # Adding unique constraint on 'State', fields ['country', 'name']
        db.create_unique(u'address_state', ['country_id', 'name'])

        # Adding model 'City'
        db.create_table(u'address_city', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('state', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['address.State'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=200)),
        ))
        db.send_create_signal(u'address', ['City'])

        # Adding unique constraint on 'City', fields ['state', 'name']
        db.create_unique(u'address_city', ['state_id', 'name'])


    def backwards(self, orm):
        # Removing unique constraint on 'City', fields ['state', 'name']
        db.delete_unique(u'address_city', ['state_id', 'name'])

        # Removing unique constraint on 'State', fields ['country', 'name']
        db.delete_unique(u'address_state', ['country_id', 'name'])

        # Deleting model 'Country'
        db.delete_table(u'address_country')

        # Deleting model 'State'
        db.delete_table(u'address_state')

        # Deleting model 'City'
        db.delete_table(u'address_city')


    models = {
        u'address.city': {
            'Meta': {'unique_together': "(('state', 'name'),)", 'object_name': 'City'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'state': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['address.State']"})
        },
        u'address.country': {
            'Meta': {'object_name': 'Country'},
            'code': ('django.db.models.fields.IntegerField', [], {'default': '0', 'unique': 'True'}),
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