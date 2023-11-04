#!/bin/bash

# great posts on duplicity on https://blog.xmatthias.com/
# but i don't need a sophisticated backup solution like that.
# the below is better
# https://medium.com/@Benlemt/create-a-daily-file-backup-system-under-linux-with-google-drive-4a1cd9f528b 
# when following instructions at the end need to add a test user  in 'OAuth consent screen'

cd ~/Desktop

#title='saved.tar.gz'
title='save-'`date +”%m-%d”`'.tar.gz'

tar -czvf $title toUpload

gupload $title

#rm $title

