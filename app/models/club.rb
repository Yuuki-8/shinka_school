# frozen_string_literal: true

class Club < ApplicationRecord



  mount_uploader :image, ImageUploader

  # ↑imageカラムの中に画像を保存してくれる記述。



  has_many :user_clubs, dependent: :destroy

  # ↑中間テーブルであるuser_clubsを複数持ちますよ、clubを削除するときにはuser_clubsも一緒に削除しますよという意味

  has_many :users, through: :user_clubs

  # ↑user_clubsを通してusersを複数持ちますよという意味



  validates :name, presence: true

  validates :description, presence: true

  # ↑nameやdescriptionカラムは必ずデータが入れてくださいねというバリデーション。

end