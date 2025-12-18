# Client SDK

## Overview

Authlete API: Welcome to the **Authlete API documentation**. Authlete is an **API-first service** where every aspect of the 
platform is configurable via API. This documentation will help you authenticate and integrate with Authlete to 
build powerful OAuth 2.0 and OpenID Connect servers. 🚀

At a high level, the Authlete API is grouped into two categories:

- **Management APIs**: Enable you to manage services and clients. 🔧
- **Runtime APIs**: Allow you to build your own Authorization Servers or Verifiable Credential (VC) issuers. 🔐

## 🌐 API Servers

Authlete is a global service with clusters available in multiple regions across the world:

- 🇺🇸 **US**: `https://us.authlete.com`
- 🇯🇵 **Japan**: `https://jp.authlete.com`
- 🇪🇺 **Europe**: `https://eu.authlete.com`
- 🇧🇷 **Brazil**: `https://br.authlete.com`

Our customers can host their data in the region that best meets their requirements.

## 🔑 Authentication

All API endpoints are secured using **Bearer token authentication**. You must include an access token in every request:

```
Authorization: Bearer YOUR_ACCESS_TOKEN
```

### Getting Your Access Token

Authlete supports two types of access tokens:

**Service Access Token** - Scoped to a single service (authorization server instance)

1. Log in to [Authlete Console](https://console.authlete.com)
2. Navigate to your service → **Settings** → **Access Tokens**
3. Click **Create Token** and select permissions (e.g., `service.read`, `client.write`)
4. Copy the generated token

**Organization Token** - Scoped to your entire organization

1. Log in to [Authlete Console](https://console.authlete.com)
2. Navigate to **Organization Settings** → **Access Tokens**
3. Click **Create Token** and select org-level permissions
4. Copy the generated token

> ⚠️ **Important Note**: Tokens inherit the permissions of the account that creates them. Service tokens can only 
> access their specific service, while organization tokens can access all services within your org.

### Token Security Best Practices

- **Never commit tokens to version control** - Store in environment variables or secure secret managers
- **Rotate regularly** - Generate new tokens periodically and revoke old ones
- **Scope appropriately** - Request only the permissions your application needs
- **Revoke unused tokens** - Delete tokens you're no longer using from the console

### Quick Test

Verify your token works with a simple API call:

```bash
curl -X GET https://us.authlete.com/api/service/get/list \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

## 🎓 Tutorials

If you're new to Authlete or want to see sample implementations, these resources will help you get started:

- [🚀 Getting Started with Authlete](https://www.authlete.com/developers/getting_started/)
- [🔑 From Sign-Up to the First API Request](https://www.authlete.com/developers/tutorial/signup/)

## 🛠 Contact Us

If you have any questions or need assistance, our team is here to help:

- [Contact Page](https://www.authlete.com/contact/)


### Available Operations
