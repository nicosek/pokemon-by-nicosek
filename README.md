# README

This application is an API that gives access to a collection of Pokemons and Types, the data coming from another Pokemon library API, **pokeapi.co**.

You wil be able to make 4 requests to the API, show and index for Pokemons and Types.

## Requests

* GET index "/types"
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
* GET show "/types/:id"
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
