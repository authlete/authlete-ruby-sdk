# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::JoseVerifyResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::JoseVerifyResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def valid(); end
  def valid=(str_); end
  def signature_valid(); end
  def signature_valid=(str_); end
  def missing_claims(); end
  def missing_claims=(str_); end
  def invalid_claims(); end
  def invalid_claims=(str_); end
  def error_descriptions(); end
  def error_descriptions=(str_); end
end