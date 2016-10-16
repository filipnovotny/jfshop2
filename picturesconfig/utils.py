from photologue.models import Gallery, PhotoSize
from mezzanine.conf import settings
import json

def write_file():
	pics = get_pics_with_sizes();	
	with open("%s/pics.json" % settings.MEDIA_ROOT, "w") as text_file:
		text_file.write(json.dumps({"data" : pics}))

	return pics

def get_pics_with_sizes():
	photosizes = PhotoSize.objects.all();
	featured_gallery = Gallery.objects.get(title="Mes créations").public()
	pics = []
	for pic in featured_gallery:
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