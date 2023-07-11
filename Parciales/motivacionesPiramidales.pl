/* 1) Agregar hechos para completar la información de las necesidades y niveles con algunos de los
ejemplos mencionados e inventando nuevas necesidades e incluso niveles. Se asume que los niveles
son distintos y están ordenados jerárquicamente entre sí, que no hay niveles sin necesidades y que
una misma necesidad no puede estar en dos niveles a la vez.*/
necesidad(respiracion, fisiologico).
necesidad(alimentacion, fisiologico).
necesidad(descanso, fisiologico).
necesidad(reproduccion, fisiologico).

necesidad(intFisica, seguridad).
necesidad(empleo, seguridad).
necesidad(salud, seguridad).

necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad, social).

necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).

necesidad(creatividad, autorrealizacion).
necesidad(talento, autorrealizacion).
necesidad(libertad, autorrealizacion).

nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social). 
nivelSuperior(social, seguridad).
nivelSuperior(seguridad, fisiologico).

/* 2. Permitir averiguar la separación de niveles que hay entre dos necesidades, es decir la cantidad de
niveles que hay entre una y otra.
Por ejemplo, con los ejemplos del texto de arriba, la separación entre empleo y salud es 0, y la
separación entre respiración y confianza es 3 */ /* ¿No puedo hacer confianza - respiracion? */
separacionNiveles(NecesidadA,NecesidadB,Separacion):-
  necesidad(NecesidadA, NivelA),
  necesidad(NecesidadB, NivelB),
  separacionEntre(NivelA,NivelB,Separacion).

separacionEntre(Nivel,Nivel,0).
separacionEntre(NivelA,NivelB,Separacion):- /* Noentiendo como funciona */
  nivelSuperior(NivelB, NivelIntermedio),
  separacionEntre(NivelA,NivelIntermedio,SeparacionAnterior),
  Separacion is SeparacionAnterior + 1.

/* Modelar las necesidades (sin satisfacer) de cada persona.
Recuerden leer los puntos siguientes para saber cómo se va a usar y cómo modelar esta información.
Por ejemplo:
● Carla necesita alimentarse, descansar y tener un empleo.
● Juan no necesita empleo pero busca alguien que le brinde afecto. Se anotó en la facu porque
desea ser exitoso.
● Roberto quiere tener un millón de amigos.
● Manuel necesita una bandera para la liberación, no quiere más que España lo domine ¡no
señor!.
● Charly necesita alguien que lo emparche un poco y que limpie su cabeza.
 */
persona(carla).
persona(juan).
persona(roberto).
persona(manuel).
persona(charly).

necesidadesSinSatisfacer(carla,[alimentacion,descansar,empleo]).
necesidadesSinSatisfacer(juan,[exito,afecto]).
necesidadesSinSatisfacer(roberto,[amistad]).
necesidadesSinSatisfacer(manuel,[libertad]).
necesidadesSinSatisfacer(charly,[afecto]).

/* 4- Encontrar la necesidad de mayor jerarquía de una persona. */
% necesidadDeMayorJerarquia(Persona, NecesidadDeJerarquia):-
%   persona(Persona),
%   necesidadesSinSatisfacer(Persona,[Necesidad|Resto]),
%   not((necesidadesSinSatisfacer(Persona,))

% mayorJerarquia(Necesidad1,Necesidad2):-
%   separacionEntre(Necesidad2,Necesidad1,Separacion),
%   Separacion > 0.