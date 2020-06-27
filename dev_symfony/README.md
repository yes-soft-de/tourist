# Tourists Backend 🚧
*. env file and private-public keys not enclosed .*
## Project setup

### Composer thing
```
composer update
```
### Database setup
First add to** .env** file correct connection string
`DATABASE_URL=mysql://root@127.0.0.1:3306/tourists?serverVersion=5.7`

Then create database
```
php bin/console doctrine:database:create
```

After that make migration
```
php bin/console make:migration
```

Finaly run migration versions to create tables
```
php bin/console doctrine:migration:migrate
```

## API guide

#### Register tourist
```
/tourist 
methods={"POST"}
```
#### Update tourist
```
/tourist 
methods={"PUT"}
```
#### Create region
```
/region
methods={"POST"}
```
#### Get regions
```
/regions
methods={"GET"}
```
#### Get region details
```
/region/{id}
methods={"GET"}
```
#### Create region image (another ones)
```
/regionimage
methods={"POST"}
```
#### Create comment
```
/comment
methods={"POST"}
```
#### Create rating
```
/rating
methods={"POST"}
```