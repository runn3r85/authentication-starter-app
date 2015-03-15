class User < ActiveRecord::Base

  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                      message: 'Must be a valid e-mail format.'
                    }

  validates :username, presence: true,
                      length: { minimum: 5, maximum: 30 },
                      uniqueness: true,
                      format: {
                        with: /\A[a-zA-Z0-9]+\z/,
                        message: 'Can only contain letters and numbers.'
                      }, on: :create

  validates :first_name, :last_name, presence: true

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end
end
