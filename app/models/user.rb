class User < ApplicationRecord
  ROLES = {
    "admin"           => "Admin — full access: content, pages, sections, users",
    "content_manager" => "Content Manager — can edit content only"
  }.freeze

  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "doesn't look like an email address" }
  validates :role, inclusion: { in: ROLES.keys }
  validates :password, length: { minimum: 8, allow_nil: true }

  def admin? = role == "admin"

  # True when this user is the only admin left — such an account can't be
  # deleted or demoted without locking everyone out of user management.
  def last_admin?
    admin? && User.where(role: "admin").where.not(id: id).none?
  end
end
