% =========================================================
% ARTI 401 - Lab 10: Graphs
% Task 1 - Path between cities (directed graph)
% Run with:  ?- travel('Dammam', 'Madinah', P).
% Press ;  after each answer to see the next path.
% =========================================================

% ---------------------------------------------------------
% Facts: edge(From, To) - one fact per arrow in the figure
% ---------------------------------------------------------
edge('Makkah',  'Madinah').
edge('Makkah',  'Riyadh').
edge('Madinah', 'Makkah').
edge('Madinah', 'Taif').
edge('Madinah', 'Tabuk').
edge('Taif',    'Tabuk').
edge('Taif',    'Dammam').
edge('Tabuk',   'Taif').
edge('Dammam',  'Qatif').
edge('Dammam',  'Riyadh').
edge('Riyadh',  'Dammam').
edge('Qatif',   'Madinah').
edge('Qatif',   'Dammam').

% ---------------------------------------------------------
% Rules
% ---------------------------------------------------------

% travel(Start, Finish, Path_List)
travel(From, To, Path) :-
    path(From, To, [From], P),
    reverse(P, Path).

% path(From, To, Visited_List, Path_List)
% The visited list stops Prolog from going round in circles.
path(X, X, P, P).
path(X, Y, V, P) :-
    edge(X, Z),
    \+ member(Z, V),
    path(Z, Y, [Z|V], P).

% Example queries:
% ?- travel('Dammam', 'Madinah', P).
%    P = ['Dammam', 'Qatif', 'Madinah'] ;  false.
% ?- travel('Riyadh', 'Makkah', P).
%    P = ['Riyadh', 'Dammam', 'Qatif', 'Madinah', 'Makkah'] ;  false.
% ?- travel('Makkah', 'Riyadh', P).
%    3 paths:
%    ['Makkah','Madinah','Taif','Dammam','Riyadh']
%    ['Makkah','Madinah','Tabuk','Taif','Dammam','Riyadh']
%    ['Makkah','Riyadh']
% ?- travel('Makkah', 'Madinah', P).
%    ['Makkah','Madinah']
%    ['Makkah','Riyadh','Dammam','Qatif','Madinah']
