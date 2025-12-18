# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::AuthorizationIssueRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::AuthorizationIssueRequest
  def ticket(); end
  def ticket=(str_); end
  def subject(); end
  def subject=(str_); end
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
  def sub(); end
  def sub=(str_); end
  def idt_header_params(); end
  def idt_header_params=(str_); end
  def claims_for_tx(); end
  def claims_for_tx=(str_); end
  def consented_claims(); end
  def consented_claims=(str_); end
  def authorization_details(); end
  def authorization_details=(str_); end
  def jwt_at_claims(); end
  def jwt_at_claims=(str_); end
  def access_token(); end
  def access_token=(str_); end
  def access_token_duration(); end
  def access_token_duration=(str_); end
  def session_id(); end
  def session_id=(str_); end
  def id_token_aud_type(); end
  def id_token_aud_type=(str_); end
  def verified_claims_for_tx(); end
  def verified_claims_for_tx=(str_); end
end