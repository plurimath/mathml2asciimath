require "spec_helper"

RSpec.describe MathML2AsciiMath do
  it "processes some MathML" do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to match_fuzzy <<~OUTPUT
    <math xmlns="http://www.w3.org/1998/Math/MathML">
    <mrow>
      <mi>a</mi> <mo>⋄</mo> <msup><mi>x</mi><mn>2</mn></msup>
      <mo>+</mo><mi>b</mi><mo>×</mo><mi>x</mi>
      <mo>+</mo><mi>c</mi>
    </mrow>
    </math>
    INPUT
    a diamond x^2\n  + b xx x\n  + c
    OUTPUT
  end
end
