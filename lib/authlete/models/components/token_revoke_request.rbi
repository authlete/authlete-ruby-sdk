# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::TokenRevokeRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::TokenRevokeRequest
  def access_token_identifier(); end
  def access_token_identifier=(str_); end
  def refresh_token_identifier(); end
  def refresh_token_identifier=(str_); end
  def client_identifier(); end
  def client_identifier=(str_); end
  def subject(); end
  def subject=(str_); end
end