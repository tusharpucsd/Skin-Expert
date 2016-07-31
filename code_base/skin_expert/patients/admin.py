from django.contrib import admin
from .models import Patient, Episode, Task, Question, Option, EpisodeQuestionOption
from django.db import models
from django.forms import TextInput, Textarea


class OptionInline(admin.TabularInline):
    model = Option
    extra = 2
    formfield_overrides = {
                           models.TextField: {'widget': Textarea(attrs={'rows':4, 'cols':40})}
                           }


class QuestionAdmin(admin.ModelAdmin):
    fieldsets = [
                 (None, {'fields' : ['question']}),
                 ]
    formfield_overrides = {
                           models.TextField: {'widget': Textarea(attrs={'rows':4, 'cols':70})}
                           }
    inlines = [OptionInline]


class OptionAdmin(admin.ModelAdmin):
    list_display = ('question', 'content', 'flag')


class EpisodeQuestionOptionAdmin(admin.ModelAdmin):
    list_display = ('episode', 'question', 'option')


admin.site.register(Patient)
admin.site.register(Episode)
admin.site.register(Task)
admin.site.register(Question, QuestionAdmin)
admin.site.register(Option, OptionAdmin)
admin.site.register(EpisodeQuestionOption, EpisodeQuestionOptionAdmin)