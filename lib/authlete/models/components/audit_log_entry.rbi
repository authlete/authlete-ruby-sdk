# typed: true
# frozen_string_literal: true


class Authlete::Models::Components::AuditLogEntry
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Authlete::Models::Components::AuditLogEntry
  def event(); end
  def event=(str_); end
  def status(); end
  def status=(str_); end
  def cluster(); end
  def cluster=(str_); end
  def path(); end
  def path=(str_); end
  def remote_addr(); end
  def remote_addr=(str_); end
  def user_agent(); end
  def user_agent=(str_); end
  def user(); end
  def user=(str_); end
  def details(); end
  def details=(str_); end
  def timestamp(); end
  def timestamp=(str_); end
end
