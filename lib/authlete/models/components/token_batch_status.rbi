# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::TokenBatchStatus
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::TokenBatchStatus
  def batch_kind(); end
  def batch_kind=(str_); end
  def request_id(); end
  def request_id=(str_); end
  def result(); end
  def result=(str_); end
  def error_code(); end
  def error_code=(str_); end
  def error_description(); end
  def error_description=(str_); end
  def token_count(); end
  def token_count=(str_); end
  def created_at(); end
  def created_at=(str_); end
  def modified_at(); end
  def modified_at=(str_); end
end