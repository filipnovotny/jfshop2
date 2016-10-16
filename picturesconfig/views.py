from django.template.response import TemplateResponse
from mezzanine.pages.page_processors import processor_for

from django.views.generic import View

from django.http import JsonResponse
from picturesconfig.utils import write_file

class ConfigView(View):
	def get(self, request):
		pics = write_file()
				
		return JsonResponse({"data":pics})