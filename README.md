# tourist

## Build Process

1. Build and Push config to gcr, it uses alpine as a container to help with download/upload size
2. Push the server files, i.e. Symfony project into master/dev.



## Under the hood

what happens is the following:

1. building the server:

   This happens by grabbing the config from the GCR that we pushed -- this is safe, we needs creditionals to pull and it's located privately.

   Then we copy the latest files from the 'dev' or 'master' branch.

   we combine then and perform `composer install` to get all the dependencies.

   The resulting image is fairly large, and contains composer, something we don't need in a prod environment, which is important for the next step.

   we copy all the dependencies to an nginx image, it will be the final product of our work, with the serving server.


2. Final Product:

   a. I used nginx as a server just because I like it :smile:,

   b. I used php-fpm on port 9000 on the cluster network

   c. MySQL is served via a helm chart, with persistence and all.

3. Serving content:

   just run the following images:

   	- nginx
   	- php-fpm
   	- mysql 'from helm'

   with this service:

   - tourists-nginx (to expose nginx to the public)
   - tourists-php (to php things...)

4. 