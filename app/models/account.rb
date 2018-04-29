class Account < ApplicationRecord
	validates :ip, uniqueness: true
	belongs_to :user

	enum status: [:on, :off]
end
