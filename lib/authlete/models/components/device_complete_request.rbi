# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::DeviceCompleteRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::DeviceCompleteRequest
  def user_code(); end
  def user_code=(str_); end
  def result(); end
  def result=(str_); end
  def subject(); end
  def subject=(str_); end
  def sub(); end
  def sub=(str_); end
  def auth_time(); end
  def auth_time=(str_); end
  def acr(); end
  def acr=(str_); end
  def claims(); end
  def claims=(str_); end
  def properties(); end
  def properties=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def error_description(); end
  def error_description=(str_); end
  def error_uri(); end
  def error_uri=(str_); end
  def idt_header_params(); end
  def idt_header_params=(str_); end
  def consented_claims(); end
  def consented_claims=(str_); end
  def jwt_at_claims(); end
  def jwt_at_claims=(str_); end
  def access_token_duration(); end
  def access_token_duration=(str_); end
  def refresh_token_duration(); end
  def refresh_token_duration=(str_); end
  def id_token_aud_type(); end
  def id_token_aud_type=(str_); end
end