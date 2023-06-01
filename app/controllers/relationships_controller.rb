class RelationshipsController < ApplicationController

#連打されたとき重複しないための条件分岐！！！
  def create
    followed=User.find(params[:user_id])
    unless followed.followed_by?(current_user)
    follow = current_user.follower_relationships.build(followed_id: params[:user_id])
    follow.save
    end

    redirect_to request.referer
  end

  def destroy
    followed=User.find(params[:user_id])
    if followed.followed_by?(current_user)
    follow = current_user.follower_relationships.find_by(followed_id: params[:user_id])
    follow.destroy
  end
    redirect_to request.referer
  end


end
