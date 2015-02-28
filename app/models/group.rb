class Group
  include Mongoid::Document
  include Mongoid::Ancestry

  has_ancestry orphan_strategy: :rootify

  field :name, type: String

  has_and_belongs_to_many :users, inverse_of: :groups
end
