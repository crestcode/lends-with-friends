class FriendSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone

  has_many :loans
end
