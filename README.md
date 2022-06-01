# README

API:
https://open-api-swagger.herokuapp.com/api/v1/todos 

OPEN API DOCS:
https://open-api-swagger.herokuapp.com/api-docs/index.html

This app was created using:
```ruby
rails new api --api --database=postgresql \
--skip-turbolinks --skip-action-text --skip-action-mailbox \
--skip-action-mailer --skip-action-cable --skip-javascript
```


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
  * jbuilder
##### External services:
  * uses auth0 for authorization

### Configuration
- enable CORS config/initializers/cors.rb`
- set default format as json in config/routes.rb
- set Auth0 variables in `config/auth0.yml` & Auth0 initializer
`
### Database creation
  * set up postgresql on your system
  * gem pg
  * `rake db:create`

### Database initialization
  * `rake db:migrate`
  * `rake db:seed`

### How to run the test suite
 Use `rake rswag:specs:swaggerize` to run open api tests.

 Use `spec/generate_token.rb` to request an auth0 token to test the API. Open a rails console:
 ```bash
 rails c
 ```
 Generate the token:
```ruby
require_relative 'spec/generate_token.rb'
GenerateToken.test_token
```

 You can use the following in bash:
```bash
export TOKEN=‘<received token>’

curl --request GET  \
--url https://open-api-swagger.herokuapp.com/api/v1/todos \
--header "authorization: Bearer $TOKEN" \
--header 'content-type: application/json'

curl --request GET  \
--url https://open-api-swagger.herokuapp.com/api/v1/todos/5 \
--header "authorization: Bearer $TOKEN" \ 
--header 'content-type: application/json'


curl --request POST \ 
--url https://open-api-swagger.herokuapp.com/api/v1/todos   \
--header "authorization: Bearer $TOKEN"   \
--header 'content-type: application/json'  \
--data '{ "api_v1_todo": { "task": "terminar dibujo" } }'

curl   --request   PUT   \
--url https://open-api-swagger.herokuapp.com/api/v1/todos/5   \
--header "authorization: Bearer $TOKEN"   \
--header 'content-type: application/json'  \
--data '{ api_v1_todo": { "task": "hacer mate" } }'
```

### Deployment instructions
  * `git push heroku main`
  * Procfile has rake commands to set up database


