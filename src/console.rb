require './src/color'
require './src/keyboard'

class Console
  def self.render(lines, position, options)
    system 'clear'
    Keyboard.reset_tty_params

    render_info_line(options[:info])

    lines.each_with_index do |line, y|
      if options[:mode] == :word
        select_word(line, y, position)
      else
        select_line(line, y, position)
      end
    end

    Keyboard.set_tty_params
  end

  def self.select_word(line, y, position)
    print "\e[#{Color.yellow}m#{y + 1}. \e[0m "
    line.split(' ').each_with_index do |word, x|
      if y == position.y && x == position.x
        print "\e[#{Color.red}m#{word}\e[0m "
      else
        print "\e[#{Color.yellow}m#{word}\e[0m "
      end
    end
    print "\n"
  end

  def self.select_line(line, y, position)
    if y == position.y
      puts "\e[#{Color.red}m#{y}. #{line}\e[0m "
    else
      puts "\e[#{Color.yellow}m#{y}. #{line}\e[0m "
    end
  end

  def self.render_info_line(info)
    if info
      puts "\e[#{Color.yellow}m#{info}\e[0m"
    else
      puts "\n"
    end
    puts "\e[#{Color.yellow}m#{'-' * width}\e[0m"
  end

  def self.width
    IO.popen("tput cols")
      .reduce("") { |l,acc| acc << l.chomp }
      .to_i
  end
end
