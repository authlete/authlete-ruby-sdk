# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::TokenUpdateResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::TokenUpdateResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def action(); end
  def action=(str_); end
  def access_token(); end
  def access_token=(str_); end
  def access_token_expires_at(); end
  def access_token_expires_at=(str_); end
  def properties(); end
  def properties=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def authorization_details(); end
  def authorization_details=(str_); end
  def token_type(); end
  def token_type=(str_); end
  def for_external_attachment(); end
  def for_external_attachment=(str_); end
  def token_id(); end
  def token_id=(str_); end
  def refresh_token_expires_at(); end
  def refresh_token_expires_at=(str_); end
end