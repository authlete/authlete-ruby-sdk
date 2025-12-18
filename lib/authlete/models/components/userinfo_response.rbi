# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::UserinfoResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::UserinfoResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def action(); end
  def action=(str_); end
  def claims(); end
  def claims=(str_); end
  def client_id(); end
  def client_id=(str_); end
  def client_id_alias(); end
  def client_id_alias=(str_); end
  def client_id_alias_used(); end
  def client_id_alias_used=(str_); end
  def response_content(); end
  def response_content=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def subject(); end
  def subject=(str_); end
  def token(); end
  def token=(str_); end
  def properties(); end
  def properties=(str_); end
  def user_info_claims(); end
  def user_info_claims=(str_); end
  def service_attributes(); end
  def service_attributes=(str_); end
  def client_attributes(); end
  def client_attributes=(str_); end
  def consented_claims(); end
  def consented_claims=(str_); end
  def requested_claims_for_tx(); end
  def requested_claims_for_tx=(str_); end
  def requested_verified_claims_for_tx(); end
  def requested_verified_claims_for_tx=(str_); end
  def transformed_claims(); end
  def transformed_claims=(str_); end
  def client_entity_id(); end
  def client_entity_id=(str_); end
  def client_entity_id_used(); end
  def client_entity_id_used=(str_); end
  def dpop_nonce(); end
  def dpop_nonce=(str_); end
  def metadata_document_location(); end
  def metadata_document_location=(str_); end
  def metadata_document_used(); end
  def metadata_document_used=(str_); end
end