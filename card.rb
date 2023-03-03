class Card
  attr_reader :id, :title, :members, :labels, :duedate, :checklist

  @@id_count = 0

  def initialize(title:, members:, labels:, duedate:, id: nil, checklist: [])
    @id = next_id(id)
    @title = title
    @members = members
    @labels = labels
    @duedate = duedate
    @checklist = checklist
  end

  def checklist_card
    puts "Card: #{@title}"
    @checklist.each_with_index do |checklist, index|
      puts (checklist[:completed] ? "[ x ]" : "[ ]") + "#{index + 1}. " + checklist[:title]
    end
  end

  def add_checklist(name)
    @checklist << { title: name, completed: false }
  end

  def toggle_checklist(index)
    @checklist[index - 1][:completed] = !@checklist[index - 1][:completed]
  end

  def delete_checklist(index)
    @checklist.delete_at(index - 1)
  end

  def to_json(_arg)
    JSON.pretty_generate({
                           id: @id,
                           title: @title,
                           members: @members,
                           labels: @labels,
                           duedate: @duedate,
                           checklist: @checklist
                         })
  end

  def to_a
    [@id, @title, @members.join(", "), @labels.join(", "), @duedate]
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

data = {
  title: "Project",
  members: "Rossío, Sergio",
  labels: "coding",
  duedate: "2023-03-02",
  checklist: []
}
test1 = Card.new(**data)
pp test1
# test1.add_checklist("cook pasta")
# test1.add_checklist("cook chifa")
# pp test1.add_checklist("cook caucau")
# pp test1.toggle_checklist(3)
# pp test1
