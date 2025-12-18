# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::IntrospectionResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::IntrospectionResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def action(); end
  def action=(str_); end
  def response_content(); end
  def response_content=(str_); end
  def client_id(); end
  def client_id=(str_); end
  def client_id_alias(); end
  def client_id_alias=(str_); end
  def client_id_alias_used(); end
  def client_id_alias_used=(str_); end
  def expires_at(); end
  def expires_at=(str_); end
  def subject(); end
  def subject=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def existent(); end
  def existent=(str_); end
  def usable(); end
  def usable=(str_); end
  def sufficient(); end
  def sufficient=(str_); end
  def refreshable(); end
  def refreshable=(str_); end
  def properties(); end
  def properties=(str_); end
  def certificate_thumbprint(); end
  def certificate_thumbprint=(str_); end
  def resources(); end
  def resources=(str_); end
  def access_token_resources(); end
  def access_token_resources=(str_); end
  def authorization_details(); end
  def authorization_details=(str_); end
  def service_attributes(); end
  def service_attributes=(str_); end
  def client_attributes(); end
  def client_attributes=(str_); end
  def scope_details(); end
  def scope_details=(str_); end
  def grant_id(); end
  def grant_id=(str_); end
  def grant(); end
  def grant=(str_); end
  def for_external_attachment(); end
  def for_external_attachment=(str_); end
  def consented_claims(); end
  def consented_claims=(str_); end
  def grant_type(); end
  def grant_type=(str_); end
  def acr(); end
  def acr=(str_); end
  def auth_time(); end
  def auth_time=(str_); end
  def client_entity_id(); end
  def client_entity_id=(str_); end
  def client_entity_id_used(); end
  def client_entity_id_used=(str_); end
  def for_credential_issuance(); end
  def for_credential_issuance=(str_); end
  def cnonce(); end
  def cnonce=(str_); end
  def cnonce_expires_at(); end
  def cnonce_expires_at=(str_); end
  def issuable_credentials(); end
  def issuable_credentials=(str_); end
  def dpop_nonce(); end
  def dpop_nonce=(str_); end
  def response_signing_required(); end
  def response_signing_required=(str_); end
  def metadata_document_location(); end
  def metadata_document_location=(str_); end
  def metadata_document_used(); end
  def metadata_document_used=(str_); end
end