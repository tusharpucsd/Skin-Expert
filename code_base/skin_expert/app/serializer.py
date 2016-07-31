from rest_framework import serializers
from patients.models import Episode, Patient

class EpisodeSerializer(serializers.ModelSerializer):
    ID = serializers.Field(source="episode_no")
    Title = serializers.Field(source="get_title")
    image1 = serializers.Field(source="get_image1")
    image2 = serializers.Field(source="get_image2")
    feedback = serializers.Field(source="get_feedback")
    
    class Meta:
        model = Episode
        fields = ("ID", 'image1', 'image2', 'comments', 'feedback', "Title")
        
class ProfileSerializer(serializers.ModelSerializer):
    
    name = serializers.Field(source="get_full_name")
    email = serializers.Field(source="profile.user.email")
    smokes = serializers.Field(source="do_smokes")
    alcohol = serializers.Field(source="do_alcohol")
    
    class Meta:
        model = Patient
        fields = ("name", 'email', "dob", "ethnic_origin", "prev_disease",
                  "current_medication", "family_history", "smokes", "alcohol", "allergies",
                  "alcohol_quantity", "smoke_frequency", "other_disease" )

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=50, error_messages={"required":"User name can't be blank.",
                                       "max_length":"User name can't extend 50 characters.", 
                                       "invalid": "Please provide valid user name."})
    
    
    password = serializers.CharField(error_messages={"required":"Password can't be blank."})
    
    passcode = serializers.CharField(required=False)
    

class ChangePasswordSerializer(serializers.Serializer):
    
    password = serializers.CharField(error_messages={"required":"Password can't be blank."})
    
    password1 = serializers.CharField(error_messages={"required":"Repeat Password can't be blank."})
    
    def validate(self, attrs):
        """
        Check that the start is before the stop.
        """
        if attrs['password'] != attrs['password1']:
            raise serializers.ValidationError("Passwords provided do not match.")
        return attrs

class ForgotPasswordSerializer(serializers.Serializer):
    
    email = serializers.EmailField(error_messages={"required":"Please provide proper email address" })
    
    passcode = serializers.CharField(error_messages={"required":"Passcode can't be blank."})
    
    password = serializers.CharField(error_messages={"required":"Password can't be blank."})
    