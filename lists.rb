require_relative "card"

class List
  attr_reader :id, :card
  attr_accessor :name

  @@id_count = 0

  def initialize(name:, id: nil, cards: [])
    @id = next_id(id)
    @name = name
    @cards = load_cards(cards)
  end

  # def create_card(form)
  #   newcard = Card.new(form)
  #   @cards << newcard
  # end

  def create_card(form)
    newcard = Card.new(title: form[:title], members: form[:members], labels: form[:labels], duedate: form[:duedate])
    @cards << newcard
  end

  def find_card(id)
    @cards.find { |card| card.id == id }
  end

  def update_card(id, form)
    my_card = find_card(id)
    my_card.update(**form)
    save
  end

  def update(name: nil, description: nil)
    @name = name if name && !name.empty?
    @description = description if description && !description.empty?
  end

  def to_json(_arg)
    JSON.pretty_generate({
                           id: @id,
                           name: @name,
                           cards: @cards
                         })
  end

  private

  def next_id(id)
    if id
      @@id_count = [@@id_count, id].max
      return id
    else
      @@id_count += 1
    end
    @@id_count
  end

  def load_cards(cards_data)
    cards_data.map { |card_data| Card.new(**card_data) }
  end
end

# data = {
#  title: "Project",
#  members: "Rossío, Sergio",
#  labels: "coding",
#  duedate: "2023-03-02"
# }

# test = List.new(**data1)
# p test.create_card(**data)
# test = List.new(name: "NAME")
#
# p test.create_card(**data)
#
# puts "-" * 30
#
# pp data
