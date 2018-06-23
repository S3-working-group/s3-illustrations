

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

crowdin:
	#  crowdin --identity ~/crowdin-s3-illustrations.yaml upload sources  --dryrun
	crowdin --identity ~/crowdin-s3-illustrations.yaml upload sources -b update-2018-06

extract-strings:
	# untested
	ls -b graffle/src | xargs -I {} ogtranslate extract  "graffle/src/{}"
	mkdir text/src
	mv graffle/src/*.pot text/src/

translate:
	# untested
	# make translate lang=de
	ogtranslate translate graffle/src/ "graffle/$(lang)/" "text/$(lang)/"

export-src:
	echo "workon omnigraffle_export"

	# export png
	ls -b graffle/src | xargs -I {} ogexport png "graffle/src/{}" png/en/140dpi @140dpi.ini

	# export png with transparent background
	ls -b graffle/src | xargs -I {} ogexport png "graffle/src/{}" png/en/140dpi-transp @140dpi-transp.ini

export: 
	echo "workon omnigraffle_export"

	# export png
	ls -b "graffle/$(lang)" | xargs -I {} ogexport png "graffle/$(lang)/{}" "png/$(lang)/140dpi" @140dpi.ini

	# export png with transparent background
	ls -b "graffle/$(lang)" | xargs -I {} ogexport png "graffle/$(lang)/{}" "png/$(lang)/140dpi-transp" @140dpi-transp.ini

dump-colors-and-fonts:
	# untested
	mkdir tmp
	cd tmp
	ls -b ../src | xargs -I {} ogtool dump "../graffle/src/{}"
	ogtool run-plugin combine_colors_and_fonts ../dummy.graffle --config ../collect.yaml
	mv combined.* ..
	rm  ../dummy-combine_colors_and_fonts.graffle
