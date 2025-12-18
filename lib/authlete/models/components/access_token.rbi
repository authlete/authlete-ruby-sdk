# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::AccessToken
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::AccessToken
  def access_token_hash(); end
  def access_token_hash=(str_); end
  def access_token_expires_at(); end
  def access_token_expires_at=(str_); end
  def refresh_token_hash(); end
  def refresh_token_hash=(str_); end
  def refresh_token_expires_at(); end
  def refresh_token_expires_at=(str_); end
  def created_at(); end
  def created_at=(str_); end
  def last_refreshed_at(); end
  def last_refreshed_at=(str_); end
  def client_id(); end
  def client_id=(str_); end
  def subject(); end
  def subject=(str_); end
  def grant_type(); end
  def grant_type=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def properties(); end
  def properties=(str_); end
  def refresh_token_scopes(); end
  def refresh_token_scopes=(str_); end
end