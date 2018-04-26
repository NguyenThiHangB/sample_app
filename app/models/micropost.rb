class Micropost < ApplicationRecord
  belongs_to :user

  scope :order_by_created_at, ->{order created_at: :desc}

  scope :by_user, (lambda do |user_id|
    where user_id: user_id
  end)

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
   length: {maximum: Settings.micropost.content.max_length}
  validate :picture_size

  private

  def picture_size
    if picture.size > Settings.micropost.picture.size.megabytes
      errors.add :picture, t("model.mocropost.error")
    end
  end
end
