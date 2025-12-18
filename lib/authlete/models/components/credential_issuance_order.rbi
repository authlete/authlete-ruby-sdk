# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::CredentialIssuanceOrder
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::CredentialIssuanceOrder
  def request_identifier(); end
  def request_identifier=(str_); end
  def credential_payload(); end
  def credential_payload=(str_); end
  def issuance_deferred(); end
  def issuance_deferred=(str_); end
  def credential_duration(); end
  def credential_duration=(str_); end
  def signing_key_id(); end
  def signing_key_id=(str_); end
end