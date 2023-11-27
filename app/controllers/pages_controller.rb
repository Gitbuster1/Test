class PagesController < ApplicationController
  def home
    @word_count = count_words("This test is A TeST ThaT I like!!!")
    @query = "car"
    @jokes = get_jokes(@query)
  end

  private

  def count_words(text)
    text.gsub(/\W/, ' ').downcase.split.uniq.count
  end

  def get_jokes(query)
    response = HTTParty.get("https://api.chucknorris.io/jokes/search?query=#{query}")
    if response.code == 200
      response["result"].map { |joke| joke["value"] }
    else
      ["Chuck Norris is not available right now."]
    end
  end
end
