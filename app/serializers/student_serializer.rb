class StudentSerializer < ActiveModel::Serializer
  attributes :name, :major, :age, :instructor_id

  belongs_to :instructor
end
