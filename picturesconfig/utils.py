from photologue.models import Gallery, PhotoSize
from mezzanine.conf import settings
import json

def write_file():
	galleries = Gallery.objects.all();
	for gallery in galleries:
		print("pics in " + gallery.title)
		pics = get_pics_with_sizes(gallery);
		with open("%s/%s.json" % (settings.MEDIA_ROOT,gallery.slug), "w") as text_file:
			text_file.write(json.dumps({"data" : pics}))


def get_pics_with_sizes(featured_gallery):
	photosizes = PhotoSize.objects.all()
	pics = []
	for pic in featured_gallery.public():
		thumbs = []
		width = pic.image.width
		height = pic.image.height
		if 'Image Orientation' in pic.EXIF() and pic.EXIF().get('Image Orientation').values[0] > 4:
			width = pic.image.height
			height = pic.image.width

		for pz in photosizes:
			thumbs.append(
					{
						"path" : pic._get_SIZE_url(pz.name),
						"width" : pic._get_SIZE_size(pz.name)[0],
						"height" : pic._get_SIZE_size(pz.name)[1]
					}
				)

		pics.append(
				{
					"label" : pic.title,
					"path"	: pic.image.url,
					"thumbs": thumbs,
					"width" : width,
					"height" : height
				}
			)

	return pics