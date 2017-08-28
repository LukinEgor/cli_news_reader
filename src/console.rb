class Console
  def self.render(lines, position, *params)
    system 'clear'
    system 'stty cooked'

    render_info_line(params[0])

    lines.each_with_index do |line, index|
      if index == position
        puts "\e[#{red}m#{index}. #{line}\e[0m"
      elsif
        puts "\e[#{yellow}m#{index}. #{line}\e[0m"
      end
    end

    system 'stty raw -echo'
  end

  def self.render_info_line(params)
    if params && params.include?(:info)
      puts "\e[#{yellow}m#{params[:info]}\e[0m"
    else
      puts "\n"
    end
    puts "\e[#{yellow}m#{'-' * width}\e[0m"
  end

  def self.width
    IO.popen("tput cols")
      .reduce("") { |l,acc| acc << l.chomp }
      .to_i
  end

  def self.red
    31
  end

  def self.yellow
    33
  end
end
