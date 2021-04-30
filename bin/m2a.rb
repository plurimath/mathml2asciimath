require "mathml2asciimath"

STDIN.set_encoding("UTF-8")
while a = gets
  matches = a.split(%r{(<math.*?</math>)})
  out = ""
  matches.each do |x|
    out += if /<math/.match? x
             MathML2AsciiMath.m2a(x)
           else
             x
           end
  end
  print out
end
