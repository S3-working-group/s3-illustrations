
# get paths and stuff
# defines
# EXPORTSCRIPT
# SOURCEPATH
# EXPORTPATH
include make-conf-local



site:
	-rm -r docs/img/en
	mkdir docs/img/en
	cp -r png/en/* docs/img/en
	-rm -r docs/img/de
	mkdir docs/img/de
	cp -r png/de/* docs/img/de
	-rm -r docs/img/fr
	mkdir docs/img/fr
	cp -r png/fr/* docs/img/fr

	-rm docs/gallery/*
	python make_galleries.py
	cd docs;jekyll build

downloads:
	-rm docs/s3-illustrations-en.zip
	zip -r docs/s3-illustrations-en.zip png/en LICENSE readme.txt

	-rm docs/s3-illustrations-de.zip
	zip -r docs/s3-illustrations-de.zip png/de LICENSE readme.txt

	-rm docs/s3-illustrations-fr.zip
	zip -r docs/s3-illustrations-fr.zip png/fr LICENSE readme.txt

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
	ls -b graffle/src | xargs -I {} ogexport png "graffle/src/{}" png/en/ @140dpi.ini

	# export png with transparent background
	# ls -b graffle/src | xargs -I {} ogexport png "graffle/src/{}" png/en/140dpi-transp @140dpi-transp.ini

export: 
	echo "workon omnigraffle_export"

	# export png
	ls -b "graffle/$(lang)" | xargs -I {} ogexport png "graffle/$(lang)/{}" "png/$(lang)" @140dpi.ini

	# export png with transparent background
	# ls -b "graffle/$(lang)" | xargs -I {} ogexport png "graffle/$(lang)/{}" "png/$(lang)/140dpi-transp" @140dpi-transp.ini

dump-colors-and-fonts:
	# untested
	mkdir tmp
	cd tmp
	ls -b ../src | xargs -I {} ogtool dump "../graffle/src/{}"
	ogtool run-plugin combine_colors_and_fonts ../dummy.graffle --config ../collect.yaml
	mv combined.* ..
	rm  ../dummy-combine_colors_and_fonts.graffle


jsexport:

	# usage: ./ogexport.js <source> <format> <target> <property_1=value_1>...<property_n>=<value_n>
	# e.g.  ./ogexport.js /Users/beb/dev/ogtool/JXA/test-data/test-data.graffle PNG /Users/beb/tmp/fat scale=2 resolution=2
	# full path to document and export is required because this JS stuff sucks, define them in make-conf-local

	$(EXPORTSCRIPT) $(SOURCEPATH)/src/agreements.graffle PNG $(EXPORTPATH)/agreements scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/circle.graffle PNG $(EXPORTPATH)/circle scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/collaboration-values.graffle PNG $(EXPORTPATH)/collaboration-values scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/context.graffle PNG $(EXPORTPATH)/context scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/driver-domain.graffle PNG $(EXPORTPATH)/driver-domain scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/evolution.graffle PNG $(EXPORTPATH)/evolution scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/facilitation-guides.graffle PNG $(EXPORTPATH)/facilitation-guides scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/framework.graffle PNG $(EXPORTPATH)/framework scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/illustrations.graffle PNG $(EXPORTPATH)/illustrations scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/meetings.graffle PNG $(EXPORTPATH)/meetings scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/models-of-management.graffle PNG $(EXPORTPATH)/models-of-management scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/pattern-group-headers.graffle PNG $(EXPORTPATH)/pattern-group-headers scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/pattern-groups.graffle PNG $(EXPORTPATH)/pattern-groups scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/process.graffle PNG $(EXPORTPATH)/process scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/structural-patterns.graffle PNG $(EXPORTPATH)/structural-patterns scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/templates.graffle PNG $(EXPORTPATH)/templates scale=2 resolution=2 scope="entire document"
	$(EXPORTSCRIPT) $(SOURCEPATH)/src/workflow-and-value.graffle PNG $(EXPORTPATH)/workflow-and-value scale=2 resolution=2 scope="entire document"



