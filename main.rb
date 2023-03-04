# require "pry"
require_relative "clin_boards"

app = ClinBoards.new("store.json")
app.board_display
