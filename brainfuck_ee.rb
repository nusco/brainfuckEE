def brainfuckEE(code, input = '')
  ops = Hash.new('').merge({
    '>' => 'dp += 1',
    '<' => 'dp -= 1',
    '+' => 'mem[dp] += 1',
    '-' => 'mem[dp] -= 1',
    '.' => 'print mem[dp].chr',
    ',' => 'return if input.empty?; mem[dp] = input[0].ord; input = input[1..-1]',
    '[' => 'while mem[dp] != 0 do',
    ']' => 'end',
  })

  require 'stringio'
  ruby = StringIO.new
  ruby.puts 'lambda {'
  ruby.puts 'mem = [0] * 30_000'
  ruby.puts 'dp = 0'
  ruby.puts "input = '#{input}'"
  code.each_char {|c| ruby.puts ops[c] }
  ruby.puts '}.call'
  
  eval ruby.string
end
