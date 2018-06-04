

site:
	-rm -r docs/img/en
	mkdir docs/img/en
	cp -r png/en/140dpi/* docs/img/en
	-rm -r docs/img/de
	mkdir docs/img/de
	cp -r png/de/140dpi/* docs/img/de

	-rm docs/gallery/*
	python make_galleries.py
	cd docs;jekyll build

downloads:
	-rm docs/s3-illustrations-en.zip
	zip -r docs/s3-illustrations-en.zip png/en LICENSE readme.txt

	-rm docs/s3-illustrations-de.zip
	zip -r docs/s3-illustrations-de.zip png/de LICENSE readme.txt
