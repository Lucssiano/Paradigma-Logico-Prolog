/* Primera parte */
elecciones(2019).
elecciones(2021).

estudiantes(sistemas, 2021, juli).
estudiantes(mecanica, 2021, agus).
estudiantes(sistemas, 2021, dani).
estudiantes(mecanica, 2019, agus).
estudiantes(sistemas, 2019, dani).
estudiantes(mecanica, 2021, tati).

votos(franjaNaranja, 50, sistemas, 2019).
votos(franjaNaranja, 20, mecanica, 2019).
votos(agosto29, 10, mecanica, 2019).
votos(franjaNaranja, 100, sistemas, 2021).
votos(agosto29, 70, sistemas, 2021).

% 1) Quien ganó cada elección en la facultad.
punto1(Anio,Organizacion):-
  votos(Organizacion,CantidadVotos,_,Anio),
  forall(
    (votos(_,OtraCantidadVotos,_,Anio)),
    (CantidadVotos >= OtraCantidadVotos)).
/* ------------------------------------ */

/* findall(CantidadVotos, votos(Organizacion,CantidadVotos,_,Anio), CantidadesDeVotos),
  length(CantidadesDeVotos, Cantidad),
  sumlist(CantidadesDeVotos, Suma),
  VotosTotales1 is Suma, */

% 2) Si es cierto que siempre gana el mismo
punto2(Organizacion):-
  punto1(_,Organizacion),
  forall(elecciones(Anio), punto1(Anio,Organizacion)).
/* ------------------------------------ */