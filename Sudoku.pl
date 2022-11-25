% O primeiro argumento representa o elemento que deve estar presente na lista, R retorna true caso seja encontrado
pertence(X,[X|_]):- 
    !.
pertence(X, [_|Y]) :- 
    pertence(X, Y).


% Encontra o indice de um elemento, partindo da matriz, recebe o elemento desejado, a matriz, e o índice da lista
% retornando o valor do índice do elemento dentro da lista específica.
indice(E, M, 1, L, I):-
    M = [H|_],
    indice(E, H, 0, L, I).
indice(E,[E|_], _, 0, 0):- !.
indice(E,[_|T], _, 0, I):- 
    indice(E, T, 0, 0, X),
    I is X + 1.
indice(E, M, _, L, I):-
    L1 is L - 1,
    M = [_|T],
    L1 =\= 0,
    indice(E, T, 0, L1, I). 
indice(E, M, _, L, I):-
    L1 is L - 1,
    M = [_|T],
    L1 =:= 0,
    T = [H|_],
    indice(E, H, 0, L1, I). 

append([], X, X).
append([X|L1], L2, [X|L3]):-
    append(L1,L2,L3).


% Encontra o elemento a partir do índice, #3 deve ser a var
% Obs: também é usada para matrizes, para escolher a lista desejada dentro da matriz
elem(0, [H|_], H):- !.
elem(I, [_|T], E):- 
    X is I - 1, 
    elem(X, T, E).

% Compara se na primeira "linha da matriz" (pensando no sudoku) existe o elemento E, considerando a lista L
pertenceL(E, I, L):-
    I > -1,
    I < 3,
    elem(0, L, X1),
    elem(1, L, X2),
    elem(2, L, X3),
    (E is X1;
    E is X2;
    E is X3),
    !.

% Compara se na segunda "linha da matriz" (pensando no sudoku) existe o elemento E, considerando a lista L
pertenceL(E, I, L):-
    I > 2,
    I < 6,
    elem(3, L, X1),
    elem(4, L, X2),
    elem(5, L, X3),
    (E is X1;
    E is X2;
    E is X3),
    !.

% Compara se na terceira "linha da matriz" (pensando no sudoku) existe o elemento E, considerando a lista L
pertenceL(E, I, L):-
    I > 5,
    I < 9,
    elem(6, L, X1),
    elem(7, L, X2),
    elem(8, L, X3),
    (E is X1;
    E is X2;
    E is X3),
    !.

% Compara se na terceira "coluna da matriz" (pensando no sudoku) existe o elemento E, considerando a lista L
pertenceC(E, I, L):-
	mod(I,3)=:= 0,
	elem(0, L, X1),
    elem(3, L, X2),
    elem(6, L, X3),
    (E is X1;
    E is X2;
    E is X3),
    !.

% Compara se na terceira "coluna da matriz" (pensando no sudoku) existe o elemento E, considerando a lista L
pertenceC(E, I, L):-
	mod(I,3)=:= 1,
	elem(1, L, X1),
    elem(4, L, X2),
    elem(7, L, X3),
    (E is X1;
    E is X2;
    E is X3),
    !.

% Compara se na terceira "coluna da matriz" (pensando no sudoku) existe o elemento E, considerando a lista L
pertenceC(E, I, L):-
	mod(I,3)=:= 2,
	elem(2, L, X1),
    elem(5, L, X2),
    elem(8, L, X3),
    (E is X1;
    E is X2;
    E is X3),
    !.

% Recebe uma Matriz M e retorna se baseando na lista de indíce L um elemento que possa entrar nela,
% entre 1 e 9, ignorando se ela condiz com as regras em relação as outras listas, esse verificação é feita depois
% E por padrão deve iniciar com 1
novoE(_, _, 10, _):- !, fail.
novoE(M, 0, E, X):-
    M = [H|_],
    not(pertence(E, H)),
    X is E.
novoE(M, 0, E, X):-
    E1 is E + 1,
    novoE(M, 0, E1, X).
novoE(M, L, E, X):-
    L1 is L - 1,
    M = [_|T],
    novoE(T, L1, E, X).


% Pega uma matriz M e muda um elemento da lista de indice L na posição Indice para o valor Num, variável X
% N por padrão deve começar com 0, Aux [], o terceiro elemento deve começar com 1 sempre
mudarElemento(M, 0, 1, Indice, Num, N, Aux, X):-
    M = [H|_],
    mudarElemento(H, 0, 0, Indice, Num, N, Aux, X).
mudarElemento(M, 0, _, Indice, Num, N, Aux, X):-
    Indice =\= N,
    M = [H|T],
    append(Aux, [H], X1),
    N1 is N + 1,
    mudarElemento(T, 0, 0, Indice, Num, N1, X1, X).
mudarElemento(M, 0, _, Indice, Num, N, Aux, X):-
    Indice =:= N,
    M = [_|T],
    append(Aux, [Num], X1),
    N1 is N + 1,
    mudarElemento(T, 0, 0, Indice, Num, N1, X1, X).
mudarElemento(_, _, _, _, _, 9, Aux, X):-
    X = Aux,
    !.
mudarElemento(M, L, _, Indice, Num, N, Aux, X):-
    L1 is L - 1,
    M = [_|T],
    L1 =\= 0,
    mudarElemento(T, L1, 0, Indice, Num, N, Aux, X). 
mudarElemento(M, L, _, Indice, Num, N, Aux, X):-
    L1 is L - 1,
    M = [_|T],
    L1 =:= 0,
    T = [H|_],
    mudarElemento(H, L1, 0, Indice, Num, N, Aux, X). 


% Pega uma Matriz M e muda o valor na posição Indice para o valor Num, variável X
mudarElementoMatriz(M, Indice, Num, N, Aux, X):-
    Indice =\= N,
    M = [H|T],
    append(Aux, [H], X1),
    N1 is N + 1,
    mudarElementoMatriz(T, Indice, Num, N1, X1, X).
mudarElementoMatriz(M, Indice, Num, N, Aux, X):-
    Indice =:= N,
    M = [_|T],
    append(Aux, [Num], X1),
    N1 is N + 1,
    mudarElementoMatriz(T, Indice, Num, N1, X1, X).
mudarElementoMatriz(_, _, _, 9, Aux, X):-
    X = Aux,
    !.

verificarLinhaMatriz(M, 0, Num , R, Indice):-
    R =\= 0,
    M = [H|_],
    not(pertenceL(Num, Indice, H)),
    !.
verificarLinhaMatriz(_, 0, _,  R, _):-
    R =:= 0,
    !.
verificarLinhaMatriz(M, N, Num, R, Indice):-
    N > 2,
    R1 is R - 1,
    N1 is N - 1,
    M = [_|T],
    verificarLinhaMatriz(T, N1, Num, R1, Indice).
verificarLinhaMatriz(M, N, Num, R, Indice):-
    N1 is N - 1,
    R =\= 0,
    R1 is R - 1,
    M = [H|T],
    not(pertenceL(Num, Indice, H)),
    verificarLinhaMatriz(T, N1, Num, R1, Indice).
verificarLinhaMatriz(M, N, Num, R, Indice):-
    N1 is N - 1,
    R =:= 0,
    R1 is R - 1,
    M = [_|T],
    verificarLinhaMatriz(T, N1, Num, R1, Indice).


verificarColunaMatriz(M, 0, 0, Num, R, Indice):-
    R =\= 0,
    M = [H|_],
    not(pertenceC(Num, Indice, H)),
    !.
verificarColunaMatriz(_, 0, 0, _, R, _):-
    R =:= 0,
    !.
verificarColunaMatriz(M, N, 0, Num, R, Indice):-
    R =\= 0,
    M = [H|T],
    not(pertenceC(Num, Indice, H)),
    N1 is N - 1,
    R1 is R - 1,
    verificarColunaMatriz(T, N1, 2, Num, R1, Indice).
verificarColunaMatriz(M, N, 0, Num, R, Indice):-
    R =:= 0,
    M = [_|T],
    N1 is N - 1,
    verificarColunaMatriz(T, N1, 2, Num, -1, Indice).
verificarColunaMatriz(M, N, Aux, Num, R, Indice):-
    M = [_|T],
    R1 is R - 1,
    Aux1 is Aux - 1,
    verificarColunaMatriz(T, N, Aux1, Num, R1, Indice).
    
% verificar se a Matriz M respeita as regras do sudoku, R => regiao, N => numero
verificarMatriz(M, R, N, Indice):-
    R < 3,
    X1 is mod(R,3),
    verificarLinhaMatriz(M, 2, N, R, Indice),
    verificarColunaMatriz(M, 2, X1, N, R, Indice),
    !.
verificarMatriz(_, R, _, _ ):-
    R < 3,
    !, fail.
verificarMatriz(M, R, N, Indice):-
    R < 6,
    X1 is mod(R,3),
    verificarLinhaMatriz(M, 5, N, R, Indice),
    verificarColunaMatriz(M, 2, X1, N, R, Indice),
    !.
verificarMatriz(_, R, _, _ ):-
    R < 6,
    !, fail.
verificarMatriz(M, R, N, Indice):-
    R < 9,
    X1 is mod(R,3),
    verificarLinhaMatriz(M, 8, N, R, Indice),
    verificarColunaMatriz(M, 2, X1, N, R, Indice),
    !.
verificarMatriz(_, R, _, _ ):-
    R < 9,
    !, fail.


sudoku(Ini, Fim, Regiao):-
    novoE(Ini, Regiao, 1, E),
    indice(0, Ini, 1, Regiao, Indice),
    mudarElemento(Ini, Regiao, 1, Indice, E, 0, [], L1),
    mudarElementoMatriz(Ini, Regiao, L1, 0, [], M1),
    verificarMatriz(M1, Regiao, E, Indice),
    sudoku(M1, Fim, Regiao).
sudoku(Ini, Fim, Regiao):-
    Regiao =:= 10,
    Fim = Ini,
    !.
sudoku(Ini, Fim, Regiao):-
    not(novoE(Ini, Regiao, 1, _)),
    R1 is Regiao + 1,
    sudoku(Ini, Fim, R1).

       
sudoku(Ini, Fim):-
    sudoku(Ini, Fim, 0).