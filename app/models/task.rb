class Task < ApplicationRecord
    # Validations
    validates :title, presence: true, uniqueness: true, length: { maximum: 100 }
    validates :description, presence: true, length: { maximum: 500 }
    validates :email, presence: true, uniqueness: true,
                      format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  
    # Flipper feature check method
    def self.feature_enabled?(feature)
      Flipper.enabled?(feature)
    end
  end
  