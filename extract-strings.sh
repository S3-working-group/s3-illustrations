ls -b src | xargs -I {} og6-translate extract  "src/{}"
mkdir translations
mv src/*.pot translations/
