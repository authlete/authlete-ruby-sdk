# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::StandardIntrospectionRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::StandardIntrospectionRequest
  def parameters(); end
  def parameters=(str_); end
  def with_hidden_properties(); end
  def with_hidden_properties=(str_); end
  def rs_uri(); end
  def rs_uri=(str_); end
  def http_accept_header(); end
  def http_accept_header=(str_); end
  def introspection_sign_alg(); end
  def introspection_sign_alg=(str_); end
  def introspection_encryption_alg(); end
  def introspection_encryption_alg=(str_); end
  def introspection_encryption_enc(); end
  def introspection_encryption_enc=(str_); end
  def shared_key_for_sign(); end
  def shared_key_for_sign=(str_); end
  def shared_key_for_encryption(); end
  def shared_key_for_encryption=(str_); end
  def public_key_for_encryption(); end
  def public_key_for_encryption=(str_); end
end