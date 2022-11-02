# Execute the Mandelbrot generator from https://sange.fi/esoteric/brainfuck/utils/mandelbrot/
# This is one of the most complicated known Brainfuck programs.

require_relative 'brainfuck_ee'
require 'net/http'
require 'uri'

def load_program()
  url = 'https://sange.fi/esoteric/brainfuck/utils/mandelbrot/mandelbrot.b'
  page_content = Net::HTTP.get(URI.parse(url))
  page_content.lines[1..-1].join  # Remove teh first line
end

brainfuckEE(load_program)