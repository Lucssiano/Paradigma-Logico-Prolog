/* 1. Modelar los jugadores y elementos y agregarlos a la base de conocimiento, utilizando los
ejemplos provistos. */
tiene(ana, agua).
tiene(ana, vapor).
tiene(ana, tierra).
tiene(ana, hierro).
tiene(beto, Elemento):-
    tiene(ana, Elemento).
tiene(cata, fuego).
tiene(cata, agua).
tiene(cata, aire).
tiene(cata, tierra).

jugador(ana).
jugador(beto).
jugador(cata).

compuesto(pasto, [agua, tierra]).
compuesto(hierro, [fuego, agua, tierra]).
compuesto(huesos, [pasto, agua]).
compuesto(vapor, [agua, fuego]).
compuesto(presion, [hierro, vapor]).
compuesto(plastico, [huesos, presion]).
compuesto(silicio, [tierra]).
compuesto(play, [silicio, hierro, plastico]).

% Los círculos alquímicos tienen diámetro en cms y cantidad de niveles.
% Las cucharas tienen una longitud en cms.
% Hay distintos tipos de libro.
herramienta(ana, circulo(50,3)).
herramienta(ana, cuchara(40)).
herramienta(beto, circulo(20,1)).
herramienta(beto, libro(inerte)).
herramienta(cata, libro(vida)).
herramienta(cata, circulo(100,5)).

/* 2. Saber si un jugador tieneIngredientesPara construir un elemento, que es cuando tiene
ahora en su inventario todo lo que hace falta */
tieneIngredientesPara(Jugador,Elemento):-
  jugador(Jugador),
  compuesto(Elemento,MaterialesNecesarios),
  forall(member(Material,MaterialesNecesarios),tiene(Jugador,Material)).

/* 3. Saber si un elemento estaVivo. Se sabe que el agua, el fuego y todo lo que fue
construido a partir de alguno de ellos, están vivos. Debe funcionar para cualquier nivel. */
estaVivo(agua).
estaVivo(fuego).
estaVivo(Elemento):-
  compuesto(Elemento, MaterialesNecesarios),
  member(OtroElemento,MaterialesNecesarios),
  estaVivo(OtroElemento).
  