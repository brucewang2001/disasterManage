class Event < ApplicationRecord
	has_many :messages
	paginates_per 5
end
