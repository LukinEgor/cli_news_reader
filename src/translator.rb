require 'net/http'
require 'json'
require './src/config'

# Get translation for word. Used multillect.com service. Id and sig getting
# from this service.
class Translator
  class << self
    def exec(word)
      format_word = delete_escape(word)
      url = create_url(format_word)
      uri = URI(url)
      begin
        res = Net::HTTP.get(uri)
        JSON.parse(res)['result']['translated']
      rescue StandartError => ex
        "error: #{ex}"
      end
    end

    private

    def delete_escape(word)
      word.gsub('\\"', '')
    end

    def create_url(word)
      id = Config.translation.id
      sig = Config.translation.sig
      from = Config.translation.lang.from
      to = Config.translation.lang.to

      "https://api.multillect.com/translate/json/1.0/#{id}?from=#{from}&
      to=#{to}&text=#{word}&sig=#{sig}&method=translate/api/translate"
    end
  end
end
