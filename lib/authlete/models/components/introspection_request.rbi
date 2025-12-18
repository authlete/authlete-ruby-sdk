# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::IntrospectionRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::IntrospectionRequest
  def token(); end
  def token=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def subject(); end
  def subject=(str_); end
  def client_certificate(); end
  def client_certificate=(str_); end
  def dpop(); end
  def dpop=(str_); end
  def htm(); end
  def htm=(str_); end
  def htu(); end
  def htu=(str_); end
  def resources(); end
  def resources=(str_); end
  def acr_values(); end
  def acr_values=(str_); end
  def max_age(); end
  def max_age=(str_); end
  def required_components(); end
  def required_components=(str_); end
  def uri(); end
  def uri=(str_); end
  def message(); end
  def message=(str_); end
  def headers(); end
  def headers=(str_); end
  def target_uri(); end
  def target_uri=(str_); end
  def dpop_nonce_required(); end
  def dpop_nonce_required=(str_); end
  def request_body_contained(); end
  def request_body_contained=(str_); end
end