# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::TokenIssueResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::TokenIssueResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def action(); end
  def action=(str_); end
  def response_content(); end
  def response_content=(str_); end
  def access_token(); end
  def access_token=(str_); end
  def access_token_expires_at(); end
  def access_token_expires_at=(str_); end
  def access_token_duration(); end
  def access_token_duration=(str_); end
  def refresh_token(); end
  def refresh_token=(str_); end
  def refresh_token_expires_at(); end
  def refresh_token_expires_at=(str_); end
  def refresh_token_duration(); end
  def refresh_token_duration=(str_); end
  def client_id(); end
  def client_id=(str_); end
  def client_id_alias(); end
  def client_id_alias=(str_); end
  def client_id_alias_used(); end
  def client_id_alias_used=(str_); end
  def subject(); end
  def subject=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def properties(); end
  def properties=(str_); end
  def jwt_access_token(); end
  def jwt_access_token=(str_); end
  def access_token_resources(); end
  def access_token_resources=(str_); end
  def authorization_details(); end
  def authorization_details=(str_); end
  def service_attributes(); end
  def service_attributes=(str_); end
  def client_attributes(); end
  def client_attributes=(str_); end
  def client_entity_id(); end
  def client_entity_id=(str_); end
  def client_entity_id_used(); end
  def client_entity_id_used=(str_); end
  def refresh_token_scopes(); end
  def refresh_token_scopes=(str_); end
  def metadata_document_location(); end
  def metadata_document_location=(str_); end
  def metadata_document_used(); end
  def metadata_document_used=(str_); end
end