class Asset < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  mount_uploader :file, AssetUploader
end
