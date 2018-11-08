class Social < ApplicationRecord
  belongs_to :user
  enum kind: [:evernote]
  validates_presence_of :kind
end
