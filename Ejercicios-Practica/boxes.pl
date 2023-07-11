/* Entrando a Boxes
En las carreras, desde rally a fórmula 1, los autos requieren mantenimiento y reparaciones, antes e incluso durante la carrera.
Contamos con la información de cada auto: su identificacion, la cantidad de combustible que tiene, la capacidad máxima del tanque y su nivel de seguridad. Tenemos información de los repuestos disponibles, de los que conocemos su descripción y su magnitud. */

% auto(identificacion,cantidadCombustible,capacidadMaxTanque,nivelSeguridad).
auto(mcQueen, 2, 10, 10).
auto(delorean, 1, 15, 20).
auto(troncomovil, 5, 7, 100).

inseguro(Auto):-
  auto(Auto,_,_,Seguridad),
  Seguridad < 100.

% repuestosDisponibles(descripcion, magnitud).
repuesto(tanquecombustible, 5).
repuesto(cubierta, 3).
repuesto(condensadorFlujo, 7).
repuesto(tornillo,17).
repuesto(turbo,10).

esencial(turbo).

% A su vez, para cada auto se lleva el registro de cuándo se le colocó un determinado componente. (se expresa en cantidad de días desde que se adquirió el auto)
colocacionComponente(mcQueen,tanqueCombustible, 17).
colocacionComponente(mcQueen, cubierta, 50).
colocacionComponente(delorean, condensadorFlujo, 365).

colocarRepuesto(Descripcion,Auto):-
  auto(Auto,_,_,_),
  repuesto(Descripcion,_),
  colocacionComponente(Auto,Descripcion,Dias),
  Dias > 100.
colocarRepuesto(Descripcion,Auto):-
  auto(Auto,_,_,_),
  repuesto(Descripcion,17),
  not(colocacionComponente(Auto,Descripcion,_)).
colocarRepuesto(Descripcion,Auto):-
  auto(Auto,CantidadCombustible,CapacidadMaxTanque,_),
  CantidadCombustible < (CapacidadMaxTanque / 2),
  inseguro(Auto),
  esencial(Descripcion).

dia(345).

/* Encontrar cada uno de los autos que tengan colocados:
. más de un componente.
. exactamente un componente.
. ningún componente 
*/
autosConMasDeUnComponente(Auto):-
  auto(Auto,_,_,_),
  colocacionComponente(Auto,Descripcion1,_),
  colocacionComponente(Auto,Descripcion2,_),
  Descripcion1 \= Descripcion2.

autosConUnComponente(Auto):-
  auto(Auto,Descripcion1,_,_),
  forall(colocacionComponente(Auto,Descripcion2,_),Descripcion1 = Descripcion2).
  /* ¿se podria hacer un findall y ver el length? */

autosSinComponente(Auto):-
  auto(Auto,_,_,_),
  not(colocacionComponente(Auto,_,_)).

/* 3. Averiguar cuales son los repuestos del taller que convendría colocar en todos los autos que se conocen. */
esConveniente(Descripcion):-
  repuesto(Descripcion,_),
  % auto(Auto,_,_,_), /* -- dudaa */
  forall(auto(Auto,_,_,_), colocarRepuesto(Descripcion,Auto)).