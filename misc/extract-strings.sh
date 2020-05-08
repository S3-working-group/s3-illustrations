ls -b graffle/src | xargs -I {} ogtranslate extract  "graffle/src/{}"
mkdir text/src
mv graffle/src/*.pot text/src/
