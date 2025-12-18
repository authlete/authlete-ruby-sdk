# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::NativeSsoResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::NativeSsoResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def action(); end
  def action=(str_); end
  def response_content(); end
  def response_content=(str_); end
  def id_token(); end
  def id_token=(str_); end
end