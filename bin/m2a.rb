require "mathml2asciimath"

STDIN.set_encoding("UTF-8")
while a = gets
  matches = a.split(%r{(<math.*?</math>)})
  out = ""
  matches.each do |x|
    if /<math/.match? x
      docxml = Nokogiri::XML(x)
      out += MathML2AsciiMath.m2a(docxml)
    else
      out += x
    end
  end
  print out
end


