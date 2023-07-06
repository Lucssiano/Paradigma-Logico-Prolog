/* Ejercicio Mansión Dreadbury, se sabe que: */
viveEnLaMansion(tiaAgatha).
viveEnLaMansion(elCarnicero).
viveEnLaMansion(charles).

% odiaA(elCarnicero, charles).
% odiaA(charles, tiaAgatha).
% odiaA(charles, elCarnicero).
% odiaA(tiaAgatha, tiaAgatha).

/* Se sabe que Agatha odia a todos aquellos que viven en la mansión, y no son el carnicero.
Charles odia a todos aquellos que no sean odiados por Agatha.
El carnicero odia a todos aquellos que Agatha odia.
Alguien es más rico que Agatha si vive en la Dreadbury y no es odiado por el carnicero.
Alguien asesinó a otra persona si la odia, no es más rica que esa persona, y vive en Dreadbury.

El objetivo es determinar quién asesinó a Agatha. */

persona(tiaAgatha).
persona(elCarnicero).
persona(charles).

odiaA(tiaAgatha,Persona):-
    viveEnLaMansion(Persona),
    Persona \= elCarnicero.

odiaA(charles,Persona):-
    viveEnLaMansion(Persona),
    not(odiaA(tiaAgatha,Persona)).

odiaA(elCarnicero,Persona):-
    odiaA(tiaAgatha,Persona).

esMasRicoQue(tiaAgatha,Persona):-
    viveEnLaMansion(Persona),
    not(odiaA(elCarnicero,Persona)).

asesinoA(Persona1,Persona2):-
    odiaA(Persona1,Persona2),
    not(esMasRicoQue(Persona2,Persona1)),
    viveEnLaMansion(Persona1).

% asesinoA(tiaAgatha,tiaAgatha) -- true