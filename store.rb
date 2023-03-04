require "json"
require "terminal-table"
require_relative "board"

class Store
 attr_reader :board 

  def initialize(filename)
    @filename = filename
    @boards = load
  end 

  def add_board(board_data)
    newboard = Board.new(**board_data)
    @boards << newboard
    save
  end

  def update_board(id, board_data)
    board = find_board(id)
    board.update(**board_data)
    save
  end

  def find_board(id)
    @boards.find { |board| board.id == id }
  end

  def delete_board(id)
    @boards.delete_if { |board| board.id == id }
    save
  end

  def boards_table
    table = Terminal::Table.new
    table.title = "CLIn Boards"
    table.headings = ["ID", "Name", "Description", "List(#cards)"]
    table.rows = @boards.map(&:to_a)
    table
  end

  def lists_table(id)
    tables_array = []
    board = find_board(id)
    board.lists.each do |list| 
      table = Terminal::Table.new
      table.title = list.name
      table.headings = ["ID", "Title", "Members", "Labels", "Due Date", "Checklist"]
      table.rows = list.cards.map(&:to_a)
      tables_array << table
    end
    tables_array
  end

   def add_lists(id,data_list)
    p id
    board = find_board(id)
    board.lists << List.new(**data_list)
    save
   end

   def update_list(id,data_list, name)
    board = find_board(id)
    list = board.find_list(name)
    list.update(**data_list)
    save
  end

  def delete_list(id, name)
    board = find_board(id)
    board.lists.delete_if { |list| list.name == name}
    save
  end

  
   def find_lists
    @lists.find { |list| list.id == id }
  end

 


  private

  def load
    boards_data = JSON.parse(File.read(@filename), symbolize_names: true)
    boards_data.map {|board_data| Board.new(**board_data)}
  end

  def save
    File.write(@filename, JSON.pretty_generate(@boards))
  end
end

# data = {
#   name: "Nueva BOARD",
#   description: "La descripción",
# }

# test = Store.new("store.json")
# pp test
