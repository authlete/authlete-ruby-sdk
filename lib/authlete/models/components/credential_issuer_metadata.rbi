# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::CredentialIssuerMetadata
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::CredentialIssuerMetadata
  def authorization_servers(); end
  def authorization_servers=(str_); end
  def credential_issuer(); end
  def credential_issuer=(str_); end
  def credential_endpoint(); end
  def credential_endpoint=(str_); end
  def batch_credential_endpoint(); end
  def batch_credential_endpoint=(str_); end
  def deferred_credential_endpoint(); end
  def deferred_credential_endpoint=(str_); end
  def credentials_supported(); end
  def credentials_supported=(str_); end
  def credential_response_encryption_alg_values_supported(); end
  def credential_response_encryption_alg_values_supported=(str_); end
  def credential_response_encryption_enc_values_supported(); end
  def credential_response_encryption_enc_values_supported=(str_); end
  def require_credential_response_encryption(); end
  def require_credential_response_encryption=(str_); end
end