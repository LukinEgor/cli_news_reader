require 'io/console'

class Keyboard
  def initialize
    Keyboard.set_tty_params
  end

  def self.set_tty_params
    system 'stty raw -echo'
  end

  def self.reset_tty_params
    system 'stty raw echo'
    system 'stty cooked'
  end

  def listen
    @@queue = Queue.new
    run_listener
    loop do
      unless @@queue.empty?
        input = @@queue.shift
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
end
