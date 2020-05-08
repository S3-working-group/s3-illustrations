
echo "workon omnigraffle_export"

# export png
ls -b graffle/src | xargs -I {} ogexport png "graffle/src/{}" png/en/140dpi @140dpi.ini

# export png with transparent background
ls -b graffle/src | xargs -I {} ogexport png "graffle/src/{}" png/en/140dpi-transp @140dpi-transp.ini


