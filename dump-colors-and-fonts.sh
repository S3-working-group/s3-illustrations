ls -b src | xargs -I {} ogtool dump "src/{}" -v
ogtool run-plugin combine_colors_and_fonts dummy.graffle collect.yaml
rm  dummy-combine_colors_and_fonts.graffle