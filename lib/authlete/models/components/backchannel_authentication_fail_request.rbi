# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::BackchannelAuthenticationFailRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::BackchannelAuthenticationFailRequest
  def ticket(); end
  def ticket=(str_); end
  def reason(); end
  def reason=(str_); end
  def error_description(); end
  def error_description=(str_); end
  def error_uri(); end
  def error_uri=(str_); end
end