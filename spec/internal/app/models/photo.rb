class Photo < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'
  mount_uploader :file, PhotoUploader

  def to_s
    name
  end
end
