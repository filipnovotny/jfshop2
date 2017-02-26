from django.db import models
from mezzanine.pages.models import Page
from mezzanine.core.models import RichText
from photologue.models import Gallery

class PageWithIcon(Page, RichText):
	icon = models.CharField("icon",max_length=255)
	menustyle = models.CharField("menustyle",max_length=255)

	def get_icon(self):
		return self.icon
		
	def get_menustyle(self):
		return this.menustyle

class Portfolio(Page, RichText):
	photos = models.ManyToManyField(Gallery)
	icon = models.CharField("icon",max_length=255)
	menustyle = models.CharField("menustyle",max_length=255)
	
	def get_public_photos(self):
		return self.photos.public()
		
	def get_icon(self):
		return self.icon
		
	def get_menustyle(self):
		return this.menustyle