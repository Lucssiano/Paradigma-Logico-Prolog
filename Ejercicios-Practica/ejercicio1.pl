/* Ejercicio para el labo: */
/* Sabemos que en nuestro universo existen múltiples comidas y personas. 
A todos les gustan las comidas que puede hacer su abuela. Además a Juana le gustan las lentejas. 
A Lucas también le gusta la comida que él mismo prepara. También, a toda persona que se conoce les gusta comer en mcDonalds */

persona(juana).
persona(lucas).
persona(susana).
persona(maria).

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

leGustaComida(Persona,mcDonalds):-
        persona(Persona).
