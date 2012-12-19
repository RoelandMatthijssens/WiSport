class Image < ActiveRecord::Base
  attr_accessible :file
  #attr_accessor :image
  
  belongs_to :information
  
  #validates :delete_page, :imagur_page, :large_thumbnail, :original, :small_square,  :presence => true
    
	before_destroy :delete_imgur

	def file
		original
  end
  
  def file=(file)
    require "uri"
    require "net/http"
    params = {image: Image.to_base64(file), key: "541f5d27b647da18a8349aa3743c23b9"}
    x = Net::HTTP.post_form(URI.parse("http://api.imgur.com/2/upload.json"), params)
    response = ActiveSupport::JSON.decode(x.body)
    imgur_links = response["upload"]["links"]
    self.delete_page = imgur_links["delete_page"]
    self.imagur_page = imgur_links["imgur_page"]
    self.large_thumbnail = imgur_links["large_thumbnail"]
    self.original = imgur_links["original"]
    self.small_square =  imgur_links["small_square"]
    self.delete_hash = response["upload"]["image"]["deletehash"]
  end
  
  def delete_imgur
    require "uri"
    require "net/http"
    http = Net::HTTP.new("api.imgur.com") # url should not include resource path, only domain info
    request = Net::HTTP::Delete.new("/2/delete/#{delete_hash}.json")
    response = http.request(request)
    response = ActiveSupport::JSON.decode(response.body)
    response["delete"] && response["delete"]["message"] == "Success"
  end
  
  private
  
  def self.to_base64 file
    Base64.encode64(file.read)
  end
end
