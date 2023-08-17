/* persona(juan).
persona(ana).
persona(marta).
persona(carlos).
persona(cacho).
persona(tita). */

trabaja(juan, programacion, acme).
trabaja(ana, testing, acme).
trabaja(ana, programacion, acme).
% trabaja(marian, testing, acme). /* Agregado para pto3 */
% trabaja(lucho, testing, acme). /* Agregado para pto3 */
trabaja(marta, ceo, acme). 
trabaja(carlos, programacion, narnia). 
trabaja(carlos, docente, escuela). 

% estudia(marian,sistemas,5,utn). /* Agregado para pto3 */
% estudia(lucho,sistemas,5,utn). /* Agregado para pto3 */
estudia(juan,sistemas,5,utn).
estudia(tita,sistemas,3,utn). 
estudia(ana,computacion,4, uba).
estudia(ana,computacion,3, utn).
estudia(carlos, medicina,7,umm). 
estudia(cacho, medicina,5,uuu). 

habilita(sistemas,programacion).
habilita(sistemas, testing).
habilita(computacion, testing).
habilita(medicina, urgenciasMedicas).
habilita(medicina, cirugia).

/* 1) Insercion laboral */
% a) Las personas que trabajan en algo para lo que estudiaron (x ej Juan)
trabajaEnAlgoParaLoQueEstudio(Persona):-
  estudia(Persona,Estudio,_,_),
  trabaja(Persona,Trabajo,_),
  habilita(Estudio,Trabajo).  

% b) Las personas que trabajan en algo para lo que no estudiaron (x ej Ana)
trabajaEnAlgoParaLoQueNoEstudio(Persona):-
  trabaja(Persona,Trabajo,_),
  habilita(Estudio,Trabajo),
  not(estudia(Persona,Estudio,_,_)).
trabajaEnAlgoParaLoQueNoEstudio(Persona):- /* Para cubrir el caso de Marta */
  trabaja(Persona,_,_),
  not(estudia(Persona,_,_,_)).

% c) Las personas que estudiaron, pero que no trabajan en nada de lo que estudiaron. (x ej Carlos)
estudiaPeroNoTrabajaEnLoQueEstudio(Persona):-
  estudia(Persona,Estudio,_,_),
  forall(habilita(Estudio,Trabajo), not(trabaja(Persona,Trabajo,_))).
 
/* 2) Estudios */
% a) Las universidades de las que todos sus estudiantes consiguen trabajo (uba sí, utn no)
universidadBuenaSalidaLaboral(Universidad):-
  estudia(_,_,_,Universidad),
  forall(estudia(Persona,_,_,Universidad),trabaja(Persona,_,_)).

% b) Las carreras de las cuales ninguno de sus estudiantes consigue trabajo en algo vinculado. (x ej medicina)
carreraMalaSalidaLaboral(Carrera):-
  estudia(_,Carrera,_,_),
  forall(estudia(Persona,Carrera,_,_),estudiaPeroNoTrabajaEnLoQueEstudio(Persona)).
  % estudia(_,Carrera,_,_),
  % forall(estudia(,Carrera,_,_),(habilita(Carrera,Trabajo),not(trabaja(_,Trabajo,_)))).

/* 3) Vinculo estrecho  */
/* a) Entre qué lugares laborales y universidades hay mucha vinculación (al
menos 5 personas que estudiaron en dicha universidad trabajan en esa
empresa) (ninguno, para que haya vinculacion entre utn y acme faltarian dos
trabajos mas) */
vinculoEstrecho(LugarLaboral,Universidad):-
  estudia(_,_,_,Universidad),     
  trabaja(_,_,LugarLaboral),
  findall(Persona,(estudia(Persona,_,_,Universidad),trabaja(Persona,_,LugarLaboral)),ListaVinculados),
  length(ListaVinculados, CantVinculados),
  CantVinculados >= 5.

/* 4) Esfuerzo */
/* a) La cantidad total de años que estudió cada persona que trabaja en un lugar
(0 si no estudió) (x ej para acme, juan 5, ana 7, marta 0)  */
aniosDeEstudio(Lugar, Persona, Anios):-
  trabaja(Persona,_,Lugar),
  findall(Anios,estudia(Persona,_,Anios,_),ListaAnios),
  sumlist(ListaAnios, Anios).
% aniosDeEstudio(Lugar, Persona, Anios):-
%   trabaja(Persona,_,Lugar),
%   not(estudia(Persona,_,_,_)),
%   Anios is 0.
  