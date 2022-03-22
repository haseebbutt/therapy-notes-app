class VisitNote < ApplicationRecord
  has_many :observations, dependent: :destroy
  belongs_to :patient
end