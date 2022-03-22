class Patient < ApplicationRecord
  has_many :visit_notes, dependent: :destroy
end