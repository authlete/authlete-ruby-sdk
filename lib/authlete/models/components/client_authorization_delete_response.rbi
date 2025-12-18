# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::ClientAuthorizationDeleteResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::ClientAuthorizationDeleteResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def service_api_key(); end
  def service_api_key=(str_); end
  def client_id(); end
  def client_id=(str_); end
  def subject(); end
  def subject=(str_); end
  def latest_granted_scopes(); end
  def latest_granted_scopes=(str_); end
  def merged_granted_scopes(); end
  def merged_granted_scopes=(str_); end
  def modified_at(); end
  def modified_at=(str_); end
end