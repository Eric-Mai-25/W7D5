# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :bigint           not null
#  author_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
    validates :title, presence: true
    

    belongs_to :author,
        class_name: :User,
        foreign_key: :author_id

    belongs_to :sub

    has_many :subs,
        class_name: :PostSub,
        foreign_key: :sub_id,
        dependent: :destroy

    
end
