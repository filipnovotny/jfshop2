from django.template.response import TemplateResponse
from mezzanine.pages.page_processors import processor_for

from photologue.models import Gallery, PhotoSize
from django.views.generic import View

from django.http import JsonResponse

class ConfigView(View):
	def get(self, request):
		photosizes = PhotoSize.objects.all();
		featured_gallery = Gallery.objects.get(title="Mes créations").public()
		pics = []
		for pic in featured_gallery:
			thumbs = []
			for pz in photosizes:
				thumbs.append(
						{
							"path" : pic._get_SIZE_url(pz.name)
						}
					)
			
			pics.append(
					{
						"label" : pic.title,
						"path"	: pic.image.url,
						"thumbs": thumbs
					}
				)
				
		return JsonResponse({"data":pics})