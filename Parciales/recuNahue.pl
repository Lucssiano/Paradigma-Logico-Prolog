/* El objetivo es deducir los posibles integrantes para un nuevo equipo y su presupuesto. 
En particular, se busca definir un predicado que relacione a una persona que sea la vocera del equipo, 
otra que sea la experta, y una más de apoyo. Además, se quiere calcular el presupuesto necesario para contratarlas: 
equipo(Vocero/a, Experto/a, Apoyo, Presupuesto). 
*/

% Premiado puede ser una persona o una institución educativa.
% recibioPremio(Premiado). 
recibioPremio(luciano).
recibioPremio(joaco).
recibioPremio(dante).
recibioPremio(inaki).
recibioPremio(utn).
recibioPremio(uba).
recibioPremio(lucas).

% Indica quién estudio en qué institucion educativa y una nota promedio de su desempeño academico en dicha institución. 
% estudio(Persona, Institucion, NotaPromedio). 
estudio(luciano,utn,8). /* Vocero - Apoyo */
estudio(joaco,utn,9). /* Vocero - Apoyo */
estudio(dante,utn,10). /* Vocero - Apoyo */
estudio(inaki,uba,9). /* Vocero - Experto - Apoyo */
estudio(inaki,utn,8). /* Vocero - Experto - Apoyo */
estudio(inaki,unsam,10). /* Vocero - Experto - Apoyo */
estudio(julian,unlam,10). /* Vocero - Experto - Apoyo */
estudio(julian,utn,8). /* Vocero - Experto - Apoyo */
estudio(julian,unsam,8). /* Vocero - Experto - Apoyo */
estudio(federico,unsam,3). /* Apoyo */
estudio(lucas,tresF,9). /* Vocero */

% Cualquier persona puede haber estudiado en una o más instituciones y puede o no haber recibido premios.

equipo(Vocero,Experto,Apoyo,Presupuesto):-
  personasEstudiantes(Vocero,Experto,Apoyo),
  esVocero(Vocero),
  esExperto(Experto),
  esApoyo(Apoyo,Vocero,Experto),
  calculoPresupuestoExperto(PresupuestoExperto, Experto),
  calculoPresupuestoVocero(PresupuestoVocero, Vocero),
  calculoPresupuestoApoyo(PresupuestoApoyo, Apoyo),
  Presupuesto is 5000 + PresupuestoExperto + PresupuestoVocero + PresupuestoApoyo.

calculoPresupuestoExperto(2000, Experto):-
  recibioPremio(Experto).
calculoPresupuestoExperto(0,Experto):-
  not(recibioPremio(Experto)).

calculoPresupuestoVocero(PresupuestoVocero, Vocero):-
  findall(Nota,estudio(Vocero,_,Nota),Notas),
  sumlist(Notas,SumaNotas),
  PresupuestoVocero is 1000 * SumaNotas.

calculoPresupuestoApoyo(PresupuestoApoyo, Apoyo):-
  findall(Nota,estudio(Apoyo,_,Nota),Notas),
  sumlist(Notas,SumaNotas),
  length(Notas, CantNotas),
  Promedio is SumaNotas / CantNotas,
  presupuestoFinal(PresupuestoApoyo, Promedio).

presupuestoFinal(500,Promedio):-
  Promedio > 3.
presupuestoFinal(0,Promedio):-
  Promedio < 4.

personasEstudiantes(Vocero,Experto,Apoyo):-
  estudio(Vocero,_,_),
  estudio(Experto,_,_),
  estudio(Apoyo,_,_),
  Vocero \= Experto,
  Vocero \= Apoyo,
  Apoyo \= Experto.

esVocero(Vocero):-
  % estudio(Vocero,_,_),
  recibioPremio(Vocero).
esVocero(Vocero):-
  estudio(Vocero,Institucion,_),
  recibioPremio(Institucion).

esExperto(Experto):-
  % estudio(Experto,_,_),
  findall(Nota,estudio(Experto,_,Nota),Notas),
  length(Notas,CantNotas),
  CantNotas > 1,
  forall(member(Nota,Notas), Nota > 7).

/* estudioEnMasDeUnaInstitucion(Experto):-
  estudio(Experto,Institucion,_),
  estudio(Experto,OtraInstitucion,_),
  Institucion \= OtraInstitucion. */

esApoyo(Apoyo,_,Experto):-
  estudio(Apoyo,Institucion,_),
  estudio(Experto,Institucion,_).
esApoyo(Apoyo,Vocero,_):-
  estudio(Apoyo,Institucion,_),
  estudio(Vocero,Institucion,_).


  
  

  
