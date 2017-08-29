require 'net/http'
require 'json'
require './src/config'

class Translator
  def self.exec(word)
    id = Config.translation.id
    sig = Config.translation.sig
    from = Config.translation.lang.from
    to = Config.translation.lang.to

    begin
      url = "https://api.multillect.com/translate/json/1.0/#{id}?from=#{from}&to=#{to}&text=#{word}&sig=#{sig}&method=translate/api/translate"
      uri = URI(url)
      res = Net::HTTP.get(uri)
      JSON.parse(res)["result"]["translated"]
    rescue Exception => ex
      "error: #{ex}"
    end
  end
end
