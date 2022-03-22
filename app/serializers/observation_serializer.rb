class ObservationSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :result
end
