from selectable.base import ModelLookup
from selectable.registry import registry
from users.models import UserProfile


class UserLookupByRole(ModelLookup):
    """
    """
    model = UserProfile
    search_fields = ('role__code',)
    
    def get_item_id(self, item):
        """
        """
        return item.user_id
    
    def get_item_value(self, item):
        """
        """
        return item.user.id
    
    def get_item_label(self, item):
        """
        """
        return item.user.get_full_name()
    
    def format_results(self, raw_data, options):
        results = {
            'data': [self.format_item(item) for item in raw_data]
        }
        return results


registry.register(UserLookupByRole)
