# use new ogexport.js

# export png
ls -b graffle/src | xargs -I {} ogexport.js  "/Users/beb/Dropbox/projects/S3/resources/s3-illustrations/graffle/src/{}" PNG "/Users/beb/Dropbox/projects/S3/resources/s3-illustrations/png/en/140dpi/{}" resolution=1.94444441795 scale=1.0

# export png with transparent background
ls -b graffle/src | xargs -I {} ogexport.js  "/Users/beb/Dropbox/projects/S3/resources/s3-illustrations/graffle/src/{}" PNG "/Users/beb/Dropbox/projects/S3/resources/s3-illustrations/png/en/140dpi-transp/{}" resolution=1.94444441795 scale=1.0 drawsbackground=0

