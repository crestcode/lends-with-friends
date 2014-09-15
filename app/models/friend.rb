class Friend < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  has_many :loans, :dependent => :destroy
  accepts_nested_attributes_for :loans, allow_destroy: true, reject_if: :all_blank

end
