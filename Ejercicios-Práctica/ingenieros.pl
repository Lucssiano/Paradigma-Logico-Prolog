proyectos(juana,200).
proyectos(diego,50).
proyectos(javier,2).
proyectos(ana,0).


ingeniero(X):-proyectos(X,C),C>0.

/*
esExitoso(Ing):-
    ingeniero(Ing,_, Proyectos),
    Proyectos >= 40.
*/
habilidad(juana,rapidez).
habilidad(juana,creatividad).
habilidad(juana,productividad).
habilidad(diego,productividad).
habilidad(diego,rapidez).
habilidad(diego,creatividad).
habilidad(juana,gol).
%habilidad(cachito,tocarGuitarra).
%habilidad(diego,gol).

superHabilidoso(Alguien):-
    ingeniero(Alguien),
    %noLeFaltaNingunaHabilidad(Alguien).
    %noHayNadieConUnaHabilidadQueEsteNoTenga(Alguien).
    not(hayAlquienConUnaHabilidadQueNoTiene(Alguien)).

hayAlquienConUnaHabilidadQueNoTiene(Alguien):-
    habilidad(Otro,H),
    Otro \= Alguien,
    not(habilidad(Alguien,H)).

comprometido(Ing):-
    proyectos(Ing,Cant),
    not( hayOtroIngConMasProyectos(Ing,Cant)).


hayOtroIngConMasProyectos(Ing,Cant):-
    proyectos(Otro,OtraCant),
    Ing \= Otro,
    Cant < OtraCant.

ingenieroConHabilidad(I,H):-
    ingeniero(I),
    habilidad(I,H).


indispensable(Ing):-
    ingenieroConHabilidad(Ing,H1),
    not( hayOtroIngQueTieneEstaHabilidad(Ing, H1)).     

hayOtroIngQueTieneEstaHabilidad(Ing, H1):-
    ingenieroConHabilidad(Otro,H1) ,
    Otro \= Ing. 


habilidadRepetida(H):-
    ingenieroConHabilidad(Ing,H),
    ingenieroConHabilidad(Otro,H),
    Otro \= Ing.


indispensable2(Ing):-
    ingenieroConHabilidad(Ing,H),
    not(habilidadRepetida(H)).

losNoComprometidosTieneAlMenosEstaCantidadProyectos(Cant):-
forall((ingeniero(X),not(comprometido(X))),(proyectos(X,C),C<Cant)).

nnnnn(Persona):-
    ingeniero(Persona),
    forall(habilidad(Persona,H),habilidadRepetida(H)).