continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).
limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).

/* PARTE A */

/* 1. loLiquidaron/1 que se cumple para un jugador si no ocupa ningún país. (x ej. el blanco) */
loLiquidaron(Jugador):-
  jugador(Jugador),
  not(ocupa(_,Jugador,_)).

/* 2. ocupaContinente/2 que relaciona un jugador y un continente si el jugador ocupa todos los países del mismo. */
ocupaContinente(Jugador,Continente):-
  jugador(Jugador),
  continente(Continente),
  forall(estaEn(Continente,Pais),ocupa(Pais,Jugador,_)). /* Siempre debe haber alguna variable libre en el antecedente, para decir "Para todo X, tal que X" */

/* 3. seAtrinchero/1 que se cumple para los jugadores que ocupan países en un único continente */
seAtrinchero(Jugador):-
  jugador(Jugador),
  continente(Continente),
  not(loLiquidaron(Jugador)), /* Sino me da blanco tmbn */
  forall(ocupa(Pais,Jugador,_),estaEn(Continente,Pais)). 
  % ocupa(Pais1,Jugador,_),
  % ocupa(Pais2,Jugador,_),
  % estaEn(Continente1,Pais1),
  % estaEn(Continente2,Pais2),
  % not(Continente1 \= Continente2).

/* PARTE B */
/* 4. puedeConquistar/2 que relaciona un jugador y un continente si este puede atacar a cada 
país que le falte. 
Es decir, no ocupa dicho continente, pero todos los países del mismo que no tiene
son limítrofes a alguno que ocupa y a su vez ese país no es de un aliado. */
% puedeConquistar(Jugador,Continente):-
%   jugador(Jugador),
%   continente(Continente),
%   not(ocupaContinente(Jugador,Continente)),
%   forall((estaEn(Continente,Pais),not(ocupa(Pais,Jugador,_))),(limitrofes(ocupa(OtroPais,Jugador,_),Pais),not(aliados(ocupa(Pais,Jugador2,_),Jugador)))).

/* 5. elQueTieneMasEjercitos/2 que relaciona un jugador y un país si se cumple que en ese país hay
más ejércitos que en los países del resto del mundo y a su vez ese país es ocupado por ese
jugador.
 */
elQueTieneMasEjercitos(Jugador,Pais):-
  jugador(Jugador),
  ocupa(Pais,Jugador,CantidadEjercitos),
  not(hayOtroConMasEjercitos(Pais,CantidadEjercitos)).

hayOtroConMasEjercitos(Pais,CantidadEjercitos):-
  ocupa(OtroPais,_,OtraCantidadEjercitos),
  Pais \= OtroPais,
  OtraCantidadEjercitos > CantidadEjercitos.

objetivo(amarillo, ocuparContinente(asia)).
objetivo(amarillo,ocuparPaises(2, americaDelSur)).
objetivo(blanco, destruirJugador(negro)).
objetivo(magenta, destruirJugador(blanco)). /* si */
objetivo(negro, ocuparContinente(oceania)). /* si pero no cumple el de conquistar america del sur, entonces da que no*/
objetivo(negro,ocuparContinente(americaDelSur)).

/* cumpleObjetivos/1 que se cumple para un jugador si cumple todos los objetivos que tiene.
Los objetivos se cumplen de la siguiente forma:
○ ocuparContinente: el jugador debe ocupar el continente indicado
○ ocuparPaises: el jugador debe ocupar al menos la cantidad de países indicada de ese
continente
○ destruirJugador: se cumple si el jugador indicado ya no ocupa ningún país */

cumpleObjetivos(Jugador):-
  jugador(Jugador),
  forall(objetivo(Jugador, Objetivo),cumplioObjetivo(Jugador, Objetivo)).

cumplioObjetivo(Jugador,ocuparContinente(Continente)):-
  ocupaContinente(Jugador,Continente).

cumplioObjetivo(Jugador,ocuparPaises(Cantidad,Continente)):-
  findall(Pais, (ocupa(Pais,Jugador,_),estaEn(Continente,Pais)), Paises),
  length(Paises, CantPaises),
  CantPaises >= Cantidad.

cumplioObjetivo(_,destruirJugador(OtroJugador)):-
  loLiquidaron(OtroJugador).

/* 7. leInteresa/2 que relaciona un jugador y un continente, y es cierto cuando alguno de sus
objetivos implica hacer algo en ese continente (en el caso de destruirJugador, si el jugador a
destruir ocupa algún país del continente). */
leInteresa(Jugador,Continente):-
  jugador(Jugador),
  continente(Continente),
  objetivo(Jugador,ocuparContinente(Continente)).
leInteresa(Jugador,Continente):-
  jugador(Jugador),
  continente(Continente),
  objetivo(Jugador,ocuparPaises(_,Continente)).
leInteresa(Jugador,Continente):-
    jugador(Jugador),
    continente(Continente),
    objetivo(Jugador,destruirJugador(OtroJugador)),
    ocupa(Pais,OtroJugador,_),
    estaEn(Continente,Pais).
  
  