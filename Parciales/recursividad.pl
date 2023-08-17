% factorial(0, 1).
% factorial(N, Result) :- /* factorial(3, Result) */ /* factorial(2,SubResult) */ /* factorial(1,SubResult) */ 
%     N > 0, /* 3 > 0 */ /* 2 > 0 */ /* 1 > 0 */ /* False */
%     N1 is N - 1, /* N1 is 2 */  /* N1 is 1 */ /* N1 is 0 */
%     factorial(N1, SubResult), /* factorial(2,SubResult) */ /* factorial(1,SubResult) */ /* factorial(0,1) */
%     Result is N * SubResult. % 3 * 2 * 1

% padre(tatara, bisa).
% padre(bisa, abu).
% padre(abu, padre).
% padre(padre, hijo).

% ancestro(Padre, Persona):- 
%   padre(Padre, Persona).
% ancestro(Ancestro, Persona):- 
%     padre(Padre, Persona), 
%     ancestro(Ancestro, Padre).  
 
% esAnterior(Anterior, Siguiente) :- 
%     precedeA(Anterior, Siguiente).
% esAnterior(Anterior, Siguiente) :-
%     precedeA(Anterior, Intermedio),
%     esAnterior(Intermedio, Siguiente).

