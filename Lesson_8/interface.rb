# frozen_string_literal: true

# interface
module Interface
  INTERFACE = %w[
    Create\ station
    Create\ train
    Create\ route
    Create\ wagon
    Add\ station\ to\ route
    Remove\ station\ from\ route
    Assign\ route\ to\ train
    Attach\ wagons\ to\ the\ train
    Remove\ wagons\ from\ the\ train
    Send\ train\ forward
    Send\ train\ back
    Show\ station\ list
    Show\ trains\ on\ current_station
    Show\ trains\ on\ all\ stations
    Show\ wagons\ on\ all\ trains
    Select\ current\ station
    Select\ current\ train
    Select\ current\ route
    Select\ current\ wagon
    Exit
  ].freeze

  def interface
    loop do
      show
      users_input = gets.chomp.to_i
      break if users_input == 20

      process_input(users_input)
    end
  end
end
