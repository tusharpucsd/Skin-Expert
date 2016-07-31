# Create your views here.
from django.views.generic import ListView
from .models import City, State,Country
from django.utils import simplejson as json
from django.http import HttpResponse

def typeahead_autocomplete(request):
    """
        For typehead autocomplete
    """
    country_query = request.GET.get('country','')
    city_query = request.GET.get('city','')
    state_query = request.GET.get('state','')
    result_list = []
    if(len(country_query) > 0):
        results = Country.objects.filter(name__istartswith=country_query)
        result_list = [item.name.capitalize() for item in results]
    elif(len(city_query) > 0)  :
        results = City.objects.filter(name__istartswith=city_query)
        result_list = [{'label':x.name,'id':x.id,'state':x.state.name,'value':x.name.capitalize(),'country':x.state.country.name.capitalize()} for x in results]
        #result_list = [ item.name for item in results ]
    elif (len(state_query) > 0)  :
        results = State.objects.filter(name__istartswith=state_query)
        result_list = [{'label':x.name,'id':x.id,'country':x.country.name.capitalize(),'value':x.name.capitalize()} for x in results]
    else:
        result_list = []

    response_text = json.dumps(result_list, separators=(',',':'))
    return HttpResponse(response_text, content_type="application/json")
    
    