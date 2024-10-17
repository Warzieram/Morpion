require_relative "Grille"
require_relative "Player"
require 'colorized_string'

class Game
  attr_accessor :players, :grille, :turn, :characters, :winner, :colors
  def initialize
    @grille = Grille.new
    @players = []
    @characters = ["X", "O"]
    @colors = [:blue, :red]
    @turn = 0
    @winner = -1
    #ColorizedString.add_color_alias(:niebeski, :blue)
  end

  def start

    for i in 1..2 do
      puts "Joueur #{i} entrez votre nom :"
      print "> "
      j_name = gets.chomp
      player = Player.new(j_name, @characters[i-1])
      @players << player
    end

    puts "#{@players[0].name} sera les X"
    puts "#{@players[1].name} sera les O"
  end

  def current_player
    @players[@turn]
  end

  def next_turn
    @turn = @turn == 0 ? 1:0
  end

  def play_turn

    puts "Tour de #{current_player.name}\n"
    puts "Veuillez Entrer une coordonnée :"
    print "> "
    choice = gets.chomp

    valid_entry = false
    
    while !valid_entry do
      
      if (choice.upcase =~ /[A-C][1-3]/ && grille.get_case_from_coord(choice).occupation == " ")
        @grille.play(choice, ColorizedString[current_player.character].colorize(@colors[@turn]))
        valid_entry = true
      else
        puts "Veuillez entrer des coordonnées valides !"
        print "> "
        choice = gets.chomp
      end
    end
  end

  def check_win

    win = false
    matrice = @grille.cases
    curr_char = ColorizedString[current_player.character].colorize(@colors[@turn])

    #check horizontal
    h_win = false
    
    for ligne in matrice do
      h_win = h_win || (ligne.all? { |element| element.occupation == curr_char })
    end

    #check vertical
    v_win = false
    for colonne in 0..2 do
      v_win |= matrice.all? { |ligne| ligne[colonne].occupation == curr_char }
    end

    #check diagonal
    d_win = d_win || (matrice[0][0].occupation == curr_char && matrice[1][1].occupation == curr_char && matrice[2][2].occupation == curr_char)
    d_win = d_win || (matrice[0][2].occupation == curr_char && matrice[1][1].occupation == curr_char && matrice[2][0].occupation == curr_char)


    win = h_win || v_win || d_win
    @winner = win ? turn : @winner

    return win
  end

  def check_draw
    draw = true
    for ligne in @grille.cases do
      for case_ in ligne do
        draw &= case_.occupation != " "
      end
    end

    return draw
  end

  def end_game
    
    case @winner
    when 0..1
      puts "Bravo #{@players[winner].name} tu as gagné !"
    else
      puts "Egalité ! (évidemment...)"
    end
  end

  def display_grid
    @grille.display
  end

end
