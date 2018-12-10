class Note < ApplicationRecord
    belongs_to :user
    attr_accessor :user_id
    default_scope { order(created_at: :desc) }
end
