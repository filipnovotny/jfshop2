from django.contrib import admin
from mezzanine.pages.admin import PageAdmin
from .models import PageWithIcon,Portfolio

admin.site.register(PageWithIcon, PageAdmin)
admin.site.register(Portfolio, PageAdmin)
