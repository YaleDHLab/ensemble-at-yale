class SubjectSetFirstPage
  include Mongoid::Document
  field :name, type: String
  field :thumbnail, type: String
  field :meta_data, type: Hash
  field :group_key_id, type: String
  field :subject_set_id, type: String
end
