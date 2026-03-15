# frozen_string_literal: true

module OidcHelper
  # Generates a private RSA JWK set suitable for ID token signing.
  # Returns { jwks: <json string>, kid: <key id> }.
  def generate_rsa_jwks
    key = OpenSSL::PKey::RSA.generate(2048)
    kid = SecureRandom.uuid
    p   = key.params
    b64 = ->(v) { Base64.urlsafe_encode64(v.to_s(2), padding: false) }
    jwk = {
      'kty' => 'RSA', 'kid' => kid, 'use' => 'sig', 'alg' => 'RS256',
      'n'   => b64.(p['n']),    'e'  => b64.(p['e']),    'd'  => b64.(p['d']),
      'p'   => b64.(p['p']),    'q'  => b64.(p['q']),
      'dp'  => b64.(p['dmp1']), 'dq' => b64.(p['dmq1']), 'qi' => b64.(p['iqmp'])
    }
    { jwks: JSON.generate({ 'keys' => [jwk] }), kid: kid }
  end

  # Decodes the payload segment of a JWT without verifying the signature.
  def decode_jwt_payload(jwt)
    segment = jwt.split('.')[1]
    padded  = segment + '=' * ((4 - segment.length % 4) % 4)
    JSON.parse(Base64.urlsafe_decode64(padded))
  end

  # Creates a service via IDP pre-configured for OIDC (issuer + JWKS).
  def idp_create_oidc_service(extra_params = {})
    jwks_info = generate_rsa_jwks
    @oidc_jwks_info = jwks_info

    idp_create_service({
      'issuer'                 => 'https://as.example.com',
      'supportedGrantTypes'    => %w[AUTHORIZATION_CODE],
      'supportedResponseTypes' => %w[CODE],
      'supportedScopes'        => [
        { 'name' => 'openid',  'defaultEntry' => false },
        { 'name' => 'profile', 'defaultEntry' => false }
      ],
      'accessTokenDuration'    => 600,
      'refreshTokenDuration'   => 600,
      'jwks'                   => jwks_info[:jwks],
      'idTokenSignatureKeyId'  => jwks_info[:kid]
    }.merge(extra_params))
  end

  # Asserts the standard OIDC claims on a decoded id_token payload.
  def assert_oidc_claims(claims, expected_sub:, expected_nonce:, expected_client_id:)
    assert_equal expected_sub, claims['sub'],
      "id_token sub must equal subject (#{expected_sub})"
    assert_equal expected_nonce, claims['nonce'],
      'id_token nonce must match the nonce from the authorization request'
    refute_nil claims['iss'], 'id_token must have an iss claim'
    aud = Array(claims['aud'])
    assert aud.any? { |a| a.to_s == expected_client_id },
      "id_token aud must include client_id (#{expected_client_id}), got #{aud.inspect}"
  end
end
