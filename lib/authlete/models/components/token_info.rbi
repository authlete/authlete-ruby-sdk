# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::TokenInfo
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::TokenInfo
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
  def expires_at(); end
  def expires_at=(str_); end
  def properties(); end
  def properties=(str_); end
  def resources(); end
  def resources=(str_); end
  def authorization_details(); end
  def authorization_details=(str_); end
  def client_entity_id(); end
  def client_entity_id=(str_); end
  def client_entity_id_used(); end
  def client_entity_id_used=(str_); end
  def metadata_document_location(); end
  def metadata_document_location=(str_); end
  def metadata_document_used(); end
  def metadata_document_used=(str_); end
end