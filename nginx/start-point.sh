#!/bin/bash

cp -R /var/tourists /var/www/html 
chown -R www-data -R /var/www/html 
chmod -R 777 /var/www/html
echo 'Done Copying!'