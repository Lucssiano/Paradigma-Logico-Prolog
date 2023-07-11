%%% Parcial Paradigma Lógico - Pdep JM 2022 UTN.BA

%%% Apellido y nombre: <completar>
%%% Legajo: <completar>

% PUNTO 1

necesidad(respiracion, fisiologico).
necesidad(alimentacion, fisiologico).
necesidad(descanso, fisiologico).
necesidad(reproduccion, fisiologico).
necesidad(integridad, seguridad).
necesidad(empleo, seguridad).
necesidad(salud, seguridad).
necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad, social).
necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).
% un ejemplo cualquiera
necesidad(libertad, autorrealizacion).

nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social, seguridad).
nivelSuperior(seguridad, fisiologico).

% PUNTO 2

separacionEntre(NecesidadA,NecesidadB,Separacion):-
    necesidad(NecesidadA,NivelA),
    necesidad(NecesidadB,NivelB),
    separacionNiveles(NivelA,NivelB,Separacion).


separacionNiveles(Nivel,Nivel,0).
separacionNiveles(NivelA,NivelB,Separacion):-
    nivelSuperior(NivelB,NivelIntermedio),
    separacionNiveles(NivelA,NivelIntermedio,SepAnterior),
    Separacion is SepAnterior + 1.


% PUNTO 3
% atención a respetar los nombres elegidos en el punto 1
necesita(carla, alimentacion).
necesita(carla, descanso).
necesita(carla, empleo).
% no agrego empleo de juan porque por principio de universo cerrado quiero que de falso.
necesita(juan, afecto).
necesita(juan, exito).
necesita(camila, alimentacion).
necesita(camila, descanso).
necesita(roberto, amistad).
necesita(manuel, libertad).
necesita(charly, afecto).


% Punto 4
% Encontrar la necesidad de mayor jerarquía de una persona. 
% En el caso de Carla, es tener un empleo.


necesidadMayorJerarquia(Persona,Necesidad):-
    necesita(Persona,Necesidad),
    not((necesita(Persona,OtraNecesidad),mayorJerarquia(OtraNecesidad,Necesidad))).

mayorJerarquia(Necesidad1,Necesidad2):-
    separacionEntre(Necesidad2,Necesidad1,Separacion),
    Separacion > 0.

%% Variante sutil
necesidadMayorJerarquia1(Persona,Necesidad):-
    necesita(Persona,Necesidad),
    not(necesitaAlgoPrevioA(Persona,Necesidad)).

necesitaAlgoPrevioA(Persona,Necesidad):-
    necesita(Persona,OtraNecesidad),
    separacionEntre(OtraNecesidad,Necesidad,Separacion),
    Separacion > 0.

% Otra variante
necesidadMayorJerarquia2(Persona,Necesidad):-
    jerarquiaNecesidad(Persona,Necesidad,JerarquiaMax),
    forall(jerarquiaNecesidad(Persona,_,OtraJerarquia), JerarquiaMax >= OtraJerarquia).    

jerarquiaNecesidad(Persona,Necesidad,Jerarquia):-
    necesita(Persona,Necesidad),
    necesidad(Necesidad,Nivel),
    nivelBasico(NivelBasico),
    separacionNiveles(NivelBasico,Nivel,Jerarquia).

nivelBasico(Nivel):-
    nivelSuperior(_,Nivel),
    not(nivelSuperior(Nivel,_)).

% Punto 5
% Saber si una persona pudo satisfacer por completo algún nivel de la pirámide.
% Por ejemplo, Juan pudo satisfacer por completo el nivel fisiologico.

nivel(Nivel):- necesidad(_,Nivel).
% nivel(Nivel):-nivelSuperior(Nivel,_).
% nivel(Nivel):-nivelBaciso(Nivel)

persona(Persona):- necesita(Persona,_).
% persona(carla).

nivelSatisfecho(Persona,Nivel):-
    persona(Persona),
    nivel(Nivel),
    not(nivelConNecesidades(Persona,Nivel)).

nivelConNecesidades(Persona,Nivel):-
    necesita(Persona,Necesidad),
    necesidad(Necesidad,OtroNivel),
    separacionNiveles(OtroNivel,Nivel,_).


%Variante

nivelSatisfecho1(Persona,Nivel):-
    persona(Persona),
    nivel(Nivel),
    not(nivelConNecesidades(Persona,Nivel)).

nivelConNecesidades1(Persona,Nivel):-
    necesidad(Necesidad,Nivel),
    necesita(Persona,Necesidad).

nivelConNecesidades1(Persona,Nivel):-
    necesidad(Necesidad,Nivel),
    necesitaAlgoPrevioA(Persona,Necesidad).


% Punto 6
% Definir los predicados que permitan analizar si es cierta o no la teoría de Maslow:
% a) Para una persona en particular.
% b) Para todas las personas.
% c) Para la mayoría de las personas. 


% a) todas sus necesidades son del mismo nivel.
cumpleMaslow(Persona):-
    necesita(Persona,Necesidad),
    forall(necesita(Persona,OtraNecesidad),mismoNivel(Necesidad,OtraNecesidad)).

mismoNivel(Necesidad,OtraNecesidad):-separacionEntre(Necesidad,OtraNecesidad,0).

noCumpleMaslow(Persona):-
    persona(Persona),
    necesita(Persona,Necesidad1),
    necesita(Persona,Necesidad2),
    separacionEntre(Necesidad1,Necesidad2,Separacion),
    Separacion > 1.
 
cumpleMaslowTodos:-not(noCumpleMaslow(_)).
cumpleMaslowTodos1:-
    forall(persona(Persona),cumpleMaslow(Persona)).

% c) seCumpleParaMayoria :- (aridad 0) acá hay que hacer findall y length 2 veces

% Punto 7
% Creativo
% se considera correcta cualquier creación que utilice polimorficamente dos tipos de funtores diferentes