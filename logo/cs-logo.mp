%% Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>
%% $Rev$ $LastChangedDate$

%%%% OUTPUT
%% mpost   cs-logo.mp
%% convert cs-logo.1 cs-logo.jpg
%% convert cs-logo.3 -blur 0x01 cs-mask.jpg
%% convert cs-logo.1 -background transparent -transparent white cs-logo.png

u = 2cm;

pair m[];
m1 :=   (-2u, 2u);     m2 := (-2u,-2u);     m3 := (-1.5u,-2u);
m4  = m3+(1.1u,0);     m5 :=   (0,-2u);     m6 := (0,-0.75u);

path q[];
q1 :=  m1 --  m2 --  m3;	% left   green  strip
q2 :=  m4 --  m5 --  m6;	% bottom yellow strip
q3 := -m1 -- -m2 -- -m3;	% right  blue   strip
q4 := -m4 -- -m5 -- -m6;	% top    yellow strip

path p; p := (0,0)--(0,1)--(1,1)--(1,0)--cycle ;
pen po; po := currentpen;
pen pp; pp := makepen p shifted (-0.5,-0.5) xscaled 1.2u yscaled 1u;

def cslogo(expr a,b,c) = 
  begingroup
    bboxmargin := 10bp;
    intrim linejoin := mitered;
    intrim linecap  := squared;
    pickup pp;

    draw q1 withcolor a;  
    draw q2 withcolor b;
    draw q3 withcolor c;
    draw q4 withcolor b;

    currentpicture := currentpicture shifted (4u,4u) slanted 0.5 yscaled 0.9;

    % just for enlarge boundingbox
    pickup po;
    draw bbox currentpicture withcolor white;
  endgroup
enddef;

beginfig(1) 			% dark color
  cslogo(.675[green,black],(1,1,0),.625[blue,black]);
endfig;

beginfig(2)			% light color
  cslogo(.675[green,white],(1,1,.5),.625[blue,white]);
endfig;

beginfig(3)			% logo mask
  cslogo(black,black,black);
endfig;

end
