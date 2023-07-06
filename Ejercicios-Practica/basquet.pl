suceso(yimi,triple(34,10)).
suceso(yimi,simple(35)).
suceso(nicola,doble(39,6)).
suceso(nicola,doble(48,6)).
suceso(jordan,jugada(48,volcada)).
suceso(malone,falta(47,yimi)).

duracionPartido(48).

equipo(yimi,miami).
equipo(nicola,denver).

premio(Jugador):-
    suceso(Jugador,T),
    aplaudida(T).

premio(Jugador):-
    suceso(Jugador,T),
    calificacion(T,Calif),
    Calif > 50.

aplaudida(triple(_,D)):-D >= 10.
aplaudida(Anotacion):- 
    enMinuto(Anotacion,M), 
    duracionPartido(M).
aplaudida(jugada(_,volcada)).

enMinuto(doble(M,_),M).
%enMinuto(triple(M,_), M). 
enMinuto(simple(M),M). 


/*
hizoUnaAnotacionLuegoDe(Jugador,Otro):-
    suceso(Jugador,tanto(_,M1,_)),
    suceso(Otro,tanto(_,M2,_)),
    M1 > M2.
*/

hizoUnaAnotacionLuegoDe(Jugador,Otro):-
    suceso(Jugador,T1),
    suceso(Otro,T2),
    esPosterior(T1, T2).

esPosterior(A1,A2):-
    enMinuto(A1,M1),
    enMinuto(A2,M2),
    M1 > M2.

   

calificacion(triple(M,D),Calificacion):-
    Calificacion is D * 2.
calificacion(doble(M,D),Calificacion):-
    Calificacion is D + M * 2.
calificacion(simple(M),10).
calificacion(falta(M,_),Calif):-Calif is M + 10.

esMejor(T1,T2):-
    calificacion(T1,Calif1),
    calificacion(T2,Calif2),
    Calif1 > Calif2.


jugadorConSuMejorSuceso(Jugador,Suceso):-
    suceso(Jugador,Suceso),
    calificacion(Suceso,Calif),
    forall( 
        (suceso(Jugador,OtroSuc),calificacion(OtroSuc,OtraCalif)),
        ( Calif >= OtraCalif)   
    ).


elMejorSucesoDeTodosYQuienLoHizo(Suceso,Jugador):-
        suceso(Jugador,Suceso),
        calificacion(Suceso,Calif),
        forall( 
            (suceso(_,OtroSuc),calificacion(OtroSuc,OtraCalif)),
            ( Calif >= OtraCalif)   
        ).