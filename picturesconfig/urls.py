from picturesconfig.views import ConfigView
from mezzanine.conf import settings
from django.conf.urls import include, url

urlpatterns = [
	url("^$" , ConfigView.as_view(), name="configjson"),
]