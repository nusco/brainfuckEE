def brainfuckEE(code, input = '')
  ops = {
    '>' => 'dp += 1',
    '<' => 'dp -= 1',
    '+' => 'mem[dp] += 1',
    '-' => 'mem[dp] -= 1',
    '.' => 'print mem[dp].chr',
    ',' => 'mem[dp] = input.slice!(0).ord unless input.empty?',
    '[' => 'while mem[dp] != 0 do',
    ']' => 'end'
  }

  ruby = [
    'mem = Hash.new 0',
    'dp = 0',
    "input = '#{input}'",
    code.chars.map {|c| ops[c] }.compact
  ].join "\n"
  
  eval ruby
end
