from django import template

register = template.Library()


@register.filter
def get_the_value(key, values):    
    for item in values:
        if item[0] == key:
            return item[1] 
    else:
        return key   
    
@register.filter
def div(value, arg):
    "Divides the value by the arg"
    return int(value) / int(arg)
