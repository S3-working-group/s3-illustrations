"""Build gallery pages to browse illustrations."""

import os

INDEX_TEMPLATE = """---
title: The Sociocracy 3.0 Illustration Repository
---

# Browse Illustrations

![](/img/%(lang)s-48px.png)

"""

GALLERY_TEMPLATE = """---
title: The Sociocracy 3.0 Illustration Repository
---

# Browse %(dir)s (%(lang)s)

![](/img/%(lang)s-48px.png)

[Back](index-%(lang)s.html)

"""


def make_galleries():

    for language in os.listdir('png'):
        with (file('docs/gallery/index-%s.md' % language, 'w')) as index:
            index.write(INDEX_TEMPLATE % dict(lang=language))
            for d in sorted(os.listdir(os.path.join('png', language))):
                index.write("- [%s](/gallery/index-%s-%s.html)\n" % (d, language, d))
                with (file("docs/gallery/index-%s-%s.md" % (language, d), 'w+')) as gallery:
                    gallery.write(GALLERY_TEMPLATE % dict(dir=d, lang=language))
                    for i in sorted(os.listdir(os.path.join('png', language, d))):
                        gallery.write("## %s\n\n" % i)
                        gallery.write("[![](/img/%(lang)s/%(dir)s/%(img)s)](/img/%(lang)s/%(dir)s/%(img)s)\n\n" % dict(lang=language, dir=d, img=i))
                    gallery.write("----")
                    gallery.write("[Back](index-%s.html)\n" % language)


if __name__ == "__main__":
    make_galleries()
