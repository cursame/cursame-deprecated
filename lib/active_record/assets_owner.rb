module ActiveRecord
  module AssetsOwner
    def can_haz_assets
      accepts_nested_attributes_for :assets, :allow_destroy => true, :reject_if => lambda { |hash| hash[:file].blank? }

      # hack to save carrierwave assets from cache
      after_save do
        assets.each do |asset|
          asset.update_attribute :file_cache, asset.file_cache
        end
      end
    end
  end
end
