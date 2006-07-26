u = 2cm;

beginfig(1)
  bboxmargin := 10bp;
  intrim linejoin := mitered;
  intrim linecap  := squared;
  s = 0.5;
  path p; p := (0,0)--(0,1)--(1,1)--(1,0)--cycle ;
  pen po; po := currentpen;
  pen pp; pp := makepen p shifted (-0.5,-0.5) xscaled 1.2u yscaled 1u;

  pickup pp;

  % draw (0,0) -- (1u,1u) -- (2u,0);
  z1 = (-1.5u,-2u);

  draw      (-2u, 2u) -- (-2u,-2u) --        z1    withcolor .625[green,black] ;
  draw  (z1+(1.1u,0)) -- (  0,-2u) -- (0,-0.75u)   withcolor (1,1,0) ;
  draw       (2u,-2u) -- ( 2u, 2u) --       -z1    withcolor .625[blue,black] ;
  draw -(z1+(1.1u,0)) -- (  0, 2u) -- (0, 0.75u)   withcolor (1,1,0) ;           

  currentpicture :=   currentpicture shifted (4u,4u);

  currentpicture := currentpicture slanted s yscaled 0.9;
  
  pickup po;
  draw bbox currentpicture withcolor white;

endfig

end
