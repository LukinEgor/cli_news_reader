class Command
  def initialize(input)
    @input = input
  end

  def action
    case @input
    when 'j'
      :down
    when 'k'
      :up
    when 'o'
      :open
    when 'p'
      :back
    when 'h'
      :left
    when 'l'
      :right
    when 't'
      :translate
    when 'q', "\u0003"
      Keyboard.reset_tty_params
      exit 0
    else
      :nothing
    end
  end
end
