% Ejercicio 1
% cual es el largo de los lados de un triangulo rectangulo, de manera que sean consecutivos (enteros)
trianguloLadosConsecutivos(Lado1,Lado2,Lado3):-
  between(1, 100, Lado1),
  Lado2 is Lado1 - 1,
  Lado3 is Lado2 - 1.
  
trianguloRectanguloValido(Hipotenusa, Cateto1, Cateto2):-
    CuadradoHipotenusa is Hipotenusa * Hipotenusa,
    CuadradoHipotenusa is Cateto1 * Cateto1 + Cateto2 * Cateto2.

ejercicio1(Hipotenusa, Cateto1, Cateto2):-
  trianguloLadosConsecutivos(Hipotenusa, Cateto1, Cateto2),
  trianguloRectanguloValido(Hipotenusa, Cateto1, Cateto2).

% Ejercicio 2
% Encontrar el mayor número que se puede armar con dos cifras diferentes y que no sea par.
numero2CifrasDiferentes(Numero):-
  digito(Decena),
  Decena \= 0,
  digito(Unidad),
  Decena \= Unidad,
  not(esPar(Unidad)),
  Numero is Decena * 10 + Unidad.

digito(N):- between(0,9,N).

esPar(0).
esPar(N):- N2 is N - 2, N2 >= 0, esPar(N2).

esElMayorNumero2CifrasDiferentes(Numero):-
  numero2CifrasDiferentes(Numero),
  numero2CifrasDiferentes(OtroNumero),
  OtroNumero > Numero. /* Duda */

% Ejercicio 3
% Parejas compatibles (diferencia edad, gustos, nacionalidad compatible, no pase algo)
persona(luciano, 40).
persona(lucas, 40).
persona(susana, 46).
persona(maria, 25).
persona(juana, 42).

abuelaDe(lucas,susana).
abuelaDe(juana,maria).

comida(lentejas).
comida(mcDonalds).
comida(milanga).
comida(guiso).
comida(papas).
comida(hamburguesa).

puedeCocinar(susana,lentejas).
puedeCocinar(susana,milanga).
puedeCocinar(maria,guiso).
puedeCocinar(lucas,papas).
puedeCocinar(lucas,hamburguesa).

leGustaComida(Persona,Comida):-
        abuelaDe(Persona,Abuela),
        puedeCocinar(Abuela,Comida).
        
leGustaComida(juana,lentejas).

leGustaComida(lucas,Comida):-
        puedeCocinar(lucas,Comida).

% leGustaComida(Persona,mcDonalds):-
%         persona(Persona).

parejaPosible(Persona1,Persona2):-
  persona(Persona1, _),
  persona(Persona2, _),
  Persona1 \= Persona2.

parejaCompatible(Persona1,Persona2):-
  parejaPosible(Persona1, _, Persona2, _),
  not(esAbuela(_,Persona2)),
  diferenciaEdadHasta(Persona1, _, Persona2, 5),
  gustoEnComun(Persona1, Persona2).

diferenciaEdadHasta(Persona1, Persona2, Tope):-
  persona(Persona1, Edad1),
  persona(Persona2, Edad2),
  abs(Edad1 - Edad2) < Tope.

gustoEnComun(Persona1, Persona2):-
  leGustaComida(Persona1, Comida),
  leGustaComida(Persona2, Comida).

seQuedaSolo(Persona):-
  persona(Persona,_),
  not(parejaCompatible(Persona,_)).

% Ejercicio 4 , el lugar que vende mas caro una comida
esDe(mcDonalds,hamburguesa,2000).
esDe(mcDonalds,papasFritas,1000).
esDe(bodegonDonTito,papasFritas,700).
esDe(buffet,papasFritas,900).
esDe(bodegonDonTito,guiso,1500).

lugarMasBaratoPara(Comida,Lugar):-
  esDe(Lugar,Comida,Precio),
  not(hayLugarQueCocinaLaComidaAUnPrecioMenorQue(Comida, Precio)).

hayLugarQueCocinaLaComidaAUnPrecioMenorQue(Comida, Precio):-
  esDe(_,Comida, OtroPrecio),
  OtroPrecio < Precio.