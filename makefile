
# get paths and stuff
# defines
# EXPORTSCRIPT
# SOURCEPATH
# EXPORTPATH
include make-conf-local
EXPORTARGS=scale=2 resolution=2 scope="entire document"


# usage: ./ogexport.js <source> <format> <target> <property_1=value_1>...<property_n>=<value_n>
# e.g.  ./ogexport.js /Users/beb/dev/ogtool/JXA/test-data/test-data.graffle PNG /Users/beb/tmp/fat scale=2 resolution=2
# full path to document and export is required because this JS stuff sucks, define them in make-conf-local
# transparent background: 
# resolution=1.94444441795 scale=1.0 drawsbackground=0 scope="entire document"
# SVG: scope="entire document"


# $(call export_language,src,en-tmp,PNG)
define export_language
	ogexport.js $(SOURCEPATH)/$(1)/agreements.graffle $(3) $(EXPORTPATH)/$(2)/agreements $(EXPORTARGS)
	ogexport.js $(SOURCEPATH)/$(1)/circle.graffle $(3) $(EXPORTPATH)/$(2)/circle scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/collaboration-values.graffle $(3) $(EXPORTPATH)/$(2)/collaboration-values scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/context.graffle $(3) $(EXPORTPATH)/$(2)/context scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/driver-domain.graffle $(3) $(EXPORTPATH)/$(2)/driver-domain scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/evolution.graffle $(3) $(EXPORTPATH)/$(2)/evolution scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/framework.graffle $(3) $(EXPORTPATH)/$(2)/framework scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/illustrations.graffle $(3) $(EXPORTPATH)/$(2)/illustrations scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/meetings.graffle $(3) $(EXPORTPATH)/$(2)/meetings scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/process.graffle $(3) $(EXPORTPATH)/$(2)/process scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/structural-patterns.graffle $(3) $(EXPORTPATH)/$(2)/structural-patterns scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/templates.graffle $(3) $(EXPORTPATH)/$(2)/templates scale=2 resolution=2 scope="entire document"
	ogexport.js $(SOURCEPATH)/$(1)/workflow-and-value.graffle $(3) $(EXPORTPATH)/$(2)/workflow-and-value scale=2 resolution=2 scope="entire document"
endef

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
	cd docs; bundle exec jekyll build

downloads:
	-rm docs/s3-illustrations-en.zip
	zip -r docs/s3-illustrations-en.zip png/en LICENSE readme.txt

	-rm docs/s3-illustrations-de.zip
	zip -r docs/s3-illustrations-de.zip png/de LICENSE readme.txt

	-rm docs/s3-illustrations-fr.zip
	zip -r docs/s3-illustrations-fr.zip png/fr LICENSE readme.txt

crowdin:
	#  crowdin --identity ~/crowdin-s3-illustrations.yaml upload sources  --dryrun
	echo crowdin --identity ~/crowdin-s3-illustrations.yaml upload sources -b update-2018-06

extract-strings:
	# untested
	ls -b graffle/src | xargs -I {} ogtranslate extract  "graffle/src/{}"
	mkdir text/src
	mv graffle/src/*.pot text/src/

translate:
	# untested
	# make translate lang=de
	ogtranslate translate graffle/src/ "graffle/$(lang)/" "text/$(lang)/"

xprt-en:
	-mkdir png/en-tmp
	$(call export_language,src,en-tmp,PNG)

xprt-de:
	-mkdir png/de-tmp
	$(call export_language,de,de-tmp,PNG)

xprt-fr:
	-mkdir png/fr-tmp
	$(call export_language,fr,fr-tmp,PNG)

xprt-svg:
	-mkdir png/en-svg
	$(call export_language,src,en-svg,SVG)

