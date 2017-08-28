require './src/console'
require './src/cursor'
require './src/newsfeed_container'
require './src/reader/main_reader_state'

class Reader
  def initialize(sources)
    newsfeed_containers = sources.map { |source| NewsFeedContainer.new(source) }
    @state = MainReaderState.new(newsfeed_containers)
  end

  def exec(action)
    @state.send(action) if @state.respond_to?(action)
    @state = @state.next(action)
  end
end
