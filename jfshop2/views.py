from django.template.response import TemplateResponse
from mezzanine.pages.page_processors import processor_for

from photologue.models import Gallery
from django.views.generic import View
    
class IndexView(View):
	def get(self, request):
		featured_gallery = Gallery.objects.get(title="featured_frontpage").public()
		return TemplateResponse(request, "index.html",{"featured_gallery": featured_gallery}).render();
