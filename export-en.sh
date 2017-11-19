
echo "workon omnigraffle_export"

# export png
ls -b src | xargs -I {} ogexport png "graffle/src/{}" png/en/140dpi @140dpi.ini

# export png with transparent background
ls -b src | xargs -I {} ogexport png "src/{}" png/en/140dpi-transp @140dpi-transp.ini


