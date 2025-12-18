# JweEnc

This is the encryption algorithm to be used when encrypting a JWT on client or server side.
Depending upon the context, this refers to encryption done by the client or by the server. For instance:
  - as `authorizationEncryptionEnc` value, it refers to the encryption algorithm used by server when creating a JARM response
  - as `requestEncryptionEnc` value, it refers to the expected encryption algorithm used by the client when encrypting a Request Object
  - as `idTokenEncryptionEnc` value, it refers to the algorithm used by the server to encrypt id_tokens



## Values

| Name             | Value            |
| ---------------- | ---------------- |
| `A128_CBC_HS256` | A128CBC_HS256    |
| `A192_CBC_HS384` | A192CBC_HS384    |
| `A256_CBC_HS512` | A256CBC_HS512    |
| `A128_GCM`       | A128GCM          |
| `A192_GCM`       | A192GCM          |
| `A256_GCM`       | A256GCM          |