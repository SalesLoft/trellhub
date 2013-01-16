class Trellhub
  def initialize(payload)
    @payload = payload
  end

  def ref
    @payload['ref'].to_s
  end

  def ref_name
    @payload['ref_name'] ||= ref.sub(/\Arefs\/(heads|tags)\//, '')
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
      card = find_card(ENV['TRELLO_BOARDID'])
      create_message(card, commit)
    end
  end

  def find_card(board)

  end

  def create_message(card,commit)

  end
end