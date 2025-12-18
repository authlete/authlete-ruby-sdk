# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::ClientExtension
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::ClientExtension
  def requestable_scopes(); end
  def requestable_scopes=(str_); end
  def requestable_scopes_enabled(); end
  def requestable_scopes_enabled=(str_); end
  def access_token_duration(); end
  def access_token_duration=(str_); end
  def refresh_token_duration(); end
  def refresh_token_duration=(str_); end
  def id_token_duration(); end
  def id_token_duration=(str_); end
  def token_exchange_permitted(); end
  def token_exchange_permitted=(str_); end
end