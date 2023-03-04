require_relative "lists"

class Board
  attr_reader :id, :lists
  attr_accessor :name, :description

  @@id_count = 0

  def initialize(name:, description:, id: nil, lists:[])
    @id = next_id(id)
    @name = name
    @description = description
    @lists = load_lists(lists)
  end

  def update(name: nil, description: nil)
    @name = name if name && !name.empty?
    @description = description if description && !description.empty?
  end

  def find_list(name)
    @lists.find { |list| list.name== name}
  end
  
  def to_json(*_args)
    JSON.pretty_generate({
                           id: @id,
                           name: @name,
                           description: @description,
                           lists: @lists
                         })
  end

  def to_a
   lists_card = ""
    @lists.each do |list| 
      lists_card = lists_card + list.name + "(" + list.cards.size.to_s + "), "
    end
    [@id, @name, @description, lists_card]
  end

  private

  def load_lists(lists_data)
    lists_data.map { |list_data| List.new(**list_data) }
  end

  def next_id(id)
    if id
      @@id_count = [@@id_count, id].max
      return id
    else
      @@id_count += 1
    end
    @@id_count
  end
end

#data = {
#  name: "LISTA1",
#  description: "Esta es la lista 1"
#}
#
#data1 = {
#  name: "IMPORTANTE"
#}
#
#test1 = Board.new(**data)
#pp test1
#test1.add_list(**data1)
#pp test1
# test1.add_checklist("cook pasta")
# test1.add_checklist("cook chifa")
# pp test1.add_checklist("cook caucau")
# pp test1.toggle_checklist(3)
# pp test1
