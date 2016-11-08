# Simmer

## Getting started

All requests are scoped to a project. Access is available via an API key
authorisation in the `Authorization` header. The `Content-Type` header
must be `application/json`.

A new project can be created using the Mix task
`simmer.create_project <project_name>`:

```
mix simmer.create_project Lee
`Lee` created with API key `d8syIErMsvhU-ktwn7tqqWpngcqPOUcQ`
```

This API key will be used in the examples that follow.

## API

### API keys

#### `GET /api_keys`

**Request**

```
curl --request GET \
  --url http://localhost:4000/api/api_keys \
  --header 'authorization: d8syIErMsvhU-ktwn7tqqWpngcqPOUcQ' \
  --header 'content-type: application/json'
```

**Response**

```json
{
	"api_keys": [
		{
			"name": "API key",
			"key": "d8syIErMsvhU-ktwn7tqqWpngcqPOUcQ"
		}
	]
}
```

### Lists

#### `GET /lists`
#### `POST /lists`
#### `GET /lists/:id`
#### `PATCH /lists/:id`
#### `DELETE /lists/:id`

### Contacts

#### `GET /contacts`
#### `POST /contacts`
#### `GET /contacts/:email`
#### `PATCH /contacts/:email`
#### `DELETE /contacts/:email`
