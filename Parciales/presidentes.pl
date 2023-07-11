/* 1) Los presidentes
Se cuenta con informacion acerca de los períodos presidenciales. Se conoce el nombre del presidente, la fecha de inicio y la fecha de finalización, ambas con día mes y año. Si un presidente fue electo en más de una ocasión se encuentra la información de cada uno de sus períodos

Por ejemplo Alfonsin: 10/12/1983 - 7/7/1989 Menem: 8/7/1989 - 9/12/1995 Menem: 10/12/1995 - 9/12/1999 Puerta: 21/12/2001 - 23/12/2001

Se quiere averiguar:

a. Quiénes fueron presidente por más de un período (sin importar si fueron sucesivos o no) (Menem)

b. En una fecha dada, quién era el presidente. (22/12/2001? Puerta) */

fuePresidente(alfonsin).
fuePresidente(menem).
fuePresidente(puerta).

periodoPresidencial(alfonsin, fechaInicio(10,12,1983), fechaFin(7,7,1989)).
periodoPresidencial(menem, fechaInicio(8,7,1989), fechaFin(9,12,1995)).
periodoPresidencial(menem, fechaInicio(10,12,1995), fechaFin(9,12,1999)).
periodoPresidencial(puerta, fechaInicio(21,12,2001), fechaFin(23,12,2001)).

presidentePorMasDeUnPeriodo(Presidente):-
  fuePresidente(Presidente),
  periodoPresidencial(Presidente,FechaDeInicio1,_),
  periodoPresidencial(Presidente,FechaDeInicio2,_),
  FechaDeInicio1 \= FechaDeInicio2.

% quienEraElPresidente(Presidente, Fecha):-
%   periodoPresidencial(Presidente,FechaInicio,FechaFinal),
%   anterior(Fecha,FechaFinal),
%   anterior(FechaInicio,Fecha).

% anterior(fecha(_,_,A1),fecha(_,_,A2)):- A2 > A1.
% anterior(fecha(_,M1,A),fecha(_,M2,A)):- M2 > M1.
% anterior(fecha(D1,M,A),fecha(D2,M,A)):- D2 >= D1.

acciones(juicioALasJuntas,fecha(9,12,1985),buenosAires,30000000).
acciones(hiperInflacion,fecha(1,1,1989),buenosAires,10).
acciones(privatizacionYPF,fecha(3,5,1992),campana,1).

accionesBuenas(Accion):-
  acciones(Accion,_,_,CantBeneficiarios),
  CantBeneficiarios > 10000.

presidenteBuenaAccion(Presidente):-
  periodoPresidencial(alfonsin, fechaInicio(10,12,1983), fechaFin(7,7,1989)).
