class Keyboard
  def self.listen
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

  def self.run_listener
    Thread.new do
      loop do
        begin
          STDIN.echo = false
          STDIN.raw!
          input = STDIN.getc.chr
          if input == "\e" then
            input << STDIN.read_nonblock(3) rescue nil
            input << STDIN.read_nonblock(2) rescue nil
          end
          @@queue << input.rstrip
        ensure
          STDIN.echo = true
          STDIN.cooked!
        end
      end
    end
  end
end
