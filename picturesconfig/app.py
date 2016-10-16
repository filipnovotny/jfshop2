from django.apps import AppConfig

class PicturesConfigConfig(AppConfig):
    name = 'picturesconfig'

    def ready(self):
        import picturesconfig.signals