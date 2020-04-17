require 'spec_helper'

RSpec.describe MathML2AsciiMath do
  it 'processes mstyle and mrow' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mstyle>
      <mrow>
        <mi>a</mi> <mo>⋄</mo> <msup><mi>x</mi><mn>2</mn></msup>
        <mo>+</mo><mi>b</mi><mo>×</mo><mi>x</mi>
        <mo>+</mo><msub><mi>c</mi><mn>3</mn></msub>
      </mrow>
      </mstyle>
    </math>
    INPUT
    a diamond x^2 + b xx x + c_3
    OUTPUT
  end

  it 'processes mrow' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mrow>
        <mi>a</mi> <mo>⋄</mo> <msup><mi>x</mi><mn>2d</mn></msup>
        <mo>+</mo><mi>b</mi><mo>×</mo><mi>x</mi>
        <mo>+</mo><msub><mi>c</mi><mn>ab</mn></msub>
      </mrow>
    </math>
    INPUT
    a diamond x^(2d) + b xx x + c_(ab)
    OUTPUT
  end

  it 'processes mfrac' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mfrac>
        <mrow> <mn> 1 </mn> <mo> + </mo> <msqrt> <mn> 5 </mn> </msqrt> </mrow>
        <mn> 2 </mn>
      </mfrac>
    </math>
    INPUT
    ((1 + sqrt(5)))/(2)
    OUTPUT
  end

  it 'processes mfenced default' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mfenced><mrow><mi> a </mi> <mo> + </mo> <mi> b </mi></mrow></mfenced>
    </math>
    INPUT
    (a + b)
    OUTPUT
  end

  it 'processes mfenced with unmatching braces' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.to_s.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mfenced open="["> <mn> 0 </mn> <mn> 1 </mn> </mfenced>
    </math>
    INPUT
    [0,1)
    OUTPUT
  end

  it 'processes munderover' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <munderover>
        <mo>&#x222B;</mo> <mn>0</mn> <mi>&#x221E;</mi>
      </munderover>
    </math>
    INPUT
    int_0^(oo)
    OUTPUT
  end

  it 'processes msubsup' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <msubsup>
        <mo>&#x222B;</mo>
        <mn>ab</mn>
        <mn>ds</mn>
      </msubsup>
    </math>
    INPUT
    int_(ab)^(ds)
    OUTPUT
  end

  it 'processes ubrace' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <munder>
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo> &#x23DF;</mo>
      </munder>
    </math>
    INPUT
    ubrace (x + y + z)
    OUTPUT
  end

  it 'processes ul' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <munder>
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo> &#x0332;</mo>
      </munder>
    </math>
    INPUT
    ul (x + y + z)
    OUTPUT
  end

  it 'processes underset' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <munder>
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo>fred </mo>
      </munder>
    </math>
    INPUT
    underset(fred)((x + y + z))
    OUTPUT
  end

  it 'processes obrace' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mover accent="true">
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo> &#x23DE;</mo>
      </mover>
    </math>
    INPUT
    obrace x + y + z
    OUTPUT
  end

  it 'processes hat' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mover accent="true">
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo> &#x5e;</mo>
      </mover>
    </math>
    INPUT
    hat x + y + z
    OUTPUT
  end

  it 'processes bar' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mover accent="true">
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo> &#xaf;</mo>
      </mover>
    </math>
    INPUT
    bar x + y + z
    OUTPUT
  end

  it 'processes vec' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mover accent="true">
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo>&#x2192;</mo>
      </mover>
    </math>
    INPUT
    vec x + y + z
    OUTPUT
  end

  it 'processes dot' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mover accent="true">
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo> .</mo>
      </mover>
    </math>
    INPUT
    dot x + y + z
    OUTPUT
  end

  it 'processes ddot' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mover accent="true">
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo>..</mo>
      </mover>
    </math>
    INPUT
    ddot x + y + z
    OUTPUT
  end

  it 'processes overset' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mover accent="true">
        <mrow>
          <mi> x </mi>
          <mo> + </mo>
          <mi> y </mi>
          <mo> + </mo>
          <mi> z </mi>
        </mrow>
        <mo>fred</mo>
      </mover>
    </math>
    INPUT
    overset(fred)(x + y + z)
    OUTPUT
  end

  it 'processes mtable' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mi>X</mi>
      <mo>=</mo>
      <mtable frame="solid" rowlines="solid" align="axis 3">
          <mtr>
               <mtd><mi>A</mi></mtd>
               <mtd><mi>B</mi></mtd>
          </mtr>
          <mtr>
               <mtd><mi>C</mi></mtd>
               <mtd><mi>D</mi></mtd>
          </mtr>
          <mtr>
               <mtd><mi>E</mi></mtd>
               <mtd><mi>F</mi></mtd>
          </mtr>
      </mtable>
    </math>
    INPUT
    X = [[A,B],[C,D],[E,F]]
    OUTPUT
  end

  it 'processes <semantics> wrapping element' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <semantics>
        <mrow>
          <mover accent="true">
            <mi>&#x3BB;</mi>
            <mo>&#xAF;</mo>
          </mover>
          <mo stretchy="false">(</mo>
          <msub>
            <mi>t</mi>
            <mn>1</mn>
          </msub>
          <mo>,</mo>
          <mtext>&#x2009;</mtext>
          <msub>
            <mi>t</mi>
            <mn>2</mn>
          </msub>
          <mo stretchy="false">)</mo>
        </mrow>
      </semantics>
    </math>
    INPUT
    bar lambda ( t_1 , t_2 )
    OUTPUT
  end

  it 'processes <math> without xmlns' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math>
      <semantics>
        <mrow>
          <mover accent="true">
            <mi>z</mi>
            <mo>&#xAF;</mo>
          </mover>
          <mo stretchy="false">(</mo>
          <msub>
            <mi>t</mi>
            <mn>1</mn>
          </msub>
          <mo>,</mo>
          <mtext>&#x2009;</mtext>
          <msub>
            <mi>t</mi>
            <mn>2</mn>
          </msub>
          <mo stretchy="false">)</mo>
        </mrow>
      </semantics>
    </math>
    INPUT
    bar z ( t_1 , t_2 )
    OUTPUT
  end

  it 'processes and skips <annotation> element' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math>
      <semantics>
        <mrow>
          <mover accent="true">
            <mi>z</mi>
            <mo>&#xAF;</mo>
          </mover>
          <mo stretchy="false">(</mo>
          <msub>
            <mi>t</mi>
            <mn>1</mn>
          </msub>
          <mo>,</mo>
          <mtext>&#x2009;</mtext>
          <msub>
            <mi>t</mi>
            <mn>2</mn>
          </msub>
          <mo stretchy="false">)</mo>
        </mrow>
        <annotation encoding="MathType-MTEF">MathType@MTEF@5@5@+=feaagCart1ev2aaatCvAUfeBSjuyZL2yd9gzLbvyNv2CaerbuLwBLnhiov2DGi1BTfMBaeXatLxBI9gBaerbbjxAHXgarqqtubsr4rNCHbGeaGqipG0dh9qqWrVepG0dbbL8F4rqqrVepeea0xe9LqFf0xc9q8qqaqFn0lXdHiVcFbIOFHK8Feea0dXdar=Jb9hs0dXdHuk9fr=xfr=xfrpeWZqaaeqabiGaciGacaqadmaadaqaaqaaaOqaaiqadQhagaqeaiaacIcacaWG0bWaaSbaaSqaaiaaigdaaeqaaOGaaiilaiaaysW7caWG0bWaaSbaaSqaaiaaikdaaeqaaOGaaiykaaaa@3DCE@</annotation>
      </semantics>
    </math>
    INPUT
    bar z ( t_1 , t_2 )
    OUTPUT
  end

  it 'does not include non-significant whitespaces (spaces between nodes)' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math> <semantics> <mrow> <msub> <mi>x</mi> <mn>1</mn> </msub> <mo>,</mo><mtext> </mtext><msub> <mi>x</mi> <mn>2</mn> </msub> <mo>,</mo><mtext> </mtext><mtext> </mtext><mo>…</mo><mtext> </mtext><mtext> </mtext><mtext> </mtext><msub> <mi>x</mi> <mi>n</mi> </msub> </mrow> <annotation encoding='MathType-MTEF'>MathType@MTEF@5@5@+= feaagKart1ev2aqatCvAUfeBSjuyZL2yd9gzLbvyNv2CaerbbjxAHX garuavP1wzZbItLDhis9wBH5garmWu51MyVXgarqqtubsr4rNCHbGe aGqipG0dh9qqWrVepG0dbbL8F4rqqrVepeea0xe9LqFf0xc9q8qqaq Fn0lXdHiVcFbIOFHK8Feea0dXdar=Jb9hs0dXdHuk9fr=xfr=xfrpe WZqaaeGaciWaamGadaGadeaabaGaaqaaaOqaaiaadIhadaWgaaWcba GaaGymaaqabaGccaGGSaGaaGjbVlaadIhadaWgaaWcbaGaaGOmaaqa baGccaGGSaGaaGjbVlaaykW7cqWIMaYscaaMc8UaaGPaVlaaysW7ca WG4bWaaSbaaSqaaiaad6gaaeqaaaaa@4713@ </annotation> </semantics> </math>
    INPUT
    x_1 , x_2 , ... x_n
    OUTPUT
  end

  it 'processes unknown MathML' do
    expect(MathML2AsciiMath.m2a(<<~INPUT)).to eq <<~OUTPUT.strip
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mrow>
        <mi> x </mi>
        <mo> + </mo>
        <mphantom>
          <mi> y </mi>
          <mo> + </mo>
        </mphantom>
        <mi> z </mi>
      </mrow>
    </math>
    INPUT
    x + <math xmlns="http://www.w3.org/1998/Math/MathML"><mphantom>
     <mi> y </mi>
     <mo> + </mo>
    </mphantom></math> z
    OUTPUT
  end


end
