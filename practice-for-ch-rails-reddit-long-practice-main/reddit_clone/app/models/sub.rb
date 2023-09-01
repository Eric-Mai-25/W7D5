# == Schema Information
#
# Table name: subs
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  description  :text
#  moderator_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Sub < ApplicationRecord
    validates :title, presence: true

    belongs_to :user,
        foreign_key: :moderator_id,
        class_name: :User

    has_many :posts,
        foreign_key: :sub_id,
        class_name: :Post,
        inverse_of: :sub,
        dependent: :destroy

        

end
