require "nokogiri"
require "htmlentities"
require "pp"

module MathML2AsciiMath

  def self.m2a(docxml)
    parse(docxml.root).gsub(/  /, " ")
  end

  def self.encodechars(x)
    x.gsub(/\u03b1/, "\\alpha").
      gsub(/\u03b2/, "\\beta").
      gsub(/\u03b3/, "\\gamma").
      gsub(/\u0393/, "\\Gamma").
      gsub(/\u03b4/, "\\delta").
      gsub(/\u0394/, "\\Delta").
      gsub(/\u03b5/, "\\epsilon").
      gsub(/\u025b/, "\\varepsilon").
      gsub(/\u03b6/, "\\zeta").
      gsub(/\u03b7/, "\\eta").
      gsub(/\u03b8/, "\\theta").
      gsub(/\u0398/, "\\Theta").
      gsub(/\u03d1/, "\\vartheta").
      gsub(/\u03b9/, "\\iota").
      gsub(/\u03ba/, "\\kappa").
      gsub(/\u03bb/, "\\lambda").
      gsub(/\u039b/, "\\Lambda").
      gsub(/\u03bc/, "\\mu").
      gsub(/\u03bd/, "\\nu").
      gsub(/\u03be/, "\\xi").
      gsub(/\u039e/, "\\Xi").
      gsub(/\u03c0/, "\\pi").
      gsub(/\u03a0/, "\\Pi").
      gsub(/\u03c1/, "\\rho").
      gsub(/\u03c2/, "\\beta").
      gsub(/\u03c3/, "\\sigma").
      gsub(/\u03a3/, "\\Sigma").
      gsub(/\u03c4/, "\\tau").
      gsub(/\u03c5/, "\\upsilon").
      gsub(/\u03c6/, "\\phi").
      gsub(/\u03a6/, "\\Phi").
      gsub(/\u03d5/, "\\varphi").
      gsub(/\u03c7/, "\\chi").
      gsub(/\u03c8/, "\\psi").
      gsub(/\u03a8/, "\\Psi").
      gsub(/\u03c9/, "\\omega").
      gsub(/\u22c5/, "*").
      gsub(/\u2217/, "**").
      gsub(/\u22c6/, "***").
      gsub(/\//, "//").
      gsub(/\\/, "\\\\").
      gsub(/\u00d7/, "xx").
      gsub(/\u22c9/, "|><").
      gsub(/\u22ca/, "><|").
      gsub(/\u22c8/, "|><|").
      gsub(/\u00f7/, "-:").
      gsub(/\u2218/, "@").
      gsub(/\u2295/, "o+").
      gsub(/\u2297/, "ox").
      gsub(/\u2299/, "o.").
      gsub(/\u2211/, "sum").
      gsub(/\u220f/, "prod").
      gsub(/\u2227/, "^^").
      gsub(/\u22c0/, "^^^").
      gsub(/\u2228/, "vv").
      gsub(/\u22c1/, "vvv").
      gsub(/\u2229/, "nn").
      gsub(/\u22c2/, "nnn").
      gsub(/\u222a/, "uu").
      gsub(/\u22c3/, "uuu").
      gsub(/\u2260/, "!=").
      gsub(/\u2264/, "<=").
      gsub(/\u2265/, ">=").
      gsub(/\u227a/, "-<").
      gsub(/\u227b/, ">-").
      gsub(/\u2aaf/, "-<=").
      gsub(/\u2ab0/, ">-=").
      gsub(/\u2208/, "in").
      gsub(/\u2209/, "!in").
      gsub(/\u2282/, "sub").
      gsub(/\u2283/, "sup").
      gsub(/\u2286/, "sube").
      gsub(/\u2287/, "supe").
      gsub(/\u2261/, "-=").
      gsub(/\u2245/, "~=").
      gsub(/\u2248/, "~~").
      gsub(/\u221d/, "prop").
      gsub(/\u00ac/, "not").
      gsub(/\u21d2/, "=>").
      gsub(/\u21d4/, "<=>").
      gsub(/\u2200/, "AA").
      gsub(/\u2203/, "EE").
      gsub(/\u22a5/, "_|_").
      gsub(/\u22a4/, "TT").
      gsub(/\u22a2/, "|--").
      gsub(/\u22a8/, "|==").
      gsub(/\u22a8/, "|==").
      gsub(/\u2329/, "(:").
      gsub(/\u232a/, ":)").
      gsub(/\u2329/, "<<").
      gsub(/\u232a/, ">>").
      gsub(/\u222e/, "oint").
      gsub(/\u2202/, "del").
      gsub(/\u2207/, "grad").
      gsub(/\u00b1/, "+-").
      gsub(/\u2205/, "O/").
      gsub(/\u221e/, "oo").
      gsub(/\u2135/, "aleph").
      gsub(/\u2234/, ":.").
      gsub(/\u2235/, ":'").
      gsub(/\u2220/, "/_").
      gsub(/\u25b3/, "/_\\").
      gsub(/\u2032/, "'").
      gsub(/~/, "tilde").
      gsub(/\u00a0\u00a0\u00a0\u00a0/, "qquad").
      gsub(/\u00a0\u00a0/, "quad").
      gsub(/\u00a0/, "\\ ").
      gsub(/\u2322/, "frown").
      gsub(/\u00a0/, "quad").
      gsub(/\u22ef/, "cdots").
      gsub(/\u22ee/, "vdots").
      gsub(/\u22f1/, "ddots").
      gsub(/\u22c4/, "diamond").
      gsub(/\u25a1/, "square").
      gsub(/\u230a/, "|__").
      gsub(/\u230b/, "__|").
      gsub(/\u2308/, "|~").
      gsub(/\u2309/, "~|").
      gsub(/\u2102/, "CC").
      gsub(/\u2115/, "NN").
      gsub(/\u211a/, "QQ").
      gsub(/\u211d/, "RR").
      gsub(/\u2124/, "ZZ").
      gsub(/\u2191/, "uarr").
      gsub(/\u2193/, "darr").
      gsub(/\u2190/, "larr").
      gsub(/\u2194/, "harr").
      gsub(/\u21d2/, "rArr").
      gsub(/\u21d0/, "lArr").
      gsub(/\u21d4/, "hArr").
      gsub(/\u2192/, "->").
      gsub(/\u21a3/, ">->").
      gsub(/\u21a0/, "->>").
      gsub(/\u2916/, ">->>").
      gsub(/\u21a6/, "|->")
  end

  def self.parse(node)
    out = ""
    if node.text?
      return encodechars(HTMLEntities.new.decode(node.text))
    else
      case node.name
      when "math"
        node.elements.each { |n| out << parse(n) }
        return out
      when "mrow"
        outarr = []
        node.children.each { |n| outarr << parse(n) }
        out = outarr.join("")
        if %w{mfrac msub munder munderover}.include? node.parent.name
          out = "(#{out})"
        end
        return out
      when "mfenced"
        outarr = []
        open = node["open"] || "("
        close = node["close"] || ")"
        separator = "," # TODO currently ignore the supplied separators
        node.children.each { |n| outarr << parse(n) }
        out = outarr.join(separator)
        return "#{open}#{out}#{close}"
      when "msqrt"
        node.children.each { |n| out << parse(n) }
        return "sqrt(#{out})"
      when "mfrac"
        return "(#{parse(node.elements[0])})/(#{parse(node.elements[1])})"
      when "msup"
        sup = parse(node.elements[1])
        sup = "(#{sup})" unless sup.length == 1
        op = parse(node.elements[0]).gsub(/ $/, "")
        return "#{op}^#{sup}"
      when "msub"
        sub = parse(node.elements[1])
        sub = "(#{sub})" unless sub.length == 1
        op = parse(node.elements[0]).gsub(/ $/, "")
        return "#{op}_#{sub}"
      when "munderover", "msubsup"
        sub = parse(node.elements[1])
        sub = "(#{sub})" unless sub.length == 1
        sup = parse(node.elements[2])
        sup = "(#{sup})" unless sup.length == 1
        op = parse(node.elements[0]).gsub(/ $/, "")
        return "#{op}_#{sub}^#{sup}"
      when "munder"
        elem1 = parse(node.elements[1])
        accent = case elem1
                 when "\u0332" then "ul"
                 when "\u23df" then "ubrace"
                 else
                   "underset"
                 end
        if accent == "underset"
          return "underset(#{elem1})(#{parse(node.elements[0])})"
        else
          return "#{accent} #{parse(node.elements[0])}"
        end
      when "mover"
        elem1 = parse(node.elements[1])
        accent = case elem1
                 when "\u005e" then "hat"
                 when "\u00af" then "bar"
                 when "\u2192" then "vec"
                 when "." then "dot"
                 when ".." then "ddot"
                 when "\u23de" then "obrace"
                 else
                   "overset"
                 end
        if accent == "overset"
          return "overset(#{elem1})(#{parse(node.elements[0])})"
        else
          return "#{accent} #{parse(node.elements[0])}"
        end
      when "mtable"
        rows = []
        node.children.each { |n| rows << parse(n) }
      when "mtr"
        cols = []
        node.children.each { |n| cols << parse(n) }
        return "[#{cols.join(",")}]"
      when "mtd"
        node.children.each { |n| out << parse(n) }
        return "#{out}"
      when "mn", "mtext"
        node.children.each { |n| out << parse(n) }
        return "#{out}"
      when "mi"
        # mi is not meant to have space around it, but Word is conflating operators and operands
        node.children.each { |n| out << parse(n) }
        out = " #{out} " if /[^a-zA-Z0-9',]|[a-z][a-z]/.match? out
        return out
      when "mo"
        node.children.each { |n| out << parse(n) }
        out = " #{out} " unless node["fence"]
        return out
      else
        node.to_xml
      end
    end
  end

end
