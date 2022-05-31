# README

API:
https://open-api-swagger.herokuapp.com/api/v1/todos 

OPEN API DOCS:
https://open-api-swagger.herokuapp.com/api/v1/todos/api-docs

### Ruby & Rails version
  * 2.7.4
  * Rails 6

### System dependencies
##### Gems:
  * rswag
  * figaro 
  * jwt 
  * rack-cors
  * rack-reducer
##### External services:
  * uses auth0 for authorization

### Database creation
  * set up postgresql on your system
  * `rake db:create`

### Database initialization
  * `rake db:migrate`
  * `rake db:seed`

### How to run the test suite
 Use `rake rswag:specs:swaggerize` to run open api tests.

 Use `spec/generate_token.rb` to request an auth0 token to test the API.

 You can use the following in bash:
```
export TOKEN=‘<received token>’

curl --request GET   --url https://open-api-swagger.herokuapp.com/api/v1/todos   --header "authorization: Bearer $TOKEN"   --header 'content-type: application/json'

curl --request GET   --url https://open-api-swagger.herokuapp.com/api/v1/todos/5   --header "authorization: Bearer $TOKEN"   --header 'content-type: application/json'


curl --request POST  --url https://open-api-swagger.herokuapp.com/api/v1/todos   --header "authorization: Bearer $TOKEN"   --header 'content-type: application/json'  --data '{ "api_v1_todo": { "task": "terminar dibujo" } }

curl   --request   PUT   --url https://open-api-swagger.herokuapp.com/api/v1/todos/5   --header "authorization: Bearer $TOKEN"   --header 'content-type: application/json'  --data '{ api_v1_todo": { "task": "hacer mate" } }'
```

### Deployment instructions
  * `git push heroku main`
  * Procfile has rake commands to set up database


