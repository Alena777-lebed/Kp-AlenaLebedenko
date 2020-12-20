# Отчет по курсовому проекту
## по курсу "Логическое программирование"

### студент: Иванопуло А.Б.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*

## Введение

Опишите, какие знания и навыки вы получите в результате выполнения курсового проекта.

## Задание

 1. Создать родословное дерево своего рода на несколько поколений (3-4) назад в стандартном формате GEDCOM с использованием сервиса MyHeritage.com 
 2. Преобразовать файл в формате GEDCOM в набор утверждений на языке Prolog, используя следующее представление: с использованием предикатов parent(родитель, ребенок), sex(человек, m/f).
 3. Реализовать предикат проверки/поиска Двоюродного брата.
 4. Реализовать программу на языке Prolog, которая позволит определять степень родства двух произвольных индивидуумов в дереве
 5. [На оценки хорошо и отлично] Реализовать естественно-языковый интерфейс к системе, позволяющий задавать вопросы относительно степеней родства, и получать осмысленные ответы. 
 
## Задание 1-2

Для этого задания я написала парсер на языке Python. 

## Задание 3

Для правила двоюродный брат я сначала написала правило brotherorsister(X,Y):- parent(Z,X), parent(Z,Y), X\=Y,!. , которое проверяет что Z - родитьель X, Z - родитель Y, и X не равно Y, отсечение стоит потому, что когда пролог у нас в предикатах perent(X,Y), сначала пролог выводит, что по отцу X брат или сестра Y, а затем по матери, и в итоге получается 2 овета. В моем дереве нет такого, что у одного человека больше одного брата или сестры, поэтому этот предкат выводит правильно одно имя, но если бы в моем дереве было так, что у одного человека более 1го брата или сертры, то этот предикат выводил бы только одного из родственнико.
cousinm(X,Y):- parent(X1,X), parent(Y1,Y), brotherorsister(X1,Y1), sex(X,m). основной предикат проверяет является ли X двоюродным брато Y, для этого он проверяет являются ли X1 братом или сестрой Y1, и проверяет,что пол X m.

Пример использования
?- cousinm(nikita,X).
X = alena .

Полный текст программы

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
    cousinm(X,Y):- parent(X1,X), parent(Y1,Y), brotherorsister(X1,Y1), sex(X,m).
  
  ## Задание 4
  
  Для этого задания я написала еще несколько правил для определения родства

    father(X,Y):- parent(X,Y),sex(X,m).
    mother(X,Y):- parent(X,Y),sex(X,f).
    brother(X,Y):- brotherorsister(X,Y), sex(X,m).
    sister(X,Y):- brotherorsister(X,Y), sex(X,f).
    cousinf(X,Y):- parent(X1,X), parent(Y1,Y), brotherorsister(X1,Y1), sex(X,f).
    cousinm(X,Y):- parent(X1,X), parent(Y1,Y), brotherorsister(X1,Y1), sex(X,m).
    grandfather(X,Y):- parent(Z,Y),parent(X,Z), sex(X,m).
    grandmother(X,Y):- parent(Z,Y),parent(X,Z), sex(X,f).

На основе этих правил написала правило relative(X,Y,Z).

    relative(X,Y,Z):- father(Y,Z), X = 'father - child'.
    relative(X,Y,Z):- mother(Y,Z), X = 'mother - child'.
    relative(X,Y,Z):- brother(Y,Z), X = 'brother'.
    relative(X,Y,Z):- sister(Y,Z), X = 'sister'.
    relative(X,Y,Z):- cousinm(Y,Z), X = 'cousinm'.
    relative(X,Y,Z):- cousinf(Y,Z), X = 'cousinf'.
    relative(X,Y,Z):- grandfather(Y,Z), X = 'grandfather'.
    relative(X,Y,Z):- grandmother(Y,Z), X = 'grandmother'.
    
И наконец основное правило 

    mainrelative([X],Y,Z,[Y,Z]):- relative(X,Y,Z),!.
    mainrelative([X|L],Y,Z,[Y|P]):- relative(X,Y,Z1), mainrelative(L,Z1,Z,P).
    
Наше основное правило проверяет есть ли определленное правило родства, если нет то мы определяем родство Y c некоторым Z1 и рекурсивно применяем наше правило. В итоге наш предикат возвращает 2 списка 1й список родствеников 2й список имен которые соответствуют списку родственников.

Примеры использования 

     ?- mainrelative(X,alexei,alena,Y).
     X = [ father - child, cousinm ], Y = [ alexei, nikita, alena ] ;
     X = [ father - child, cousinf ], Y = [ alexei, masha, alena ] .

     ?- mainrelative(X,ivan,alena,Y).
     X = [ father - child, grandfather ], Y = [ ivan, anatoly, alena ] ;
     X = [ grandfather, mother - child ], Y = [ ivan, marina, alena ] ;
     X = [ grandfather, mother - child, cousinm ], Y = [ ivan, anya, nikita, alena ] ;
     X = [ grandfather, mother - child, cousinf ], Y = [ ivan, anya, masha, alena ] ;
     X = [ grandfather, sister, mother - child ], Y = [ ivan, anya, marina, alena ] .
     
 Выводы
 
 Благодаря курсу логического программирования я узнала для себя такой подход к программированию как декларативный. Теперь когда мне приходьтся присать код на не декларативном языке я задумываюсь, а как это можно реализовать на Пролог и это помогоает мне в поиске более негких решений. Также этот курс заставил меня заинтересоваться искусственным интеллектом.
     
 

