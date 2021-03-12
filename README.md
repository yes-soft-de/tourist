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
#### get Region By PlaceId
```
//regionbyplaceid/{placeId}
methods={"GET"}
```
#### Create image (region or event)
```
/image
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
#### Register guide
```
/guide
methods={"POST"}
```
#### Update guide Profile 
```
/guide 
methods={"PUT"}
```
#### Get all guided
```
/guides
methods={"GET"}
```
#### guid by PlaceId
```
/guide
methods={"GET"}
```
#### guid by UserId
```
/guidebyuseriD/{userId}
methods={"GET"}
```
### Orders System

------------


### Case one, Tourist select one of guides in region:
#### Create order
```
/order
methods={"POST"}
```
###### Order status = "waitingPayment"
###### GuidUserID = must send in request
####Update order
```
/order
methods={"PUT"}
```
#### Get all tourist orders
```
order/{touristUserID}
methods={"GET"}
```
#### Get all orders by GuidUserID
```
guideorder/{guidUserID}
methods={"GET"}
key='id'
```
### Case two Tourist asks for guides:
#### Create order
```
/order
methods={"POST"}
```
###### Order status = "pending"
###### GuidUserID = Null (must NOT send in request)

#### Get tourist orders matches Guid cites and languages
```
orderlookup/{guidUserID}
methods={"GET"}
```
#### Accept tourist order by guid
```
/acceptorder
methods={"POST"}
```
#### Get accepted order
```
acceptorder/{touristUserID}
methods={"GET"}
```
#### When tourist select guid from his accepted orders then update order to put guidUserID and status to "paid" if must pay at first
```
/order
methods={"PUT"}
```
#### Also update accepted order statue to be "selected" for not include it in "get accepted order" API
```
/acceptorder
methods={"PUT"}
```

### Events System

------------
#### Create Event
```
/event
methods={"POST"}
```

#### Get all Events
```
/event
methods={"GET"}
```

#### Get event by id
```
/event/{eventID}
methods={"GET"}
```

### Payment

------------
#### Create payment
```
/payment
methods={"POST"}
```

#### Update payment
```
/payment
methods={"PUT"}
```

#### Get all payments
```
/payment
methods={"GET"}
```

#### Get payment by id
```
/payment/{id}
methods={"GET"}
```

#### Get payments by touristUserID
```
/paymenttourist/{id}
methods={"GET"}
```

#### Get payment by guidUserID
```
/paymentguide/{id}
methods={"GET"}
```
