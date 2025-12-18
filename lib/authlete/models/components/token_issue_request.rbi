# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::TokenIssueRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::TokenIssueRequest
  def ticket(); end
  def ticket=(str_); end
  def subject(); end
  def subject=(str_); end
  def properties(); end
  def properties=(str_); end
  def jwt_at_claims(); end
  def jwt_at_claims=(str_); end
  def access_token(); end
  def access_token=(str_); end
  def access_token_duration(); end
  def access_token_duration=(str_); end
  def refresh_token_duration(); end
  def refresh_token_duration=(str_); end
end