require 'io/console'

class Keyboard
  def initialize
    system 'stty raw -echo'
  end

  def listen
    @@queue = Queue.new
    run_listener
    loop do
      unless @@queue.empty?
        input = @@queue.shift
        handle_ctrl_keys(input)
        yield(input)
      end
    end
  end

  private

  def run_listener
    Thread.new do
      loop do
        input = STDIN.getc.chr
        if input == "\e" then
          input << STDIN.read_nonblock(3) rescue nil
          input << STDIN.read_nonblock(2) rescue nil
        end
        @@queue << input.rstrip
      end
    end
  end

  def handle_ctrl_keys(input)
    case input
    when "\u0003" #ctrl-c
      system 'stty raw echo'
      system 'stty cooked'
      exit 0
    end
  end
end
