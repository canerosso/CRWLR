class User < ApplicationRecord
  has_many :hosted_crawls, :class_name => "Crawl", foreign_key: 'host_id'
  has_many :invites
  has_many :attended_crawls, through: :invites, :source => :crawl

  has_secure_password
  validates :username, uniqueness: {case_sensitive: false}, presence: :true
end
