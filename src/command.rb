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
    else
      :nothing
    end
  end
end
