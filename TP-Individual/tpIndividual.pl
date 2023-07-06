/* Definir los hechos y reglas que permitan deducir cuándo un ingeniero/a en sistemas es considerado 
. exitoso/a
. indispensable
. comprometido/a
Mostrar ejemplos de consulta
Importante: usar al menos una vez los predicados not/1 e is/2 */

% Nombre - IQ - Salario
ingeniero(luciano, 90,300000).
ingeniero(lucas, 100, 350000).
ingeniero(joaco, 120, 400000).
ingeniero(gonzalo, 150, 500000).

impuntual(joaco).
impuntual(luciano).

eficiente(gonzalo).
eficiente(joaco).
eficiente(lucas).

eficaz(lucas).
eficaz(gonzalo).

organizado(luciano).
organizado(gonzalo).
organizado(lucas).

tieneIQMayorA100(Ingeniero):-
  ingeniero(Ingeniero, NumeroIQ, _),
  NumeroASuperar is 100,
  NumeroIQ > NumeroASuperar.

esFeliz(Ingeniero):-
  ingeniero(Ingeniero, _, Salario),
  SalarioAnual is Salario * 12,
  SalarioAnual > 4500000.
  
esIngenieroExitoso(Ingeniero):-
  ingeniero(Ingeniero, _, _),
  tieneIQMayorA100(Ingeniero),
  esFeliz(Ingeniero),
  esIngenieroIndispensable(Ingeniero).

esIngenieroComprometido(Ingeniero):-
  ingeniero(Ingeniero, _, _),
  not(impuntual(Ingeniero)),
  organizado(Ingeniero).

esIngenieroIndispensable(Ingeniero):-
  ingeniero(Ingeniero, _, _),
  not(impuntual(Ingeniero)),
  eficiente(Ingeniero),
  eficaz(Ingeniero).
    



