personaje(pumba).
personaje(timon).
personaje(simba).

%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
pesoHormiga(2).

%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

/* a) Qué cucaracha es jugosita: ó sea, hay otra con su mismo tamaño pero ella es más gordita. */
esCucarachaJugosita(cucaracha(Nombre,Tamanio,Peso)):-
  comio(_,cucaracha(Nombre,Tamanio,Peso)),
  comio(_, cucaracha(OtroNombre, Tamanio, OtroPeso)),
  Nombre \= OtroNombre,
  Peso > OtroPeso.
  
/* b) Si un personaje es hormigofílico... (Comió al menos dos hormigas). */
/* esHormigofilico(Personaje):-
  comio(Personaje,hormiga(Nombre)),
  comio(Personaje,hormiga(OtroNombre)),
  Nombre \= OtroNombre. */
esHormigofilico(Personaje):-
  comio(Personaje,hormiga(_)),
  findall(Nombre, comio(Personaje,hormiga(Nombre)), ListaHormigas),
  length(ListaHormigas, CantHormigas),
  CantHormigas >= 2.

/* c) Si un personaje es cucarachofóbico (no comió cucarachas) */
cucarachofobico(Personaje):-
  personaje(Personaje),
  not(comio(Personaje,cucaracha(_,_,_))).

/* d) Conocer al conjunto de los picarones. Un personaje es picarón si comió una cucaracha jugosita ó si se
come a Remeditos la vaquita. Además, pumba es picarón de por sí */

picarones(ConjuntoDePersonajes) :-
  findall(Personaje, picaron(Personaje), ConjuntoDePersonajes).

picaron(pumba).
picaron(Personaje):-
  personaje(Personaje),
  comio(Personaje,Cucaracha),
  esCucarachaJugosita(Cucaracha).
picaron(Personaje):-
  personaje(Personaje),
  comio(Personaje,vaquitaSanAntonio(remeditos,_)).

/* 2) */
hiena(shenzi).
hiena(banzai).

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

comio(shenzi,hormiga(conCaraDeSimba)).

peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

/* a) Se quiere saber cuánto engorda un personaje (sabiendo que engorda una cantidad igual a la suma de
los pesos de todos los bichos en su menú). Los bichos no engordan. */
cuantoEngorda(Personaje,Peso):- /* ?? no lo entiendo */


