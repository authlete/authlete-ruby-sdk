# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::VciOfferCreateRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::VciOfferCreateRequest
  def authorization_code_grant_included(); end
  def authorization_code_grant_included=(str_); end
  def issuer_state_included(); end
  def issuer_state_included=(str_); end
  def pre_authorized_code_grant_included(); end
  def pre_authorized_code_grant_included=(str_); end
  def subject(); end
  def subject=(str_); end
  def duration(); end
  def duration=(str_); end
  def context(); end
  def context=(str_); end
  def properties(); end
  def properties=(str_); end
  def jwt_at_claims(); end
  def jwt_at_claims=(str_); end
  def auth_time(); end
  def auth_time=(str_); end
  def acr(); end
  def acr=(str_); end
  def credential_configuration_ids(); end
  def credential_configuration_ids=(str_); end
  def tx_code(); end
  def tx_code=(str_); end
  def tx_code_input_mode(); end
  def tx_code_input_mode=(str_); end
  def tx_code_description(); end
  def tx_code_description=(str_); end
end