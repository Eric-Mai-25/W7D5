# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint           not null, primary key
#  sub_id     :bigint           not null
#  post_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PostSub < ApplicationRecord
    
    belongs_to :post
        
    belongs_to :sub
end
