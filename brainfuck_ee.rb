def brainfuckEE(code)
  ops = Hash.new('').merge({
    '>' => 'dp += 1',
    '<' => 'dp -= 1',
    '+' => 'mem[dp] += 1',
    '-' => 'mem[dp] -= 1',
    '.' => 'print mem[dp].chr',
    ',' => 'raise ", is unsupported and not enterprise-ready"',
    '[' => 'while mem[dp] != 0 do',
    ']' => 'end',
  })

  require 'stringio'
  ruby = StringIO.new
  ruby.puts 'mem = [0] * 30_000'
  ruby.puts 'dp = 0'
  code.each_char {|c| ruby.puts ops[c] }

  eval ruby.string
end
