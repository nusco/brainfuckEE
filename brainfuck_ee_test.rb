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
    code = "
      +++++ +++++             initialize counter (cell #0) to 10
      [                       use loop to set the next four cells to 70/100/30/10
          > +++++ ++              add  7 to cell #1
          > +++++ +++++           add 10 to cell #2 
          > +++                   add  3 to cell #3
          > +                     add  1 to cell #4
          <<<< -                  decrement counter (cell #0)
      ]                   
      > ++ .                  print 'H'
      > + .                   print 'e'
      +++++ ++ .              print 'l'
      .                       print 'l'
      +++ .                   print 'o'
      > ++ .                  print ' '
      << +++++ +++++ +++++ .  print 'W'
      > .                     print 'o'
      +++ .                   print 'r'
      ----- - .               print 'l'
      ----- --- .             print 'd'
      > + .                   print '!'
      > .                     print '\n'"
    brainfuckEE(code)
    assert_equal "Hello World!\n", @output.string
  end
  
  def test_rot_13
    code = "
      -,+[                         Read first character and start outer character reading loop
          -[                       Skip forward if character is 0
              >>++++[>++++++++<-]  Set up divisor (32) for division loop
                                     (MEMORY LAYOUT: dividend copy remainder divisor quotient zero zero)
              <+<-[                Set up dividend (x minus 1) and enter division loop
                  >+>+>-[>>>]      Increase copy and remainder / reduce divisor / Normal case: skip forward
                  <[[>+<-]>>+>]    Special case: move remainder back to divisor and increase quotient
                  <<<<<-           Decrement dividend
              ]                    End division loop
          ]>>>[-]+                 End skip loop; zero former divisor and reuse space for a flag
          >--[-[<->+++[-]]]<[         Zero that flag unless quotient was 2 or 3; zero quotient; check flag
              ++++++++++++<[       If flag then set up divisor (13) for second division loop
                                     (MEMORY LAYOUT: zero copy dividend divisor remainder quotient zero zero)
                  >-[>+>>]         Reduce divisor; Normal case: increase remainder
                  >[+[<+>-]>+>>]   Special case: increase remainder / move it back to divisor / increase quotient
                  <<<<<-           Decrease dividend
              ]                    End division loop
              >>[<+>-]             Add remainder back to divisor to get a useful 13
              >[                   Skip forward if quotient was 0
                  -[               Decrement quotient and skip forward if quotient was 1
                      -<<[-]>>     Zero quotient and divisor if quotient was 2
                  ]<<[<<->>-]>>    Zero divisor and subtract 13 from copy if quotient was 1
              ]<<[<<+>>-]          Zero divisor and add 13 to copy if quotient was 0
          ]                        End outer skip loop (jump to here if ((character minus 1)/32) was not 2 or 3)
          <[-]                     Clear remainder from first division if second division was skipped
          <.[-]                    Output ROT13ed character from copy and clear it
          <-,+                     Read next character
      ]                            End character reading loop"
    brainfuckEE(code, 'abcd')
    assert_equal "nopq", @output.string
  end
  
  def test_ignores_extra_chars
    code = '+++++  ++++[>+++ahah++\n++<-]>++.'
    brainfuckEE(code)
    assert_equal "A", @output.string
  end
end
