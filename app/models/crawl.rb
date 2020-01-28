class Crawl < ApplicationRecord
  belongs_to :host, :class_name => "User", :foreign_key => "host_id"
  has_many :crawl_places
  has_many :places, through: :crawl_places
  has_many :invites
  has_many :guests, through: :invites, :source => :user
  # has_many :guests, :class_name => "User", :foreign_key => "guest_id", through: :invites
end
