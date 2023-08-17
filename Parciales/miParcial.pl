%apareceEn(Personaje, Episodio, Lado de la luz).
apareceEn(luke, elImperioContrataca, luminoso).
apareceEn(luke, unaNuevaEsperanza, luminoso).
apareceEn(vader, unaNuevaEsperanza, oscuro).
apareceEn(vader, laVenganzaDeLosSith, luminoso).
apareceEn(vader, laAmenazaFantasma, luminoso).
apareceEn(c3po, laAmenazaFantasma, luminoso).
apareceEn(c3po, unaNuevaEsperanza, luminoso).
apareceEn(c3po, elImperioContrataca, luminoso).
apareceEn(chewbacca, elImperioContrataca, luminoso).
apareceEn(yoda, elAtaqueDeLosClones, luminoso).
apareceEn(yoda, laAmenazaFantasma, luminoso).

%Maestro(Personaje)
maestro(luke).
maestro(leia).
maestro(vader).
maestro(yoda).
maestro(rey).
maestro(duku).

% caracterizacion(Personaje,Aspecto).
% Aspecto:
%   ser(Especie,Tamaño)
%   humano
%   robot(Forma)
caracterizacion(chewbacca,ser(wookiee,10)).
caracterizacion(luke,humano).
caracterizacion(vader,humano).
caracterizacion(yoda,ser(desconocido,5)).
caracterizacion(jabba,ser(hutt,20)).
caracterizacion(c3po,robot(humanoide)).
caracterizacion(bb8,robot(esfera)).
caracterizacion(r2d2,robot(secarropas)).

% elementosPresentes(Episodio, Dispositivos)
elementosPresentes(laAmenazaFantasma, [sableLaser]).
elementosPresentes(elAtaqueDeLosClones, [sableLaser, clon]).
elementosPresentes(laVenganzaDeLosSith, [sableLaser, mascara, estrellaMuerte]).
elementosPresentes(unaNuevaEsperanza, [estrellaMuerte,sableLaser, halconMilenario]).
elementosPresentes(elImperioContrataca, [mapaEstelar,estrellaMuerte] ).

% El orden de los episodios se representa de la siguiente manera:
% precede(EpisodioAnterior,EpisodioSiguiente)
precedeA(laAmenazaFantasma,elAtaqueDeLosClones).
precedeA(elAtaqueDeLosClones,laVenganzaDeLosSith).
precedeA(laVenganzaDeLosSith,unaNuevaEsperanza).
precedeA(unaNuevaEsperanza,elImperioContrataca).

nuevoEpisodio(Heroe,Villano,Extra,Dispositivo):-
  personajesDistintos(Heroe,Villano,Extra),
  esJedi(Heroe),
  esVillano(Villano),
  esExtra(Extra,Heroe,Villano),
  esReconociblePorElPublico(Dispositivo).

personajesDistintos(Heroe,Villano,Extra):-
  apareceEn(Heroe, _, _),
  apareceEn(Villano, _, _),
  apareceEn(Extra, _, _),
  Heroe \= Villano,
  Heroe \= Extra,
  Villano \= Extra.

esJedi(Heroe):-
  maestro(Heroe),
  not(apareceEn(Heroe, _, oscuro)).

esVillano(Villano):-
  estuvoEnMasDeUnEpisodio(Villano),
  mantieneRasgoDeAmbiguedad(Villano).

estuvoEnMasDeUnEpisodio(Villano):-
  apareceEn(Villano, Episodio, _),
  apareceEn(Villano, OtroEpisodio, _),
  Episodio \= OtroEpisodio.

mantieneRasgoDeAmbiguedad(Villano):-
  apareceEn(Villano, Episodio, luminoso),
  apareceEn(Villano, Episodio, oscuro).
mantieneRasgoDeAmbiguedad(Villano):-
  apareceEn(Villano, EpisodioAnterior, luminoso),
  apareceEn(Villano, EpisodioPosterior, oscuro),
  esAnterior(EpisodioAnterior,EpisodioPosterior).
  
esAnterior(Anterior, Siguiente) :- 
    precedeA(Anterior, Siguiente).
esAnterior(Anterior, Siguiente) :-
    precedeA(Anterior, Intermedio),
    esAnterior(Intermedio, Siguiente).

esExtra(Extra,Heroe,Villano):-
  tieneAspectoExotico(Extra),
  tieneVinculoEstrecho(Extra,Heroe,Villano).

tieneAspectoExotico(Extra):-
  caracterizacion(Extra,Aspecto),
  exotico(Aspecto).

exotico(robot(Forma)):- Forma \= esfera.
exotico(ser(_,Tamanio)):- Tamanio > 15.
exotico(ser(desconocido,_)).

tieneVinculoEstrecho(Extra,Heroe,Villano):-
  forall(apareceEn(Extra, Episodio, _), apareceAlguno(Heroe,Villano,Episodio)).

apareceAlguno(Heroe,_,Episodio):-
  apareceEn(Heroe, Episodio, _).
apareceAlguno(_,Villano,Episodio):-
  apareceEn(Villano, Episodio, _).

esReconociblePorElPublico(Dispositivo):-
  apareceDispositivo(_,Dispositivo),
  findall(Episodio,apareceDispositivo(Episodio,Dispositivo),Episodios),
  length(Episodios, CantEpisodios),
  CantEpisodios >= 3.

apareceDispositivo(Episodio,Dispositivo):-
  elementosPresentes(Episodio,Dispositivos),
  member(Dispositivo,Dispositivos).

% 1
% nuevoEpisodio(luke, vader, c3po, estrellaMuerte).
% true

% 2
% Las conformaciones posibles con la base de datos inicial son 
% nuevoEpisodio(luke, vader, c3po, Dispositivo).
% Dispositivo = sableLaser) ;
% Dispositivo = estrellaMuerte ;

/* 3) Agregar algunos personajes nuevos, con una forma diferente de describir su aspecto y que tengan chances de ser incluido como extras. */
caracterizacion(bobaFett, clon(jangoFett)).
caracterizacion(darthSidious, sith(demacrado)).
caracterizacion(messi, nacionalidad(argentina)).
caracterizacion(harry, mago(100)).
caracterizacion(ron, mago(120)).
caracterizacion(hanSolo , equipamiento(halconMilenario , blaster)).
caracterizacion(pjRandom,omnipotente(1000)).
caracterizacion(jarjar, bizarro(gracioso)).
caracterizacion(tutu, bizarro(aburrido)).
caracterizacion(dinDjarin,cazarrecompenzas(armas)).
caracterizacion(bumbalu,alienigena(marte,100)). 
caracterizacion(kukuta,alienigena(saturno,20)).
caracterizacion(tumbalu,alienigena(tierra,60)).

exotico(clon(jangoFett)).
exotico(sith(_)).
exotico(nacionalidad(Pais)):-campeonDelMundo(Pais).
exotico(mago(Facha)):-
    caracterizacion(_, mago(OtraFacha)),
    Facha > OtraFacha.
exotico(equipamiento(_ , blaster)).
exotico(bicho(Anios)):- Anios > 3.
exotico(omnipotente(Edad)):- Edad >= 1000.
exotico(bizarro(gracioso)).
exotico(cazarrecompenzas(armas)).
exotico(alienigena(Planeta,Rareza)):-
    Planeta \= tierra,
    Rareza > 50.

campeonDelMundo(argentina).

% aspectoExotico(P).
% P = yoda ;
% P = jabba ;
% P = c3po ;
% P = r2d2 ;
% P = bobaFett ;
% P = darthSidious ;
% P = messi ;
% P = ron ;
% P = hanSolo ;
% P = pjRandom ;
% P = jarjar ;
% P = dinDjarin ;
% P = bumbalu ;
% false.


