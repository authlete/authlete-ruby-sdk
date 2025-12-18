# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::PushedAuthorizationResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::PushedAuthorizationResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def action(); end
  def action=(str_); end
  def request_uri(); end
  def request_uri=(str_); end
  def response_content(); end
  def response_content=(str_); end
  def client_auth_method(); end
  def client_auth_method=(str_); end
  def dpop_nonce(); end
  def dpop_nonce=(str_); end
end