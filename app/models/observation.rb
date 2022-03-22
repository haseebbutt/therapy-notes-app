class Observation < ApplicationRecord
  belongs_to :visit_note

  enum result: [:NA ,:Positive, :Negative]
end