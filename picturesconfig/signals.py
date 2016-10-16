from django.db.models.signals import post_save
from django.dispatch import receiver
from photologue.models import Photo,Gallery,PhotoSize
from picturesconfig.utils import write_file

@receiver(post_save, sender=Photo)
def update_pics_file(sender, created=False,**kwargs):
	if(created):	
		write_file()

@receiver(post_save, sender=PhotoSize)
def update_pics_file(sender, created=False,**kwargs):
	if(created):	
		write_file()

@receiver(post_save, sender=Gallery)
def update_pics_file(sender, created=False,**kwargs):	
	write_file()