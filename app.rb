require_relative "lib/Game"

game = Game.new


game.start

system "clear"
while !(game.check_win || game.check_draw) do
  game.display_grid
  game.play_turn
  break if (game.check_win || game.check_draw)
  game.next_turn
  system "clear"
end
system "clear"

game.display_grid
game.end_game