
echo "workon omnigraffle_export"

mkdir en/png/140dpi-transp
ls -b src | xargs -I {} og6-export png "src/{}" en/png/140dpi-transp @140dpi-transp.ini

mkdir _export/en/png/140dpi/
ls -b src | xargs -I {} og6-export png "src/{}" en/png/140dpi @140dpi.ini

