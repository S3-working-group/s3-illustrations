
echo "workon omnigraffle_export"

# export png
ls -b src | xargs -I {} og6-export png "src/{}" en/png/140dpi @140dpi.ini

# export png with transparent background
ls -b src | xargs -I {} og6-export png "src/{}" en/png/140dpi-transp @140dpi-transp.ini


