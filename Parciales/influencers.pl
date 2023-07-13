/* 1. Modelar los siguientes usuarios de ejemplo: */
usuario(ana).
usuario(beto).
usuario(cami).
usuario(dani).
usuario(evelyn).

red(instagram).
red(youtube).
red(tiktok).
red(twitch).

canalDe(ana,youtube,3000000).
canalDe(ana,instagram,2700000).
canalDe(ana,tiktok,1000000).
canalDe(ana,twitch,2).

canalDe(beto,twitch,120000).
canalDe(beto,youtube,6000000).
canalDe(beto,instagram,1100000).

canalDe(cami,tiktok,2000).

canalDe(dani,youtube,10000000).

canalDe(evelyn,instagram,1).
/* ------------------------------------------- */

/* 2. Sobre los influencers:  */
%  a) influencer/1 se cumple para un usuario que tiene más de 10.000 seguidores en total entre todas sus redes.
influencer(Usuario):-
  usuario(Usuario),
  findall(Seguidores, canalDe(Usuario,_,Seguidores), ListaSeguidores),
  sumlist(ListaSeguidores,SumaSeguidores),
  SumaSeguidores > 10000.

% b) omnipresente/1 se cumple para un influencer si está en cada red que existe (se consideran como existentes aquellas redes en las que hay al menos un usuario).
omnipresente(Influencer):-
  influencer(Influencer),
  forall(red(Red), canalDe(Influencer,Red,_)).
  
% c) exclusivo/1 se cumple cuando un influencer está en una única red.
exclusivo(Influencer):-
  influencer(Influencer),
  not(estaEnDosRedes(Influencer)).

estaEnDosRedes(Influencer):-
  canalDe(Influencer,Red,_),
  canalDe(Influencer,OtraRed,_),
  Red \= OtraRed.

/* 3. En las distintas redes sociales pueden publicarse distintos tipos de contenidos. Por ahora existen los videos (de los cuales nos interesan quienes aparecen en el video y la duración), las fotos (de las cuales nos interesan quienes aparecen en la foto), y los streams (de los cuales nos interesa la temática). */
% video(Red,PersonaRealiza,[PersonasAparecen],Duracion). /* Duracion en minutos */
% foto(Red,PersonaRealiza,[PersonasAparecen]).
% stream(Red,PersonaRealiza,Tematica).

% a) Modelar los contenidos de forma tal que a futuro puedan existir otros tipos de contenido y agregarlos debe producir el menor impacto posible en el sistema.
publicacion(ana, tiktok, video([beto, evelyn], 1)).
publicacion(ana, tiktok, video([ana], 1)).
publicacion(ana, instagram, foto([ana])). 
publicacion(beto, instagram, foto([])).
publicacion(cami, youtube, video([cami], 5)).
publicacion(cami, twitch, stream(leagueOfLegends)).
publicacion(evelyn, instagram, foto([cami, evelyn])).

% b) Se sabe que las temáticas relacionadas con juegos son leagueOfLegends, minecraft y aoe. Agregar esta información a la base de conocimientos.
esJuego(leagueOfLegends).
esJuego(minecraft).
esJuego(aoe).

/* 4. adictiva/1 se cumple para una red cuando sólo tiene contenidos adictivos (Un contenido adictivo es un video de menos de 3 minutos, un stream sobre una temática relacionada con juegos, o una foto con menos de 4 participantes).*/
/* adictiva(Red):-
  red(Red),
  video(Red,_,_,DuracionVideo),
  DuracionVideo < 3.
adictiva(Red):-
  red(Red),
  stream(Red,_,Tematica),
  juegos(Tematica).
adictiva(Red):-
  red(Red),
  foto(Red,_,Participantes),
  length(Participantes, CantParticipantes),
  CantParticipantes < 4. */
adictiva(Red):-
  red(Red),
  forall(publicacion(_,Red,Contenido), esAdictivo(Contenido)).

esAdictivo(stream(Tema)):-
  esJuego(Tema).
esAdictivo(video(_,Duracion)):-
  Duracion < 3.
esAdictivo(foto(Quienes)):-
  length(Quienes, Cant), 
  Cant < 4.

/* colaboran/2 se cumple cuando un usuario aparece en las redes de otro (en alguno de sus contenidos). En un stream siempre aparece quien creó el contenido.
Esta relación debe ser simétrica. (O sea, si a colaboró con b, entonces también debe ser cierto que b colaboró con a)
Por ejemplo, beto colaboró con ana y ana colaboró con evelyn. */
colaboran(Alguien, Otro):- 
  publicoContenidoCon(Alguien, Otro).
colaboran(Alguien, Otro):- 
  publicoContenidoCon(Otro, Alguien).

publicoContenidoCon(Alguien, Otro) :-
  publicacion(Alguien, _, Contenido),
  apareceEn(Alguien, Contenido, Otro).

apareceEn(Publicador, Contenido, Quien):-
  figuranEn(Publicador, Contenido, Figuran),
  member(Quien, Figuran).

figuranEn(_, foto(Quienes), Quienes).
figuranEn(_, video(Quienes,_), Quienes).
figuranEn(Autor, stream(_), [Autor]).

/* 6. caminoALaFama/1 se cumple para un usuario no influencer cuando un influencer publicó contenido en el que aparece el usuario, o bien el influencer publicó contenido donde aparece otro usuario que a su vez publicó contenido donde aparece el usuario. Debe valer para cualquier nivel de indirección.
Cami está camino a la fama porque evelyn publicó una foto suya (y a su vez ana, que es influencer, publicó un video donde aparece evelyn).
Beto no está camino a la fama aunque ana haya publicado un video con él, ¡porque ya es famoso, es influencer! */
% caminoALaFama(Usuario):-
%   usuario(Usuario),
%   not(influencer(Usuario)),
%   influencer(OtroUsuario),
%   publicoContenidoCon(OtroUsuario, Usuario).
caminoALaFama(Usuario):-
  publicoContenidoCon(Famoso, Usuario),
  Famoso \= Usuario,
  not(influencer(Usuario)),
  tieneFama(Famoso).

tieneFama(Usuario):-
  influencer(Usuario).
tieneFama(Usuario):-
  caminoALaFama(Usuario).  /* No entiendo esto y pq da cami*/

