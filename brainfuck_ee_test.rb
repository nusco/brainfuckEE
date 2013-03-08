require 'test/unit'
require_relative 'brainfuck_ee'

class BrainfuckEETest < Test::Unit::TestCase
  def setup
    require 'stringio'
    @output = StringIO.new
    $stdout, @stdout = @output, $stdout
  end

  def teardown
    $stdout = @stdout
  end
  
  def test_hello_world
    code = '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.'
    brainfuckEE(code)
    assert_equal "Hello World!\n", @output.string
  end
  
  def test_ignores_extra_chars
    code = '+++++  ++++[>+++ahah++\n++<-]>++.'
    brainfuckEE(code)
    assert_equal "A", @output.string
  end
end
