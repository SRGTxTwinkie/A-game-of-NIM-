$player = true ### Global to handle what player is going at that moment.

def PlayerSwitch ### I call this when I need to switch players, mostly because it looks nicer than putting line 4 every time.
  $player = !$player
end

def Init ### Initializes all the variables I need to start the program.
  puts
  $sticks = []
  3.times {$sticks.append(rand(1...10))} ### Appends 3 random values to the $sticks array
  print "What is the name of the First Player?: "
  $p1 = gets().chomp ### These only need to be global becuase I use them in one other spot. smh
  print "And player 2?: "
  $p2 = gets().chomp
  puts
  Display() ### Displays the stick piles
  MovePart1() ### Goes to the actual gameplay sequence
end

def Display ### Lists the stick piles
  x = 1 ### Increments by one every loop for proper pile listings
  $sticks.each do |i| ### Isn't that a cool way to do loops?
    print "Pile ", x ,": ", i, "\n"
    x += 1
  end
  MovePart1() ###Loops to move part one, and they will go until endgame
end

def MovePart1 ### Wee, it's the meat of the program
  pile = 0
  until pile.between?(1,3) ### Until loops handle all the heavy lifiting of this program.
    print "What Pile do you want to choose ", $player == true ? ($p1) : ($p2), ": " ### Clever way to do a one line if statement. Credit to stack overflow
    pile = gets().to_i
  end

  choice = 0

  until choice.between?(1,$sticks[pile - 1])
=begin
  Line 38 makes the correct list calling
  becuase lists start at 0, so the player
  choice is always +1 away from being
  the correct position. So de-incrementing it
  by one is the easiest way to handle it.
  I hope anyway.
=end
    print "How many do you want to take out, ", $player == true ? ($p1) : ($p2), ": "
    choice = gets().to_i
    puts
  end

  $sticks[pile - 1] = $sticks[pile - 1] - choice ### Changes sticks to reflect the player choice of moves

  if $sticks.sum() == 0
=begin
  Line 53
  If the value of $sticks == 0 then
  that means that it has to be empty.
  Which means that all the values have
  to be zero. And if they are all zero,
  the game is over. So it sends the
  players to endgame.
=end
    End()
  end
  PlayerSwitch() ### This will go on inf until the above if statement catches the endgame
  Display()
end

def End() ### Checks the value of the $player bool, and returns the player that it is attributed to.
  if $player == true
    print $p1, " Wins! \n"
  else
    print $p2, " Wins! \n"
  end
  print "Game will Exit now \n"
  abort "INTENTIONAL GAME DESIGN" ### Stops the game, Kind of abrupt, but It gets the point across
end

puts
puts "The objective of the game is to take the last stick out of the pile."
puts "You may take as many sticks out as you want, but only one pile at a time"

Init() ### Starts the code, everything else is handled in function
