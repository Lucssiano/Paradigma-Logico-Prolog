% Hechos:

viveEnLaMansion(tiaAgatha).
viveEnLaMansion(elCarnicero).
viveEnLaMansion(charles).

noSeOdian(tiaAgatha, elCarnicero).
noSeOdian(elCarnicero, tiaAgatha).

% Reglas:

personasQueOdia(Persona, PersonaQueLaOdia) :-
    viveEnLaMansion(Persona),
    viveEnLaMansion(PersonaQueLaOdia),
    not(noSeOdian(Persona, PersonaQueLaOdia)),
    Persona \= PersonaQueLaOdia.

esRico(Persona) :-
    viveEnLaMansion(Persona),
    not(personasQueOdia(elCarnicero, Persona)).

esMasRico(Persona, OtraPersona) :-
    esRico(Persona),
    not(esRico(OtraPersona)).

alguienAsesino(Asesino, PersonaAsesinada) :-
    viveEnLaMansion(Asesino),
    personasQueOdia(Asesino, PersonaAsesinada),
    esMasRico(Asesino, PersonaAsesinada).

