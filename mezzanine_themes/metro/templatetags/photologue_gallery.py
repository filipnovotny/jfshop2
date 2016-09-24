from django import template

from photologue.models import Gallery

register = template.Library()

@register.simple_tag
def gallery_public_by_title(gallery_title):    
    return Gallery.objects.get(title=gallery_title).public()
