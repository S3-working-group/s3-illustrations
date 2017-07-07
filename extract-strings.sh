ls -b src | xargs -I {} og6-translate extract  "src/{}"
mv src/*.pot translations/