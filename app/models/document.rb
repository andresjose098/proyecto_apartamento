class Document < ApplicationRecord
  belongs_to :user

   has_one_attached :file

  validates :title, :file, presence: true
end
