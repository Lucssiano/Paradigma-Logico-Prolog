restaurante(panchoMayo, 2, barracas).
restaurante(finoli, 3, villaCrespo).
restaurante(superFinoli, 5, villaCrespo).

menu(panchoMayo, carta(1000, pancho)).
menu(panchoMayo, carta(200, hamburguesa)).
menu(finoli, carta(2000, hamburguesa)).
menu(finoli, pasos(15, 15000, [chateauMessi, francescoliSangiovese,
susanaBalboaMalbec], 6)).
menu(noTanFinoli, pasos(2, 3000, [guinoPin, juanaDama],3)).

vino(chateauMessi, francia, 5000).
vino(francescoliSangiovese, italia, 1000).
vino(susanaBalboaMalbec, argentina, 1200).
vino(christineLagardeCabernet, argentina, 5200).
vino(guinoPin, argentina, 500).
vino(juanaDama, argentina, 1000).

/* 1. Cuáles son los restaurantes de más de N estrellas por barrio */
restauranteMasDeNEstrellas(NumEstrellas, Barrio, Restaurante):-
  restaurante(Restaurante,Estrellas,Barrio),
  Estrellas > NumEstrellas.

/* 2. Cuáles son los restaurantes sin estrellas. */
restaurantesSinEstrellas(Restaurante):-
  menu(Restaurante, _),
  not(restaurante(Restaurante,_,_)).

/* 3. Si un restaurante está mal organizado, que es cuando tiene algún menú que tiene más pasos
que la cantidad de vinos disponibles o cuando tiene en su menú a la carta dos veces una
misma comida con diferente precio. */
restauranteMalOrganizado(Restaurante):-
  menu(Restaurante,pasos(CantPasos,_,ListaVinos,_)),
  length(ListaVinos, CantVinos),
  CantPasos > CantVinos.
restauranteMalOrganizado(Restaurante):-
  menu(Restaurante,carta(Precio,Comida)),
  menu(Restaurante,carta(OtroPrecio,Comida)),
  Precio \= OtroPrecio.

/* 4. Qué restaurante es copia barata de otro restaurante, lo que sucede cuando el primero
tiene todos los platos a la carta que ofrece el otro restaurante, pero a un precio menor.
Además, no puede tener más estrellas que el otro. */
esCopiaBarata(Restaurante, OtroRestaurante):-
  menu(Restaurante,carta(Precio,Comida)),
  menu(OtroRestaurante,carta(OtroPrecio,Comida)),
  forall(menu(OtroRestaurante,carta(OtroPrecio,Comida)),(menu(Restaurante,carta(Precio,Comida)), Precio < OtroPrecio)),
  restaurante(Restaurante,Estrellas,_),
  restaurante(OtroRestaurante,OtrasEstrellas,_),
  not(Estrellas > OtrasEstrellas).
  
/* 5. Cuál es el precio promedio de los menúes de cada restaurante, por persona.
○ En los platos (carta), se considera el precio indicado ya que se asume que es para una
persona.
○ En los menú por pasos, el precio es el indicado más la suma de los precios de todos
los vinos incluidos, pero dividido en la cantidad de comensales. Los vinos importados
pagan una tasa aduanera del 35% por sobre su precio publicado. */
/* precioPromedio(Restaurante,Promedio):-
  menu(Restaurante, _), 
  findall(PrecioCarta,menu(Restaurante, carta(PrecioCarta, _)),PreciosCarta),
  findall(PrecioPasos,obtenerPrecio(Restaurante,PrecioPasos),PreciosPasos),
  append(PreciosCarta, PreciosPasos, Precios),
  calcularPromedio(Precios, Promedio).

obtenerPrecio(Restaurante, PrecioPasos):-
  menu(Restaurante, pasos(_, Precio, ListaVinos, CantComensales)),
  findall(PrecioVino,(member(Vino, ListaVinos), verificarSiEsImportado(Vino,PrecioVino)),ListaPreciosVinos),
  sumlist(ListaPreciosVinos,SumaPrecioVinos),
  PrecioPasos is (Precio + (SumaPrecioVinos / CantComensales)).

verificarSiEsImportado(Vino,PrecioVino):-
  vino(Vino,argentina,Precio),
  PrecioVino is Precio.
verificarSiEsImportado(Vino,PrecioVino):-
  vino(Vino,Pais,Precio),
  Pais \= argentina,
  PrecioVino is (Precio * 1.35).
 */

precioPromedio(Restaurante, Promedio) :-
    menu(Restaurante, _),
    findall(Precio, obtenerPrecio(Restaurante, Precio), ListaDePrecios),
    calcularPromedio(ListaDePrecios, Promedio). 
    
obtenerPrecio(Restaurante, Precio):-
  menu(Restaurante, carta(Precio, _)).

obtenerPrecio(Restaurante, Precio) :-
  menu(Restaurante,pasos(_, PrecioIndicado, ListaDeVinos, CantidadDeComensales)),
  obtenerPrecioDeVinos(ListaDeVinos, PreciosDeVinos),
  Precio is ((PrecioIndicado + PreciosDeVinos) / CantidadDeComensales).

obtenerPrecioDeVinos(ListaDeVinos, PreciosDeVinos) :-
    findall(PrecioDeVino, preciosIndividuales(ListaDeVinos, PrecioDeVino), ListaDePreciosDeLosVinos),
    sumlist(ListaDePreciosDeLosVinos, PreciosDeVinos).

preciosIndividuales(ListaDeVinos, PrecioIndividual) :-
    member(Vino, ListaDeVinos),
    precioDeVino(Vino, PrecioIndividual).

precioDeVino(Vino, PrecioDeVino) :-
    vino(Vino, argentina, PrecioDeVino).
precioDeVino(Vino, PrecioDeVino) :-
    vino(Vino, Pais, PrecioAhora),
    Pais \= argentina,
    PrecioDeVino is (PrecioAhora * (1.35)).

calcularPromedio(Precios, Promedio):-
    sumlist(Precios,SumaPrecios),
    length(Precios,CantPlatos),
    Promedio is (SumaPrecios / CantPlatos).

/* Un poco de repeticion de codigo pero funca */

/* 6. Inventar un nuevo tipo de menú diferente a los anteriores, con su correspondiente forma de
calcular el precio. ¿Qué podría hacerse en relación a los restaurantes mal organizados o
copias baratas? Justificar. */
