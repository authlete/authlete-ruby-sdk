# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::NativeSsoRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::NativeSsoRequest
  def access_token(); end
  def access_token=(str_); end
  def device_secret(); end
  def device_secret=(str_); end
  def refresh_token(); end
  def refresh_token=(str_); end
  def sub(); end
  def sub=(str_); end
  def claims(); end
  def claims=(str_); end
  def idt_header_params(); end
  def idt_header_params=(str_); end
  def id_token_aud_type(); end
  def id_token_aud_type=(str_); end
  def device_secret_hash(); end
  def device_secret_hash=(str_); end
end