class PatientDiagSerializer < ActiveModel::Serializer
  attributes :id, :order, :note
  has_one :diag
end