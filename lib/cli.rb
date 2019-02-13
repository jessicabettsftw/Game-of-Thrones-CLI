class CLI
  def initialize()
    puts "Peter Dinklage"
  end

  def main()
    puts "Game of Thrones API:"
    puts
    #loop
    loop do
      choice = prompt_user
      case choice
      when "exit"
        break
      else
        puts "Invalid choice! SHAME!!! *rings bell*"
      end
    end

  end

  def prompt_user
    puts "Enter a number or exit"
    gets.chomp.downcase
  end

end
