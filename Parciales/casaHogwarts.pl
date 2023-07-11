/* Para determinar en qué casa queda una persona cuando ingresa a Hogwarts, el Sombrero Seleccionador tiene en
cuenta el carácter de la persona, lo que prefiere y en algunos casos su status de sangre. */

/* Tenemos que registrar en nuestra base de conocimientos qué características tienen los distintos magos que
ingresaron a Hogwarts, el status de sangre que tiene cada mago y en qué casa odiaría quedar. Actualmente
sabemos que:
● Harry es sangre mestiza, y se caracteriza por ser corajudo, amistoso, orgulloso e inteligente. Odiaría que
el sombrero lo mande a Slytherin.
● Draco es sangre pura, y se caracteriza por ser inteligente y orgulloso, pero no es corajudo ni amistoso.
Odiaría que el sombrero lo mande a Hufflepuff.
● Hermione es sangre impura, y se caracteriza por ser inteligente, orgullosa y responsable. No hay ninguna
casa a la que odiaría ir. */

% mago(NombreMago) -- quiero hacer un predicado por separado para no tener que usar otro predicado para verificar si existe el mago
mago(harry).
mago(draco).
mago(hermione).

% sangre(NombreMago,TipoSangre)
sangre(harry,mestiza). 
sangre(draco,pura).
sangre(hermione,impura).

% caracteristicas(Mago,Caracteristica)
caracteristicas(harry,coraje).
caracteristicas(harry,amistad).
caracteristicas(harry,orgullo).
caracteristicas(harry,inteligencia).

caracteristicas(draco,inteligencia).
caracteristicas(draco,orgullo).

caracteristicas(hermione,inteligencia).
caracteristicas(hermione,orgullo).
caracteristicas(hermione,responsabilidad).

% casaOdiada(Mago,CasaOdiada)
casaOdiada(harry,slytherin).
casaOdiada(draco,hufflepuff).

/* Además nos interesa saber cuáles son las características principales que el sombrero tiene en cuenta para elegir
la casa más apropiada:
● Para Gryffindor, lo más importante es tener coraje.
● Para Slytherin, lo más importante es el orgullo y la inteligencia.
● Para Ravenclaw, lo más importante es la inteligencia y la responsabilidad.
● Para Hufflepuff, lo más importante es ser amistoso.
 */
casa(gryffindor).
casa(slytherin).
casa(hufflepuff).
casa(ravenclaw).
  
/* 1. Saber si una casa permite entrar a un mago, lo cual se cumple para cualquier mago y cualquier casa
excepto en el caso de Slytherin, que no permite entrar a magos de sangre impura. */
permiteEntrarACasa(Casa,Mago):-
  casa(Casa),
  Casa \= slytherin,
  mago(Mago).
permiteEntrarACasa(slytherin,Mago):-
  sangre(Mago,Sangre),
  Sangre \= impura.

/* 2. Saber si un mago tiene el carácter apropiado para una casa, lo cual se cumple para cualquier mago si sus
características incluyen todo lo que se busca para los integrantes de esa casa, independientemente de si
la casa le permite la entrada. */
tieneCaracterApropiado(gryffindor, Mago):-
  caracteristicas(Mago,coraje).
tieneCaracterApropiado(slytherin, Mago):-
  caracteristicas(Mago,orgullo),
  caracteristicas(Mago,inteligencia).
tieneCaracterApropiado(ravenclaw, Mago):-
  caracteristicas(Mago,inteligencia),
  caracteristicas(Mago,responsabilidad).
tieneCaracterApropiado(hufflepuff, Mago):-
  caracteristicas(Mago,amistad).

/* 3. Determinar en qué casa podría quedar seleccionado un mago sabiendo que tiene que tener el carácter
adecuado para la casa, la casa permite su entrada y además el mago no odiaría que lo manden a esa
casa. Además Hermione puede quedar seleccionada en Gryffindor, porque al parecer encontró una forma
de hackear al sombrero. */
  

