from mezzanine.pages.page_processors import processor_for

from photologue.models import Gallery


@processor_for("/")
def featured_gallery(request, page):
    featured_gallery = Gallery.objects.get(title="featured_frontpage").public()
    return {"featured_gallery": featured_gallery}