class CrawlPlace < ApplicationRecord
  belongs_to :crawl
  belongs_to :place
end
