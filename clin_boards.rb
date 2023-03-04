require_relative "store"

class ClinBoards
  def initialize(filename)
    @store = Store.new(filename)
  end

  def board_display
    
    puts "#" * 36
    puts "#      Welcome to CLIn Boards      #"
    puts "#" * 36
    
    loop do
      puts @store.boards_table
      puts boards_menu
      print "> "

      option, id = gets.chomp.split

      case option
      when "create"
        data = board_form
        @store.add_board(data)
      when "show"
        show_lists(id.to_i)
      when "update"
        data = board_form
        @store.update_board(id.to_i, data)
      when "delete"
        @store.delete_board(id.to_i)
      when "exit"
       puts "#" * 36
       puts "#   Thanks for using CLIn Boards   #"
       puts "#" * 36
        break
      end
    end 
      
  end

  private

  def boards_menu
    "Board options: create | show ID | update ID | delete ID | exit"
  end

  def board_form
    print "Name: "
    name = gets.chomp
    print "Description: "
    description = gets.chomp
    {name: name, description: description}
  end


  ###########################################################################
  def show_lists(id)
    loop do
      puts @store.lists_table(id)
      puts lists_menu
      print "> "

      option, name = gets.chomp.split

      case option
      when "create-list"
        data = lists_form
        @store.add_lists(data)
      when "update-list"
        data = lists_form
        @store.update_list(name, data)
      when "delete-list"
        @store.delete_list(name)
      when "back"
       # "devolver al menu boards"
        break
      end
    end
  end

  def lists_menu
    puts "List options: create-list | update-list LISTNAME | delete-list LISTAME"
    puts card_menu
    puts "back"
  end

  def lists_form
    print "Name: "
    name = gets.chomp
    {name: name}
  end

 
  ########################################################################
  def card_display(card_id)
    loop do
      puts card_table(card_id)
      puts card_menu
      print "> "

      option, id = gets.chomp.split

      case option
      when "create-card"
        data = card_form
        @lists.add_card(data, card_id)
      when "checklist"
        ##open checklist
      when "update-card"
        data = card_form
        @lists.update_card(id.to_i, data, card_id)
      when "delete-card"
        @lists.delete_card(id.to_i, card_id)
      when "back"
       # "devolver al menu boards"
        break
      end
    end
  end

  def card_menu
    "Card options: create-card | checklist ID | update-card ID | delete-card ID"
  end

  def card_form
    print "Select a list:"
    print "Todo | In Progress | Code Review | Done"
    list_options = gets.chomp 
    print "Title: "
    title = gets.chomp
    print "Members: "
    members = gets.chomp
    print "Labels: "
    labels = gets.chomp
    print "Due Date: "
    duedate = gets.chomp

    {title: title, members: members, labels: labels, duedate: duedate}
  end
end

