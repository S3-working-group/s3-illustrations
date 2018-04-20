"""Build gallery pages to browse illustrations."""

import os

INDEX_TEMPLATE = """
---
title: The Sociocracy 3.0 Illustration Repository
---

# Browse Illustrations

![](/img/%(lang)s-48px.png)

"""

GALLERY_TEMPLATE = """
---
title: The Sociocracy 3.0 Illustration Repository
---

# Browse %(dir)s (%(lang)s)

![](/img/%(lang)s-48px.png)

[Back](index_%(lang)s.html)

"""


def make_galleries():

    for language in os.listdir('png'):
        print language
        with (file('docs/gallery/index_%s.md' % language, 'w')) as index:
            index.write(INDEX_TEMPLATE % dict(lang=language))
            for d in os.listdir(os.path.join('png', language, '140dpi')):
                index.write("- [%s](/gallery/index_%s_%s.html)\n" % (d, language, d))
                with (file("docs/gallery/index_%s_%s.md" % (language, d), 'w+')) as gallery:
                    index.write(GALLERY_TEMPLATE % dict(dir=d, lang=language))
                    for i in os.listdir(os.path.join('png', language, '140dpi', d)):
                        gallery.write("## %s\n\n" % i)
                        gallery.write("![](/img/%(lang)s/%(dir)s/%(img)s)\n\n" % dict(lang=language, dir=d, img=i))
                    index.write("[Back](index_%s.html)\n" % language)


if __name__ == "__main__":
    make_galleries()
