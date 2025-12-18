# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::GMResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::GMResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def action(); end
  def action=(str_); end
  def response_content(); end
  def response_content=(str_); end
  def dpop_nonce(); end
  def dpop_nonce=(str_); end
end