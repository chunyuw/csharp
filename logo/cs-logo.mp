u = 2cm;

path q[];
z1 = (-1.5u,-2u);
q1 :=      (-2u, 2u) -- (-2u,-2u) --        z1 ;
q2 :=  (z1+(1.1u,0)) -- (  0,-2u) -- (0,-0.75u);
q3 :=       (2u,-2u) -- ( 2u, 2u) --       -z1 ;
q4 := -(z1+(1.1u,0)) -- (  0, 2u) -- (0, 0.75u);

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
    
    pickup po;
    draw bbox currentpicture withcolor white;
  endgroup
enddef;

beginfig(1)
  cslogo(.675[green,white],(1,1,.5),.625[blue,white]);
  %cslogo(.675[green,black],(1,1,0),.625[blue,black]);
endfig;

beginfig(2)
  cslogo(black,black,black);
endfig;

end
