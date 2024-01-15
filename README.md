# user_auth_ddb-sys-api

## Version
1.0.0

## Installation
To install this package you need to have:

- Java 8
- Maven 3.5+

### Github actions secrets

| Secret | Description |
| --- | --- |
| ANYPOINT_ORGANIZATION_ID | Mulesoft organization id where application will be deployed |
| ANYPOINT_PLATFORM_CLIENT_ID | Client id of the anypoint platform environment |
| ANYPOINT_PLATFORM_CLIENT_SECRET | Client secret of the anypoint platform environment |
| ANYPOINT_PLATFORM_USERNAME | Username used to authorize with anypoint |
| ANYPOINT_PLATFORM_PASSWORD | Password used to authorize with anypoint |
| DECRYPTION_KEY | Key use to encrypt the secure properties |
| MAVEN_REPO_GITHUB_TOKEN | Github token used to get dependecies from internal maven repository, like common library |

### Github actions variables

| Variable | Description |
| --- | --- |
| ANYPOINT_OS2_ENABLED | Boolean value to set object store v2 enabled/disabled |
| ANYPOINT_REGION | Region where the application will be deployed |
| ANYPOINT_WORKERS_NUMBER | Number of workers for the application |
| ANYPOINT_WORKER_TYPE | Type of workers for the applicatio |
| APP_NAME | Application name which will be displayed in runtime manager |

## Usage
System API to handle connection with AWS Dynamo DB auth table.

Base uri
```
/api/v1/auth/credentials/
```

###  AUTH

**Sign up**

```
POST /signup
```

Parameteres

| Type | Name | Description |
| --- | --- | --- |
| Header | x-itsnooge-token-iss | JWT issuer |
| Header | client_id | Header required by Client ID Enforcement Policy |
| Header | client_secret | Header required by Client ID Enforcement Policy |

Body

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| email_address | string (email) | * | User email address (id) |
| password | string | * | User password |
| phone_number | string (email) |   | User phone number|

Example body

```json
{
    "email_address": "test_6@mail.com",
    "password": "testPassword6",
    "phone_number": "44 555555555"
}
```

Successful response (code 201)

| Name | Type | Description |
| --- | --- | --- |
| access_token | string | User accces token (60min duration) |
| refresh_token | string | User refresh token (7 days duration) |

Successfull response example

```json
{
    "access_token": "Bearer ewogICJhbGciOiAiSFMyNTYiLAogICJ0eXAiOiAiSldUIgp9.ewogICJpc3MiOiAicG9zdG1hbi10ZXN0cyIsCiAgInN1YiI6ICJ0ZXN0XzFAbWFpbC5jb20iLAogICJ0b2tlbl90eXBlIjogImFjY2Vzc190b2tlbiIsCiAgImlhdCI6IDE3MDUyNDExNTQsCiAgImV4cCI6IDE3MDUyNDQ3NTQKfQ.iAWxEudqlRbDKfzwp76T12nsMDU5CVaISNAlgDraogQ",
    "refresh_token": "Bearer ewogICJhbGciOiAiSFMyNTYiLAogICJ0eXAiOiAiSldUIgp9.ewogICJpc3MiOiAicG9zdG1hbi10ZXN0cyIsCiAgInN1YiI6ICJ0ZXN0XzFAbWFpbC5jb20iLAogICJ0b2tlbl90eXBlIjogInJlZnJlc2hfdG9rZW4iLAogICJpYXQiOiAxNzA1MjQxMTU0LAogICJleHAiOiAxNzA1ODQ1OTU0Cn0.3zl-9_DONbHzAAxbH4maIRLoc3y2Q4jcwvuh4l6mHXU"
}
```

**Sign in**

```
POST /signin
```

Parameteres

| Type | Name | Description |
| --- | --- | --- |
| Header | x-itsnooge-token-iss | JWT issuer |
| Header | client_id | Header required by Client ID Enforcement Policy |
| Header | client_secret | Header required by Client ID Enforcement Policy |

Body

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| email_address | string (email) | * | User email address (id) |
| password | string | * | User password |


Example body

```json
{
    "email_address": "test_6@mail.com",
    "password": "testPassword6",
}
```

Successful response (code 200)

| Name | Type | Description |
| --- | --- | --- |
| access_token | string | User accces token (60min duration) |
| refresh_token | string | User refresh token (7 days duration) |

Successfull response example

```json
{
    "access_token": "Bearer ewogICJhbGciOiAiSFMyNTYiLAogICJ0eXAiOiAiSldUIgp9.ewogICJpc3MiOiAicG9zdG1hbi10ZXN0cyIsCiAgInN1YiI6ICJ0ZXN0XzFAbWFpbC5jb20iLAogICJ0b2tlbl90eXBlIjogImFjY2Vzc190b2tlbiIsCiAgImlhdCI6IDE3MDUyNDExNTQsCiAgImV4cCI6IDE3MDUyNDQ3NTQKfQ.iAWxEudqlRbDKfzwp76T12nsMDU5CVaISNAlgDraogQ",
    "refresh_token": "Bearer ewogICJhbGciOiAiSFMyNTYiLAogICJ0eXAiOiAiSldUIgp9.ewogICJpc3MiOiAicG9zdG1hbi10ZXN0cyIsCiAgInN1YiI6ICJ0ZXN0XzFAbWFpbC5jb20iLAogICJ0b2tlbl90eXBlIjogInJlZnJlc2hfdG9rZW4iLAogICJpYXQiOiAxNzA1MjQxMTU0LAogICJleHAiOiAxNzA1ODQ1OTU0Cn0.3zl-9_DONbHzAAxbH4maIRLoc3y2Q4jcwvuh4l6mHXU"
}
```

**Sign out**

```
POST /signout
```

Parameteres

| Type | Name | Description |
| --- | --- | --- |
| Header | client_id | Header required by Client ID Enforcement Policy |
| Header | client_secret | Header required by Client ID Enforcement Policy |

Body

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| email_addres | string | * | User email address |

Example body

```json
{
    "email_address": "test_6@mail.com"
}
```

Successful response (code 204)

```
No content
```

**Refresh access token**

```
POST /refersh
```

Parameteres

| Type | Name | Description |
| --- | --- | --- |
| Header | x-itsnooge-token-iss | JWT issuer |
| Header | client_id | Header required by Client ID Enforcement Policy |
| Header | client_secret | Header required by Client ID Enforcement Policy |

Body

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| email_addres | string | * | User email address |
| refresh_token | string | * | Refresh token to get new pair of tokens |

Example body

```json
{
    "email_address": "test_6@mail.com",
    "refresh_token": "Bearer ewogICJhbGciOiAiSFMyNTYiLAogICJ0eXAiOiAiSldUIgp9.ewogICJpc3MiOiAicG9zdG1hbi10ZXN0cyIsCiAgInN1YiI6ICJ0ZXN0XzFAbWFpbC5jb20iLAogICJ0b2tlbl90eXBlIjogInJlZnJlc2hfdG9rZW4iLAogICJpYXQiOiAxNzA1MjQxMTU0LAogICJleHAiOiAxNzA1ODQ1OTU0Cn0.3zl-9_DONbHzAAxbH4maIRLoc3y2Q4jcwvuh4l6mHXU"
}
```

Successful response (code 200)

| Name | Type | Description |
| --- | --- | --- |
| access_token | string | User accces token (60min duration) |
| refresh_token | string | User refresh token (7 days duration) |

Successfull response example

```json
{
    "access_token": "Bearer ewogICJhbGciOiAiSFMyNTYiLAogICJ0eXAiOiAiSldUIgp9.ewogICJpc3MiOiAicG9zdG1hbi10ZXN0cyIsCiAgInN1YiI6ICJ0ZXN0XzFAbWFpbC5jb20iLAogICJ0b2tlbl90eXBlIjogImFjY2Vzc190b2tlbiIsCiAgImlhdCI6IDE3MDUyNDExNTQsCiAgImV4cCI6IDE3MDUyNDQ3NTQKfQ.iAWxEudqlRbDKfzwp76T12nsMDU5CVaISNAlgDraogQ",
    "refresh_token": "Bearer ewogICJhbGciOiAiSFMyNTYiLAogICJ0eXAiOiAiSldUIgp9.ewogICJpc3MiOiAicG9zdG1hbi10ZXN0cyIsCiAgInN1YiI6ICJ0ZXN0XzFAbWFpbC5jb20iLAogICJ0b2tlbl90eXBlIjogInJlZnJlc2hfdG9rZW4iLAogICJpYXQiOiAxNzA1MjQxMTU0LAogICJleHAiOiAxNzA1ODQ1OTU0Cn0.3zl-9_DONbHzAAxbH4maIRLoc3y2Q4jcwvuh4l6mHXU"
}
```

## Errors map

| Code | Message | Description | Returned code
| --- | --- | --- | --- |
| DDBAUTH-S-00001 | Unauthorized | User is signed out, it is necessary to sign in again | `401` |
| DDBAUTH-S-00002 | Bad Request | User with provided email address is already exists | `400` |
| DDBAUTH-S-00003 | Bad Request | User with provided email address is not exists | `400` |
| DDBAUTH-S-00004 | Internal Server Error | There was problem when trying to sign out, try again | `500` |
| DDBAUTH-S-00005 | Unauthorizied | Password does not match | `401` |
| DDBAUTH-S-00006 | Internal Server Error | There was problem when trying to sign in, try again | `500` |
| DDBAUTH-S-00007 | Unauthorized | Token does not match to the stored one | `401` |
| DDBAUTH-S-00008 | Internal Server Error | There was problem when trying to make change with the token, try again | `500` |

## Authors

- Mateusz Piotrowski - [mat-piotrowski](https://github.com/mat-piotrowski)


## License
This project is licensed under the MIT License - see the LICENSE.md file for details.
