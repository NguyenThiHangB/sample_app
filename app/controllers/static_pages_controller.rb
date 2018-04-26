# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost  = current_user.microposts.order_by_created_at.build
    @feed_items = current_user.feed.page(params[:page])
                              .per Settings.static_pages.per_page
  end

  def help; end

  def about; end

  def contract; end
end
