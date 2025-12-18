# typed: true
# frozen_string_literal: true


class Authlete::Models::Errors::ResultError
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Errors::ResultError
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def raw_response(); end
  def raw_response=(str_); end
end