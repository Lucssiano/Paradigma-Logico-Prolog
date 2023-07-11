%leGustan(martin,[despedidaRiquelme,futbol]).
%aQuienesLesGusta(despedidaRiquelme,[martin,franco]).
%aQuienesLesGusta(perros,[luciano,elias,agustin]).
leGusta(martin,despedidaRiquelme).
leGusta(martin,gatos).
leGusta(franco,despedidaRiquelme).
leGusta(franco,futbol).
leGusta(luciano,perros).
leGusta(elias,perros).
leGusta(agustin,perros).

animal(perros).
animal(gatos).

leGustanLosAnimales(Alguien):-
    leGusta(Alguien,Gusto),animal(Gusto).

cuantasCosasLeGustan(Alguien,C):-
    esUnaPersona(Alguien),
    findall(X, leGusta(Alguien ,X), L),
    length(L,C).

aCuantosLesGusta(Gusto,C):-
    leGusta(_,Gusto),
        findall(X, leGusta(X ,Gusto), L),
        length(L,C).

esUnaPersona(martin).
esUnaPersona(franco).
esUnaPersona(elias).
esUnaPersona(agustin).
esUnaPersona(luciano).
esUnaPersona(tito).

longitud([] ,0).
longitud([_|XS],Cant):-
    longitud(XS,CantCola),
    Cant is CantCola + 1.

jefe(juan,ana).
jefe(juan,tito).
jefe(tito,cacho).
jefe(cacho,susana).
jefe(pedro,ana).
jefe(pedro,tito).



leDaOrdenes(A,B):-jefe(A,B).
leDaOrdenes(A,B):-jefe(X,B),leDaOrdenes(A,X).
