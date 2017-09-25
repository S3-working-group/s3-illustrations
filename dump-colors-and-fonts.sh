mkdir tmp
cd tmp
ls -b ../src | xargs -I {} ogtool dump "../src/{}"
ogtool run-plugin combine_colors_and_fonts ../dummy.graffle --config ../collect.yaml
mv combined.* ..
rm  ../dummy-combine_colors_and_fonts.graffle