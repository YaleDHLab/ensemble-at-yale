class SubjectSetFirstPage
  include Mongoid::Document
  field :name, type: String
  field :thumbnail, type: String
  field :meta_data, type: Hash
end
