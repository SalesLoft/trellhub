class Trellhub
  def initialize(payload)
    @payload = JSON.parse(payload)
    @faraday = Faraday.new(:url => 'https://api.trello.com/1')
  end

  def http
    @faraday
  end

  def card_regex
    /tr#(\d+)/i
  end

  def receive_push
    return unless create_message?
    create_messages

    "ok"
  end

  def create_message?
    return false if @payload['commits'].size == 0
    true
  end

  def create_messages
    @payload['commits'].each do |commit|
      card_num = card_regex.match(commit['message'])
      next if card_num.nil?

      card = find_card(card_num[1], ENV['TRELLO_BOARDID'])
      create_message(card, commit, commit['message'].gsub(card_regex,'')) unless card == false
    end
  end

  def find_card(card, board)
    response = http.get "boards/#{board}/cards/#{card}",
        :key => ENV['TRELLO_KEY'],
        :token => ENV['TRELLO_TOKEN']

    return false if response.status != 200

    card_json = JSON.parse(response.body)
    card_json["id"]
  end

  def create_message(card,commit,message)
    response = http.post "cards/#{card}/actions/comments",
        :key => ENV['TRELLO_KEY'],
        :token => ENV['TRELLO_TOKEN'],
        :text => "@#{commit['author']['name']} committed #{commit['id'][0,9]}:\n #{message} \n\n #{commit['url']}"

    return false if response.status != 200
    true
  end
end