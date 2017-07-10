ls -b src | xargs -I {} ogtranslate extract  "src/{}"
mkdir translations
mv src/*.pot translations/
