
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
cousinf(X,Y):- parent(X1,X), parent(Y1,Y), brotherorsister(X1,Y1), sex(X,f).
