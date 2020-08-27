# Setup

## Pre-setup

Clone the repository and cd into it

```
git clone git@github.com:kaka-ruto/graphql-on-rails-auth.git

cd graphql-on-rails-auth
```

## Setup

Create a `.env` file in the project directory and copy the environment variables in the `.env.sample` file into it

You need Ruby version 2.6.5 and Postgres database on your machine for this setup

You can install Ruby with either [asdf](https://asdf-vm.com/#/), [RVM](https://rvm.io/) or [rbenv](https://rvm.io/).

Once you have Ruby, Postgres and the env variables set up, run the following to install dependencies and create the database

```
bin/setup
```

The above task also seeds the database with the test data which you can use for testing. You can use the following credentials for testing

```
email: imani@amani.com
password: 1234
```

Start the server

```
bundle exec rails server
```

Go to http://localhost:3000

Go to http://localhost:3000/graphiql for the GraphQL explorer.

## GraphiQL IDE
GraphiQL is a handy tool that allows you to explore your GraphQL schema and even view it's documentation.

Below are all the queries and mutations that you can run against our schema.

It also contains the query variables(arguments) that are required during execution.

The variables are mock data, you can change them to your liking.

For the queries and mutations, you can add/remove fields depending on what you'd like to get back.

If you're setting up this project for the first time, delete all the example queries/mutations that come by default and copy and paste the ones below.

You can then uncomment the query/mutation you'd like to run below and copy it's subsequent query variables to the `Query Variables` window beneath.

The query variables expect JSON, use double quotes always and enclose with curly braces.

Please endeavour to update this list as the schema grows.

```
######## CREATE USER ########
# mutation createNewUser($input: CreateInput!) {
#   createUser(input: $input) {
#     user { id fullName email mobile },
#     errors { details fullMessages }
#   }
# }

# {
#   "input": {
#	    "firstName": "Imani",
#		"lastName": "Amani",
#       "email": "imani@amani.com",
#       "mobile": "+254700111222",
#       "password": "1234"
#   }
# }


######## GET USER ########
# query getSingleUser($id: ID!) {
#   showUser(id: $id) { id email fullName }
# }

# {
#   "id": 5
# }


######## GET CURRENT_USER ########
# query currentUser{
#   currentUser { id email fullName }
# }



######## LOGIN USER ########
# mutation loginUser($input: LoginInput!) {
#   loginUser(input: $input) {
#     user { id fullName email },
#     token,
#     message
#   }
# }

# {
#   "input": {
#     "email": "imani@amani.com",
#     "password": "1234"
#   }
# }


######## UPDATE USER ########
# mutation updateExistingUser($input: UpdateInput!) {
#   updateUser(input: $input) {
#     user { id fullName email },
#     errors
#   }
# }

# {
#   "input": {
#		"id": 5
#		"firstName": "Amani",
#		"lastName": "Imani",
#       "email": "imani@amani.com",
#   }
# }


######## DELETE USER ########
# mutation deleteExistingUser($input: DeleteInput!) {
#   deleteUser(input: $input) { message errors }
# }

# {
#   "id": 5
# }
