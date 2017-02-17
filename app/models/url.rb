class Url < ApplicationRecord

	before_create :shorten
	validates_presence_of :long_url, message: "can't be blank!"
	validate :validate_url
	
	def shorten
		self.short_url = SecureRandom.hex(3)
	end

	def count  
		self.click_count += 1
		self.save
	end

	def self.total_click
		total_click = 0
		click_array = Url.select(:click_count)
		click_array.each do |click|
			total_click += click.click_count
		end
		total_click
	end

	def validate_url
    unless self.long_url =~ /(http:\/\/|https:\/\/)(www.)([a-z]*.)(com|edu|org|net|gov|mil|biz|info|co.uk)/
      errors.add(:long_url, "Please enter a valid URL")
    end
  end

end
