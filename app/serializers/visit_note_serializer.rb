class VisitNoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  belongs_to :patient
  has_many :observations
end
