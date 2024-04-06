#!/bin/bash

# great posts on duplicity on https://blog.xmatthias.com/
# but i don't need a sophisticated backup solution like that.
# the below is better
# https://medium.com/@Benlemt/create-a-daily-file-backup-system-under-linux-with-google-drive-4a1cd9f528b 
# what i normally do (as i back up once in a blue moon and by then credentials have expired or sth) is i uninstall gupload (not sure needed)
# and delete .googledrive.conf. Then follow the steps in the link.
# in one of the steps 'consent screen' = 'oauth consent screen'
# when following instructions at the end need to add a test user  in 'OAuth consent screen'. Otherwise 'access blocked' error or sth
# TODO need to improve the above
# good read - https://labbots.github.io/google-drive-upload/


cd ~/Desktop

#title='saved.tar.gz'
# TODO add year
title='save-'`date +”%m-%d”`'.tar.gz'

tar -czvf $title toUpload

gupload  $title

#rm $title

