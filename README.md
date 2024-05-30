# README

This application is an API that gives access to a collection of Pokemons and Types, the data coming from another Pokemon library API, **pokeapi.co**.

You wil be able to make 5 requests to the API, show and index for Pokemons and Types, and a request for synchronization with pokeapi API.

This API is currently deployed on this [heroku app](https://pokemon-by-nicosek-6af5ebf307c8.herokuapp.com/)

## Requests
### Types
* `GET index "/types"`
```json
[
  {
    "id": 1,
    "name": "normal",
    "url": "http://www.pokemon-by-nicosek.com/types/1"
  },
  {
    "id": 2,
    "name": "fighting",
    "url": "http://www.pokemon-by-nicosek.com/types/2"
  },
  ...
]
```
* `GET show "/types/:id"`
```json
{
  "id": 1,
  "name": "normal",
  "damage_multipliers_from_types": [
    {
      "from_type_id": 2,
      "value": 2
    },
    {
      "from_type_id": 8,
      "value": 0
    }
  ],
  "damage_multipliers_to_types": [
    {
      "to_type_id": 6,
      "value": 0.5
    },
    {
      "to_type_id": 9,
      "value": 0.5
    },
    {
      "to_type_id": 8,
      "value": 0
    }
  ],
  "pokemons": [
    {
      "id": 16,
      "name": "pidgey",
      "url": "http://www.pokemon-by-nicosek.com/pokemons/16"
    },
    ...
  ]
}
```

### Pokemons
* `GET index "/pokemons"`
```json
[
  {
    "id": 1,
    "name": "bulbasaur",
    "url": "http://www.pokemon-by-nicosek.com/pokemons/1"
  },
  {
    "id": 2,
    "name": "ivysaur",
    "url": "http://www.pokemon-by-nicosek.com/pokemons/2"
  },
  ...
]
```
* `GET show "/pokemons/:id"`
```json
{
  "id": 1,
  "name": "bulbasaur",
  "base_experience": 64,
  "height": 7,
  "weight": 69,
  "order": 1,
  "is_default": true,
  "types": [
    {
      "id": 12,
      "name": "grass",
      "url": "http://www.pokemon-by-nicosek.com/types/12"
    },
    {
      "id": 4,
      "name": "poison",
      "url": "http://www.pokemon-by-nicosek.com/types/4"
    }
  ]
}
```

### Synchronize with poke-api data
You can add missing entries in your database from poke-api by triggering this action :
`POST "/synchronize_with_poke_api"`
It will add entries from poke-api that are not present in the app database.

## How to clone that API

You can try this app on a develoment environment by cloning the project :
* Retrieve this folder by typing this command in your terminal :
  ```
  git clone https://github.com/nicosek/pokemon-by-nicosek/nicosek/pokemon-by-nicosek
  ```
  (More details on this procedure [here](https://docs.github.com/fr/repositories/creating-and-managing-repositories/cloning-a-repository))
* Go to the local folder of the repository and launch a bundle command :
  ```
  cd "folder/path/pokemon-by-nicosek"
  bundle install
  ```
* Create database and trigger migrations
  ```
  rails db:create
  rails db:migrate
  ```
* Seed the database with data from poke-api
  ```
  rails db:seed
  ```
* Launch the server
  ```
  rails s
  ```

That's it, you can communicate with the API at `http://localhost:3000` !

