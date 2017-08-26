class Console
  def self.render(lines, position)
    system 'clear'
    system 'stty cooked'

    lines.each_with_index do |line, index|
      if index == position
        puts "\e[#{red}m#{index}. #{line}\e[0m"
      elsif
        puts "\e[#{yellow}m#{index}. #{line}\e[0m"
      end
    end

    system 'stty raw -echo'
  end

  def self.red
    31
  end

  def self.yellow
    33
  end
end
