sex(anatoly,m).
sex(nikolay,m).
sex(galina,f).
sex(vaktntine,f).
sex(marina,f).
sex(anya,f).
sex(alexei,m).
sex(vyacheslav,m).
sex(michael,m).
sex(alena,f).
sex(nikita,m).
sex(masha,f).
sex(ivan,m).

parent(ivan,anatoly).
parent(anatoly,marina).
parent(anatoly,anya).
parent(vaktntine,marina).
parent(vaktntine,anya).
parent(nikolay,vyacheslav).
parent(nikolay,michael).
parent(galina,vyacheslav).
parent(galina,michael).
parent(marina,alena).
parent(vyacheslav,alena).
parent(anya,nikita).
parent(anya,masha).
parent(alexei,nikita).
parent(alexei,masha).

brotherorsister(X,Y):- parent(Z,X), parent(Z,Y), X\=Y,!.

father(X,Y):- parent(X,Y),sex(X,m).
mother(X,Y):- parent(X,Y),sex(X,f).
brother(X,Y):- brotherorsister(X,Y), sex(X,m).
sister(X,Y):- brotherorsister(X,Y), sex(X,f).
cousinf(X,Y):- parent(X1,X), parent(Y1,Y), brotherorsister(X1,Y1), sex(X,f).
cousinm(X,Y):- parent(X1,X), parent(Y1,Y), brotherorsister(X1,Y1), sex(X,m).
grandfather(X,Y):- parent(Z,Y),parent(X,Z), sex(X,m).
grandmother(X,Y):- parent(Z,Y),parent(X,Z), sex(X,f).

relative(X,Y,Z):- father(Y,Z), X = 'father - child'.
relative(X,Y,Z):- mother(Y,Z), X = 'mother - child'.
relative(X,Y,Z):- brother(Y,Z), X = 'brother'.
relative(X,Y,Z):- sister(Y,Z), X = 'sister'.
relative(X,Y,Z):- cousinm(Y,Z), X = 'cousinm'.
relative(X,Y,Z):- cousinf(Y,Z), X = 'cousinf'.
relative(X,Y,Z):- grandfather(Y,Z), X = 'grandfather'.
relative(X,Y,Z):- grandmother(Y,Z), X = 'grandmother'.

mainrelative([X],Y,Z,[Y,Z]):- relative(X,Y,Z),!.
mainrelative([X|L],Y,Z,[Y|P]):- relative(X,Y,Z1), mainrelative(L,Z1,Z,P).

formove(X,Y):- father(X,Y).
formove(X,Y):- mother(X,Y).
formove(X,Y):- brother(X,Y).
formove(X,Y):- sister(X,Y).
formove(X,Y):- cousinm(X,Y).
formove(X,Y):- cousinf(X,Y).
formove(X,Y):- grandfather(X,Y).
formove(X,Y):- grandmother(X,Y).
move(X,Y):- formove(X,Y).
move(X,Y):- formove(Y,X).

 prolong([X|T],[Y,X|T]):- move(X,Y), not(member(Y,[X|T])).
 int(1).
 int(M):- int(N), M is N+1.
 search_id(Start,Finish,Path,DepthLimit):- depth_id([Start],Finish,Path,DepthLimit).
 depth_id([Finish|T],Finish,[Finish|T],0).
 depth_id(Path,Finish,R,N):- N > 0, prolong(Path,NewPath), N1 is N - 1,
 depth_id(NewPath,Finish,R,N1).

 search_id1(Start,Finish,Path):- int(Level), search_id(Start,Finish,Path,Level).

 namerel([],[]).
 namerel([X,Y|T],[Z|R]):- relative(Z,Y,X),namerel([Y|T],R).
 namerel([X,Y|T],[Z|R]):- relative(Z,X,Y),namerel([Y|T],R).
 namerel([X,Y|T],[Z|R]):- relative(Z,Y,X),namerel(T,R).

 mainsearch(X,Y,L,R):- search_id1(X,Y,L),namerel(L,R).
