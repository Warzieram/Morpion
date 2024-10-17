require_relative 'Case.rb'

class Grille
  attr_accessor :cases
  def initialize
    @cases = []
    for ligne in 1..3 do
      current_ligne = []
      for case_ in 1..3 do
        current_ligne << Case.new()
      end
      @cases << current_ligne
    end
  end

  def coord_to_int(coord) #Convertit des coordonnées sous forme de string en couple [y,x] EXEMPLE : "a2" => [1,0]
    lettre = coord[0].upcase.ord
    chiffre = coord[1].to_i

    y = chiffre -1
    x = lettre - 65

    return [y, x]
  end 

  def get_case_from_coord(coord)
    coord = coord_to_int(coord)
    y = coord[0]
    x = coord[1]
    return @cases[y][x]
  end

  
  def display
    i=1

    puts "  A B C"
    
    for ligne in @cases
      puts "  ------" if ligne != @cases[0]
      print "#{i} "
      for case_ in ligne
        
        case_.display
        print '|' if case_ != ligne[-1]
      end
      print "\n"
      i += 1
    end
  end

  def play(coord, character)
    get_case_from_coord(coord).write(character)
  end





end

