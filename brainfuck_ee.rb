def brainfuckEE(code, input = '')
  ops = {
    '>' => 'dp += 1',
    '<' => 'dp -= 1',
    '+' => 'mem[dp] += 1',
    '-' => 'mem[dp] -= 1',
    '.' => 'print mem[dp].chr',
    ',' => '(c = input.slice!(0)) ? mem[dp] = c.ord : return',
    '[' => 'while mem[dp] != 0 do',
    ']' => 'end'
  }

  ruby = [
    'lambda {',
    'mem = [0] * 30_000',
    'dp = 0',
    "input = '#{input}'",
    code.chars.map {|c| ops[c] }.compact,
    '}.call'
  ].join "\n"
  
  eval ruby
end
