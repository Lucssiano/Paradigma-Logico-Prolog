% Cancion, Compositores, Reproducciones
cancion(bailanSinCesar, [pabloIlabaca, rodrigoSalinas], 10600177).
cancion(yoOpino, [alvaroDiaz, carlosEspinoza, rodrigoSalinas], 5209110).
cancion(equilibrioEspiritual, [danielCastro, alvaroDiaz, pabloIlabaca, pedroPeirano, rodrigoSalinas], 12052254).
cancion(tangananicaTanganana, [danielCastro, pabloIlabaca, pedroPeirano], 5516191).
cancion(dienteBlanco, [danielCastro, pabloIlabaca, pedroPeirano], 5872927).
cancion(lala, [pabloIlabaca, pedroPeirano], 5100530).
cancion(meCortaronMalElPelo, [danielCastro, alvaroDiaz, pabloIlabaca, rodrigoSalinas], 3428854).

% Mes, Puesto, Cancion
rankingTop3(febrero, 1, lala).
rankingTop3(febrero, 2, tangananicaTanganana).
rankingTop3(febrero, 3, meCortaronMalElPelo).
rankingTop3(marzo, 1, meCortaronMalElPelo).
rankingTop3(marzo, 2, tangananicaTanganana).
rankingTop3(marzo, 3, lala).
rankingTop3(abril, 1, tangananicaTanganana).
rankingTop3(abril, 2, dienteBlanco).
rankingTop3(abril, 3, equilibrioEspiritual).
rankingTop3(mayo, 1, meCortaronMalElPelo).
rankingTop3(mayo, 2, dienteBlanco).
rankingTop3(mayo, 3, equilibrioEspiritual).
rankingTop3(junio, 1, dienteBlanco).
rankingTop3(junio, 2, tangananicaTanganana).
rankingTop3(junio, 3, lala).

/* 1. Saber si una canción es un hit, lo cual ocurre si aparece en el ranking top 3 de
todos los meses. */
esUnHit(Cancion):-
  cancion(Cancion,_,_),
  forall(rankingTop3(Mes,_,_),rankingTop3(Mes,_,Cancion)).

/* 2. Saber si una canción no es reconocida por los críticos, lo cual ocurre si tiene
muchas reproducciones y nunca estuvo en el ranking. Una canción tiene muchas
reproducciones si tiene más de 7000000 reproducciones. */
noReconocidaPorCriticos(Cancion):-
  cancion(Cancion,_,Reproducciones),
  Reproducciones > 7000000,
  not(rankingTop3(_, _, Cancion)).

/* 3. Saber si dos compositores son colaboradores, lo cual ocurre si compusieron
alguna canción juntos. */
colaboradores(Compositor, OtroCompositor):-
  cancion(_,Compositores,_),
  member(Compositor,Compositores),
  member(OtroCompositor,Compositores).

/* 4. Modelar en la solución a los siguientes trabajadores: */
% a. Tulio, conductor con 5 años de experiencia.
trabajador(tulio,conductor(5)).

% b. Bodoque, periodista con 2 años de experiencia con un título de licenciatura, y también reportero con 5 años de experiencia y 300 notas realizadas.
trabajador(bodoque,periodista(2,licenciatura)).
trabajador(bodoque,reportero(5,300)).

% c. Mario Hugo, periodista con 10 años de experiencia con un posgrado.
trabajador(marioHugo,periodista(10,posgrado)).

% d. Juanin, que es un conductor que recién empieza así que no tiene años de experiencia.
trabajador(juanin,conductor(0)).
trabajador(marcelo,programador(20,[javascript,react])). % -- Punto 6

persona(tulio).
persona(bodoque).
persona(marioHugo).
persona(juanin).
persona(marcelo). % -- Punto 6

/* 5. Conocer el sueldo total de una persona, el cual está dado por la suma de los sueldos
de cada uno de sus trabajos. El sueldo de cada trabajo se calcula de la siguiente forma: */
sueldoTotal(Persona,SueldoTotal):-
  persona(Persona), % Puesto para que no se repita el sueldo de bodoque % trabajador(Persona,_), estaba antes
  findall(Sueldo,sueldo(Persona, Sueldo),Sueldos),
  sumlist(Sueldos,SueldoTotal).

% a. El sueldo de un conductor es de 10000 por cada año de experiencia
sueldo(Persona, Sueldo):-
  trabajador(Persona,conductor(AniosDeExperiencia)),
  Sueldo is 10000 * AniosDeExperiencia.
% b. El sueldo de un reportero también es 10000 por cada año de experiencia más 100 por cada nota que haya hecho en su carrera
sueldo(Persona, Sueldo):- 
  trabajador(Persona,reportero(AniosDeExperiencia, CantNotas)), /* Ver de juntarlo para que sea igual que la suma del conductor */
  Sueldo is (10000 * AniosDeExperiencia + 100 * CantNotas).
% c. Los periodistas, por cada año de experiencia reciben 5000, pero se les aplica un porcentaje de incremento del 20% cuando tienen una licenciatura o del 35% si tienen un posgrado.
sueldo(Persona, Sueldo):-
  trabajador(Persona,periodista(AniosDeExperiencia,licenciatura)),
  Incremento is ((5000 * AniosDeExperiencia) * (0.2)),
  Sueldo is Incremento + (5000 * AniosDeExperiencia).
sueldo(Persona, Sueldo):-
  trabajador(Persona,periodista(AniosDeExperiencia,posgrado)),
  Incremento is ((5000 * AniosDeExperiencia) * (0.35)),
  Sueldo is Incremento + (5000 * AniosDeExperiencia).

/* 6. Agregar un nuevo trabajador que tenga otro tipo de trabajo nuevo distinto a los
anteriores. Agregar una forma de calcular el sueldo para el nuevo trabajo agregado
¿Qué concepto de la materia se puede relacionar a esto? */
% Nombre, programador(AñosDeExperiencia,LenguajesConocidos)
sueldo(Persona, Sueldo):-
  trabajador(Persona,programador(AniosDeExperiencia,LenguajesConocidos)),
  length(LenguajesConocidos,CantLenguajesConocidos),
  member(react,LenguajesConocidos),
  Sueldo is 30000 * AniosDeExperiencia + 5000 * CantLenguajesConocidos + 500000.
sueldo(Persona, Sueldo):-
  trabajador(Persona,programador(AniosDeExperiencia,LenguajesConocidos)),
  length(LenguajesConocidos,CantLenguajesConocidos),
  not(member(react,LenguajesConocidos)),
  Sueldo is 30000 * AniosDeExperiencia + 5000 * CantLenguajesConocidos.



