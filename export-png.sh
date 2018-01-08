
echo "workon omnigraffle_export"

# export png
ls -b "graffle/$1" | xargs -I {} ogexport png "graffle/$1/{}" "png/$1/140dpi" @140dpi.ini

# export png with transparent background
ls -b "graffle/$1" | xargs -I {} ogexport png "graffle/$1/{}" "png/$1/140dpi-transp" @140dpi-transp.ini


