# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::AuthorizationIssueResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::AuthorizationIssueResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def action(); end
  def action=(str_); end
  def response_content(); end
  def response_content=(str_); end
  def access_token(); end
  def access_token=(str_); end
  def access_token_expires_at(); end
  def access_token_expires_at=(str_); end
  def access_token_duration(); end
  def access_token_duration=(str_); end
  def id_token(); end
  def id_token=(str_); end
  def authorization_code(); end
  def authorization_code=(str_); end
  def jwt_access_token(); end
  def jwt_access_token=(str_); end
  def ticket_info(); end
  def ticket_info=(str_); end
end