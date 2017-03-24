class Location < ApplicationRecord

  before_save :reformat_phone


  has_many :item_locations
  has_many :items, through: :item_locations
  has_many :addresses

  accepts_nested_attributes_for :item_locations, reject_if: lambda { |item_location| item_location[:item_id].blank? }, allow_destroy: true
  accepts_nested_attributes_for :addresses, reject_if: lambda { |addr| addr[:address].blank? }, allow_destroy: true

  validates :name, presence: true

  scope :alphabetical , -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_county, -> (id) {Location.joins(:addresses).where(addresses: {county_id: id})}
  # scope :for_zipcode, -> (zip) { where("zipcode=?", zip ) }
  # scope :by_zipcode, -> { order('zipcode') }
  # scope :by_county, ->  { includes(:county).order('counties.name') }
  # scope :for_county, -> (id) { where('counties_id=?', id) }

  def item_locations_for_form
    collection = item_locations.where(location_id: id)
    collection.any? ? collection : item_locations.build
  end



  private

  def reformat_phone
    phone = self.phone.to_s  # change to string in case input as all numbers
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.phone = phone       # reset self.phone to new string
  end

end
