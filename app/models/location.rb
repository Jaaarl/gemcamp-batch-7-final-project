class Location < ApplicationRecord
  enum genre: { home: 0, work: 1 }

  validates :genre, presence: true
  validates :name, presence: true
  validates :street_address, presence: true
  validates :phone_number, phone: true

  belongs_to :user
  belongs_to :region, class_name: 'Address::Region', foreign_key: 'address_region_id'
  belongs_to :province, class_name: 'Address::Province', foreign_key: 'address_province_id'
  belongs_to :city, class_name: 'Address::City', foreign_key: 'address_city_id'
  belongs_to :barangay, class_name: 'Address::Barangay', foreign_key: 'address_barangay_id'

  has_many :winners
end