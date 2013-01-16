class Trellhub
  def initialize(payload)
    @payload = payload
    @faraday = Faraday.new(:url => 'https://api.trello.com/1')
  end

  def http
    @faraday
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
      card_num = /tr#(\d+)/i.match(commit['message'])
      next if card_num.nil?

      card = find_card(card_num[1], ENV['TRELLO_BOARDID'])
      create_message(card, commit)
    end
  end

  def find_card(card, board)
    response = http.get "boards/#{board}/cards/#{card}",
        :key => ENV['TRELLO_KEY'],
        :token => ENV['TRELLO_TOKEN']

    card_json = JSON.parse(response.body)
    card_json["id"]
  end

  def create_message(card,commit)

  end
end