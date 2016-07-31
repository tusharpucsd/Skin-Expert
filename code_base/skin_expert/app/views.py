from django.core.mail import EmailMessage
from django.conf import settings
from django.contrib.auth import authenticate, login as auth_login, logout
from django.db.models import Count
from django.template.loader import render_to_string
from django.template import RequestContext
from django.shortcuts import redirect

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import generics

from datetime import timedelta
import os

from patients.models import Patient, Episode, Task
from tasks.models import Job
from users.models import UserProfile
from availability.models import Occurrence
from .serializer import LoginSerializer, EpisodeSerializer, ProfileSerializer, ChangePasswordSerializer, \
                        ForgotPasswordSerializer
                        
from rest_framework.authentication import SessionAuthentication                        
from rest_framework.permissions import AllowAny
import logging

class UnsafeSessionAuthentication(SessionAuthentication):

    def authenticate(self, request):
        http_request = request._request
        user = getattr(http_request, 'user', None)

        if not user or not user.is_active:
            return None

        return user, None
    
class AppLoginView(APIView):
    
    
    
    authentication_classes = (UnsafeSessionAuthentication,)
    permission_classes = (AllowAny,)
    
    def get(self, request):
        content = {
            'user': unicode(request.user),  # `django.contrib.auth.User` instance.
            'auth': unicode(request.auth),  # None
        }
        return Response(content)
    
    
    def post(self, request):
        # import ipdb
        # ipdb.set_trace()
        status = 'False'
        message = ''
        data = request.DATA
        serializer = LoginSerializer(data=data)
        
        if serializer.is_valid():
            username = data['username']
            password = data['password']
        
            try:
                patient = Patient.objects.get(profile__user__username = username )
                
                if not patient.is_activated and 'passcode' not in data:
                    message = 'Please enter passcode provided to unlock your app.'
                elif not patient.is_activated and patient.code != data['passcode']:
                    message = 'Please enter valid passcode provided to unlock your app.'
                else:
                    user = authenticate(username=username,password=password)
                    if user and user.is_authenticated():
                        auth_login(request, user)
                        status = 'True'
                        message = 'User logged in successfully'
                        #request.session['passcode'] = patient.code
                        #request.session['username'] = data['username']
                        #request.user = user
                        
                        content = {
                            'contact_no': '1234567890',  # `django.contrib.auth.User` instance.
                            'email': 'pradnyam@leotechnosoft.net',  # None
                        }
                        
                        if not patient.is_activated and 'passcode' in data and patient.code == data['passcode']:
                            patient.is_activated = True
                            patient.save()
                        
                        content['message'] = message
                        content['status'] = status
                        return Response(content)
                    else:
                        message = 'Invalid credentials.'
                        return Response({'message': message, 'status':status})
            except Patient.DoesNotExist:
                message = 'Invalid passcode.'
                return Response({'message': message, 'status':status})
        else:
            message = 'Please enter proper details to log in.'
            message = ",".join([v[0] for v in serializer.errors.values()])
            return Response({'message': message, 'status':status})
 
class AppLogOutView(APIView):
    
    def get(self, request):
        logout(request)
        return Response({'message': 'logged out successfully'})
     
        
class AppForgotPasswordView(APIView):
    serializer_class = ForgotPasswordSerializer
    authentication_classes = (UnsafeSessionAuthentication,)
    permission_classes = (AllowAny,)
    
    def get(self, request ):
        content = {
            'user': unicode(request.user),  # `django.contrib.auth.User` instance.
            'auth': unicode(request.auth),  # None
        }
        return Response(content)
    
    def post(self, request):
        status = 'False'
        message = ''
        data = request.DATA
        serializer = ForgotPasswordSerializer(data=data)
        
        if serializer.is_valid():
            email = data['email']
            code = data['passcode']
            password = data['password']
            
            try:
                patient = Patient.objects.get(code = code, profile__user__email = email )
                #password =  ''.join(random.choice(string.ascii_lowercase + string.digits) for x in range(6))
                patient.profile.user.set_password(password)
                patient.profile.user.save()
                
                SUBJECT = 'Change password request | Skin Experts'
                CONTENT = 'Your password has been reset as requested.<br /> Your new password is "%s". <br />' % password
                email = EmailMessage(SUBJECT, CONTENT, settings.EMAIL_HOST_USER, to=[email])
                email.content_subtype = "html"
                email.send()
                    
                status = 'True'
                message = 'Password set successfully'
                    
            except Patient.DoesNotExist:
                message = 'Invalid passcode.'
        else:
            message = ",".join([v[0] for v in serializer.errors.values()])
        
        return Response({'message': message, 'status':status})
    
class AppEditProfileView(APIView):
       
    authentication_classes = (UnsafeSessionAuthentication,)
        
    def get(self, request, *args, **kwargs):
        patient = Patient.objects.get(profile__user=request.user) 
        serializer = ProfileSerializer(patient, many=False)
        return Response(serializer.data)
        
    def post(self, request):
        status = 'False'
        message = ''
        data = request.DATA
        
        try:
            patient_fields = ['dob', 'ethnic_origin', 'prev_disease', 'current_medication', 
                              'family_history', 'allergies', 'alcohol_quantity', 'smoke_frequency', 'other_disease']
            
            required_fields = ['dob', 'name', 'email']
            
            
            for field in required_fields:
                missing_fields = []
                if field not in data:
                    missing_fields.append(field.capitalize())
                    
                if missing_fields:
                    message = 'Please provide ' + ','.join(missing_fields)
                    return Response({'message': message, 'status':status})
            d = {}
            for field in patient_fields:
                d[field] = data[field]
                
            patient = Patient.objects.get(profile__user=request.user)
            patient.__dict__.update(d)
            
            patient.smokes = eval(data['smokes'])
            patient.alcohol = eval(data['alcohol'])
            
            if 'name' in data:
                first_name, last_name = data['name'].split(' ')
                patient.profile.user.first_name = first_name
                patient.profile.user.last_name = last_name
            
            if 'email' in data:
                patient.profile.user.email = data['email']
            
            patient.profile.user.save()
            patient.save()
            
            status = 'True'
            message = 'User Profile changed successfully'
                
        except Patient.DoesNotExist:
            message = 'Please log in.'
    
        
        return Response({'message': message, 'status':status})
    
    

class EpisodeAddView(APIView):
    
    authentication_classes = (UnsafeSessionAuthentication,)
        
    def get(self, request):
        try:
            Patient.objects.get(code=request.session['passcode'], profile__user__username = request.session['username'])
            return Response()
        except:
            return Response({'message': 'Please log in'})        
    
    def post(self, request):
        status = 'False'
        message = ''                        
        if len(request.FILES.getlist('image')) > 0 and len(request.FILES.getlist('image')) <= 2:
            
            episode_dict = {}
            index = 1
            for img in request.FILES.getlist('image'):
                episode_dict['image%d'%index] = img
                index += 1
            
            data = request.POST
            try:
                patient = Patient.objects.get( profile__user = request.user)
                episode_dict['patient'] = patient
                
                patient_details = ['smokes','alcohol', 'allergies','prev_disease', 'current_medication', 'family_history', 
                                   'alcohol_quantity', 'smoke_frequency', 'other_disease']
                
                for key in patient_details:
                    episode_dict[key] = patient.__dict__[key]
                    
                if 'comments' in data:
                    episode_dict['comments'] = data['comments']
                    
                
                episode = Episode.objects.create(**episode_dict)
                
                ### Assign Doctor and update episode with status
                start_date = episode.submitted_at
                end_date = episode.completion_date
                first_end_date = episode.completion_date
                
                doctors_present = []
                
                if Occurrence.objects.filter(date__gte =start_date).count() < 1:
                    doctor = UserProfile.objects.filter(role__code ='doctor').order_by('?')[0].id
                else:
                    # Search for next available doctor
                    while len(doctors_present) == 0:
                        doctors_present = Occurrence.objects.filter(date__range=[start_date, end_date]).values('doctor')
                        end_date = end_date + timedelta(days = 2)
                    
                
                    # Search the doctor with minimum task load
                    doctor = Task.objects.filter(assigned_to__in= doctors_present).values('assigned_to').annotate(no_of_tasks= Count('id')).order_by('no_of_tasks')
                
                    if len(doctor) > 0:
                        doctor = doctor[0]['assigned_to']
                    else:
                        doctor = doctors_present[0]['doctor']
                    
 
                Task.objects.create(episode=episode, assigned_to_id= doctor, completion_date= end_date, status='assigned')

                # If episode completion date (plus 2 days since added at end of while) is not equal to end_date
                if first_end_date + timedelta(days=2) != end_date:
                    
                    # Change status to No doctor available. and assign job to call center guy to contact patient.
                    episode.status = 'nodoctor'
                    Job.objects.create(episode_no=episode.episode_no, 
                                       assigned_to= UserProfile.objects.filter(role__code ='callcenter').order_by('?')[0], 
                                       status='a', action='p',
                                       comments= 'No doctor available till %s, contact Patient' % end_date.isoformat()
                                       )
                else:
                    episode.status = 'assigned'
                
                episode.save()
                
                status = 'True'
                message = 'Episode created successfully'
      
            except Patient.DoesNotExist:
                message = 'Invalid passcode.'
        else:
            message = 'Please provide at least one image.'
        
        return Response({'message': message, 'status':status})


class ReportListView(generics.ListAPIView):
    serializer_class = EpisodeSerializer
    authentication_classes = (UnsafeSessionAuthentication,)
    
    def list(self, request):
        try:
            
            self.queryset = Episode.objects.filter(patient__profile__user = request.user)
            serializer = self.get_serializer(self.queryset, many=True)
            return Response({'reports': serializer.data})
        
        except Exception as e:
            return Response({'message': 'Error occured while fetching the reports' + str(e) })    
        
        
        
class ReportDetailView(generics.RetrieveAPIView):
    
    def retrieve(self, request, **kwargs):
#         import ipdb
#         ipdb.set_trace()
        episode = Episode.objects.get(episode_no = kwargs.get('id'))
        content = render_to_string('patient_management/patient_report.html', {'episode': episode, 'host': request._request.META['HTTP_HOST']}, context_instance= RequestContext(request))
        
        file_path = os.path.join(settings.MEDIA_ROOT, 'reports')
        
        if not os.path.exists(file_path):
            os.makedirs(file_path)
        
        file = open(os.path.join(file_path,'%s.html'%episode.episode_no),'wb')
        file.write(content.encode('UTF-8'))
        file.close()
        logging.error("test")
        dest_path = os.path.join(file_path,'%s.pdf'%episode.episode_no)
        os.system("xvfb-run --auto-servernum wkhtmltopdf '%s' '%s' "%(os.path.join(file_path,'%s.html'%episode.episode_no), dest_path))
        
        try:
            os.remove(os.path.join(file_path,'%s.html'%episode.episode_no))
        except OSError:
            pass    
        
        return redirect('http://%s/media/reports/%s.pdf'%(request._request.META['HTTP_HOST'], episode.episode_no))
        
        

class AppChangePasswordView(APIView):

    serializer_class = ChangePasswordSerializer
    authentication_classes = (UnsafeSessionAuthentication,)
        
    def get(self, request):
        try:            
            content = {
            'user': unicode(request.user),  # `django.contrib.auth.User` instance.
            'auth': unicode(request.auth),  # None
            }
            return Response(content)
        except:
            return Response({'message': 'Please log in'})
    
    def post(self, request):
        status = 'False'
        message = ''
        data = request.DATA
        serializer = ChangePasswordSerializer(data=data)
        if serializer.is_valid():
            try:
                patient = Patient.objects.get(profile__user = request.user)
                patient.profile.user.set_password(data['password'])
                status = 'True'
                message = 'Password changed successfully'
            except Patient.DoesNotExist:
                message = 'Patient doesnot exists.'
        else:
            message = ",".join([v[0] for v in serializer.errors.values()])
        
        return Response({'message': message, 'status':status})
    
class AppContactView(APIView):
    
    def get(self, request ):
        content = {
            'contact_no': '1234567890',  # `django.contrib.auth.User` instance.
            'email': 'pradnyam@leotechnosoft.net',  # None
        }
        return Response(content)      

