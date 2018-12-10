class Note < ApplicationRecord
    belongs_to :user
    attr_accessor :user_id
end
