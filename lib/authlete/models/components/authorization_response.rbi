# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::AuthorizationResponse
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::AuthorizationResponse
  def result_code(); end
  def result_code=(str_); end
  def result_message(); end
  def result_message=(str_); end
  def action(); end
  def action=(str_); end
  def client(); end
  def client=(str_); end
  def display(); end
  def display=(str_); end
  def max_age(); end
  def max_age=(str_); end
  def service(); end
  def service=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def ui_locales(); end
  def ui_locales=(str_); end
  def claims_locales(); end
  def claims_locales=(str_); end
  def claims(); end
  def claims=(str_); end
  def acr_essential(); end
  def acr_essential=(str_); end
  def client_id_alias_used(); end
  def client_id_alias_used=(str_); end
  def acrs(); end
  def acrs=(str_); end
  def subject(); end
  def subject=(str_); end
  def login_hint(); end
  def login_hint=(str_); end
  def prompts(); end
  def prompts=(str_); end
  def lowest_prompt(); end
  def lowest_prompt=(str_); end
  def request_object_payload(); end
  def request_object_payload=(str_); end
  def id_token_claims(); end
  def id_token_claims=(str_); end
  def user_info_claims(); end
  def user_info_claims=(str_); end
  def resources(); end
  def resources=(str_); end
  def authorization_details(); end
  def authorization_details=(str_); end
  def purpose(); end
  def purpose=(str_); end
  def response_content(); end
  def response_content=(str_); end
  def ticket(); end
  def ticket=(str_); end
  def dynamic_scopes(); end
  def dynamic_scopes=(str_); end
  def gm_action(); end
  def gm_action=(str_); end
  def grant_id(); end
  def grant_id=(str_); end
  def grant(); end
  def grant=(str_); end
  def grant_subject(); end
  def grant_subject=(str_); end
  def requested_claims_for_tx(); end
  def requested_claims_for_tx=(str_); end
  def requested_verified_claims_for_tx(); end
  def requested_verified_claims_for_tx=(str_); end
  def transformed_claims(); end
  def transformed_claims=(str_); end
  def client_entity_id_used(); end
  def client_entity_id_used=(str_); end
  def claims_at_user_info(); end
  def claims_at_user_info=(str_); end
  def credential_offer_info(); end
  def credential_offer_info=(str_); end
  def issuable_credentials(); end
  def issuable_credentials=(str_); end
  def native_sso_requested(); end
  def native_sso_requested=(str_); end
  def metadata_document_used(); end
  def metadata_document_used=(str_); end
end