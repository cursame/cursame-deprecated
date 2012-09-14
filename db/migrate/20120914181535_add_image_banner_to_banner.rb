class AddImageBannerToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :image_banner, :string
  end
end
