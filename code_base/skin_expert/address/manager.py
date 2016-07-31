from .models import City, State,Country


class AddressManager(object):
    
    def save_address(self, form):
        """
        """
        country_name = form['country']
        state_name = form['state']
        city_name = form['city']
        try:
            country = Country.objects.get(name__iexact = country_name)
        except Country.DoesNotExist:
            country = Country.objects.create(name= country_name)
        try:
            state = State.objects.get(name__iexact=state_name, country=country)
        except State.DoesNotExist:
            state = State.objects.create(name=state_name, country=country)
            
        try:
            city = City.objects.get(name__iexact=city_name, state=state)
        except City.DoesNotExist:
            city = City.objects.create(name=city_name, state=state)
            
        return city
        
        
        