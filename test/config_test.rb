require 'test/unit'
require './src/config'

class ConfigTest < Test::Unit::TestCase
  def test_lang_setting
    id = Config.translation.id
    assert_equal(id.class, Integer)

    sig = Config.translation.sig
    assert_equal(sig.class, String)

    from = Config.translation.lang.from
    assert_equal(from, "en")

    to = Config.translation.lang.to
    assert_equal(to, "ru")
  end
end
