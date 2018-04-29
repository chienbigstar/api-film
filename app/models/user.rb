class User < ApplicationRecord
  enum role: [:admin, :editor, :member]
	validates :username, uniqueness: true
	has_many :accounts
end
