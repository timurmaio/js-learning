10.02 Первые функции
====
Функция удвоения
----
	(DEFUN double (n) (* n 2))

Факториал
----
	(DEFUN fact (n) (IF ( = n 0) 1 ( * n (fact ( - n 1) ) ) ) )

НОД
----
	(DEFUN nod (n m) (IF ( = m 0) n (nod m ( mod n m) ) ) )

m^n
----
	(DEFUN power (m n) (IF ( = n 1) m (* m (power m ( - n 1) ) ) ) )

17.02  CAR, CDR, Списки
=====

***Атом*** - единичный элемент.

***Список*** - послед элем, каждый из которых может быть либо атомом, либо списком.

'(1 x 'student')

Пустой спиcок - NIL.

CAR
----
(CAR s)
>(CAR '(1 2 3))

Значением функции является первый элемент списка

CDR
----
Хвост списка
>(CDR '(1 2 3))

Задача 1
----
Задан список. Найти число элементов

	(DEFUN LISTCOUNT (s)
		(IF (EQ s NIL)
			0
			( + 1 (LISTCOUNT (CDR s)))
		)
	)


Задача 2
----
Задан числовой список. Найти сумму

	(DEFUN LISTSUM (s)
		(IF (EQ s NIL)
			0
			( + (CAR s)
				(LISTSUM (CDR s)))
		)
	)

	(DEFUN LISTSUM (s) (IF (EQ s NIL) 0 ( + (CAR s) (LISTSUM (CDR s))) ))

Задача 3
----
Найти максимальный элемент списка

Максимум двух чисел

	(DEFUN MAX2 (a b) (IF (> a b) a b)  ))

Максимум списка

	(DEFUN LISTMAX (s) (IF (EQ s NIL) 0 (MAX2 (CAR s) (LISTMAX (CDR s) ))))

Задача 4
----
Последний элемент списка

	(DEFUN LISTLAST (s) (IF (EQ (CDR s) NIL) (CAR s) (LISTLAST (CDR s) ) )  )

Логические функции
====
True and false
----
Заменены на T и NIL:

>(= 5 6)

>NIL

Функция равенства (обычно чисел)

( = s t)

Функция эквивалентности EQ подходит и для чисел.

(EQ s t)

Функции
----
AND, OR, NOT

> (AND T NIL)

>NIL

> (OR T NIL)

>T

> (NOT NIL)

>T

24.02 Функция cons
====
Значение cons - список, который получается добавлением в список b элемента a.

(cons a b)

(cons 1 '(2 3)) = (1 2 3)

(cons a NIL) = (a)

x=(cons(s,t)) <=> car(x)=s & cdr(x)=t

Задача 1
----
(del s) - удаление последнего элемента

	(defun del (s) (IF (EQ NIL (cdr s)) NIL (cons (car s) (del (cdr s)) )))

Задача 2
----
(append s t) - склеивание 2х списков

	(defun app (s s1) (IF (EQ NIL (cdr s)) (cons (car s) s1) (cons (car s) (app (cdr s) s1))))

>(app '(1 2 3) '(4 5))

Примечание: LISP воспринимает t как true

Задача 3
----
(inverse s) - переворачивание списка

	(DEFUN inverse (s) (IF(EQ NIL (CDR s )) (CONS (CAR s) NIL) (app (inverse (CDR s)) (CONS (CAR s) NIL) )   ))

>(inverse '(1 2 3))

>(3 2 1)

9.03 Контрольная
====
Задача:

Дан числовой список. Вернуть его, убрав четные числа. <br>
Версия Риты.


	(DEFUN dev (s)
		(IF (EQ s NIL)
			NIL
			(IF (= 0 (MOD (CAR S) 2))
				(dev (cdr s))
				(cons (car s) (dev (cdr s)) )
			)
		)
	)

Версия Тимура.

	(defun dev (s) (if (equal s nil) nil (
 	 if (equal (mod (car s) 2) 0) (dev (cdr s)) (cons (car s) (dev (cdr s))))))


16.03 Задачи на структурные списки
====

Задача 1
----
Дан нелинейный список, посчитать число атомов

(counte s)

	(DEFUN counte (s)
		(IF (EQ s NIL)
			0
			(IF (atom (car s) )
				(+ 1 (counte (cdr s)) )
				(+ (counte (car s)) (counte (cdr s))  )
			)
		)
	)

>(counte '(1 10 10 10 (10 20)))

>6


Задача 2
----
Сумма всех числовых атомов

(sume s)

	(DEFUN sume (s)
		(IF (EQ s NIL)
			0
			(IF (atom (car s) )
				(+ (car s) (sume (cdr s)) )
				(+ (sume (car s)) (sume (cdr s))  )
			)
		)
	)

>(sume '(1 10 (10 20) 10))

>51


Задача 3
----
Получить новый список, возведя все в указанную степень

(EXPl s n)

	(DEFUN expl (s n)
		(IF (EQ (cdr s) NIL)
			(IF (atom (car s) )
				(cons (power (car s) n) NIL)
				(cons (expl (car s) n) NIL)
			)
			(IF (atom (car s))
				(cons (power (car s) n) (expl (cdr s) n) )
				(cons (expl (car s) n) (expl (cdr s) n))
			)
		)
	)

>(expl '(1 3 (3 2)) 2)

>(1 9 (9 4))

23.03 Контрольная 2
====

Сделать reverse, который перевернет все, даже вложенные, списки

Добавление в конец списка
	(DEFUN consl (a s) (if (EQ (cdr s) NIL) (cons a NIL) (append s (cons a NIL)) ) )

	(DEFUN deepreverse (s) (IF (EQ (cdr s) NIL))
		(IF (atom (car s))
			(cons (car s) NIL)
			(deepreverse (car s))
		)
		(IF (atom (car s))
			(consl (car s) (deepreverse (cdr s)) )
			(append (deepreverse (cdr s)) (cons (deepreverse (car s)) NIL ))
		)
	)

6.04 Практика
====
Задача 1
----
Подобие структуры двух списков

	(DEFUN eq_structure (s1 s2) (IF (EQ s1 NIL) (IF (EQ s2 NIL) T NIL ) (IF (EQ s2 NIL)  NIL  (AND  (IF (EQ (atom (car s1)) (atom (car s2))) (IF (atom (car s1)) T (eq_structure (car s1) (car s2))) NIL) (eq_structure (cdr s1) (cdr s2))  ) ) ))

Если оба атомы или оба списки, T в список результатов. Потом AND над этим списком</br>
Проверять, когда они оба не атомы</br>

а а - Т </br>
а л - ф</br>
л ф - ф</br>
л л - eq_structure</br>

Задача 2
----
Включен ли один список в другой? (Как вложенный)

	(DEFUN member_list (s1 s2) (IF (EQUAL s2 NIL) NIL (OR (EQUAL s1 s2) (IF (atom (car s2)) NIL (member_list s1 (car s2))) (member_list s1 (cdr s2))  )))


Задача 3
----
Количество вхождений списка t1 в t2

(если не включен, 0, иначе ..)

	(DEFUN includings_number (s1 s2)
		(IF (member_list s1 s2)
			(+
				(IF (atom (car s2))
					0
					(IF (EQUAL (car s2) s1)
						1
						(includings_number s1 (car s2))
					)
				)
				(includings_number s1 (cdr s2))
			)
			0
		)
	)

	(DEFUN includings_number (s1 s2)  (IF (member_list s1 s2)  (+  (IF (atom (car s2)) 0 (IF (EQUAL (car s2) s1) 1 (includings_number s1 (car s2)) ) ) (includings_number s1 (cdr s2))  ) 0 ) )

13.04
====
Задача 1
----
Придумать и решить задачу на LET

Нахождение дискриминанта
b^2-4ac

	(DEFUN discr (params) (LET ((a (FIRST params)) (b (SECOND params)) (c (THIRD params))) (- (* b b) (* 4 a c) ) ))

>(discr '(3 5 8))
>-71

Задача 2
----
Придумать и решить задачу на PROG

m^n c клавиатуры

	(defun enteredpower()(progN (setq x (read ())) (setq y (read ())) (power x y)) )


20.04
====
Задача 1
----
sell (x s)
x = '+ или '*

Сумма

	(DEFUN LISTSUM (s) (IF (EQ s NIL) 0 ( + (CAR s) (LISTSUM (CDR s))) ))

Произведение

	(DEFUN LISTPROD (s) (IF (EQ s NIL) 1 ( * (CAR s) (LISTPROD (CDR s))) ))

Соответственно числа из списка s складываются или умножаются

	(defun sell (x s) (case x ((+) (LISTSUM s)) ((*) (LISTPROD s)) ))


>(sell '+ '(1 2 3))

>6

>(sell '* '(5 2 3))

>30


Задача 2
----
sels (x n)

x = 'f или 's или 'ss

Соответственно: n!, сумма от 1 до n, сумма от 1 до n для всех элем k^k

	(DEFUN fact (n) (IF ( = n 0) 1 ( * n (fact ( - n 1) ) ) ) )
	(DEFUN sumi (n) (IF ( = n 0) 0 ( + n (sumi ( - n 1) ) ) ) )
	(DEFUN power (m n) (IF ( = n 1) m (* m (power m ( - n 1) ) ) ) )
	(DEFUN sumpow (n) (IF ( = n 0) 0 ( + (power n n) (sumpow ( - n 1) ) ) ) )

	(defun sels (x n) (case x ((f) (fact n)) ((s) (sumi n)) ((ss) (sumpow n)) ) )

>(sels 'f 3)</br>
>6

>(sels 's 3)</br>
>6

>(sels 's 4)</br>
>10

>(sels 'f 4)</br>
>24

>(sels 'ss 4)</br>
>288


Задача 3
----
gcd(m n) - с помощью рекурсии, с помощью цикла.

Рекурсивно:

	(DEFUN nod (n m) (IF ( = m 0) n (nod m ( mod n m) ) ) )

Цикл:

	(DEFUN nod (n m) (LET ((n n)(m m)) (LOOP (cond ((= m 0) (return n))) (setq temp m) (setq m (mod n m)) (setq n temp))))

27.04 Контрольная
====
Задача:

(DEFUN gapply (s v))</br>
s = ('* '+)</br>
v = ((1 2) (2 3))</br>
Применить функции к аргументам, результат - список.</br>

Для всех элементов списка s</br>
LOOP</br>
объявление финсписка NIL</br>
(append финсписок (apply (car s) (car v)))</br>

	(DEFUN gapply (s v) (LET ((reslist (list NIL))) (LOOP (cond ((EQUAL NIL s) (return (cdr reslist)))) (setq reslist (append reslist (list (apply (eval (car s)) (car v))))) (setq s (cdr s)) (setq v (cdr v)))))

	(DEFUN gapply (s v)
		(LET ((reslist (list NIL)))
			(LOOP
				(cond ((EQUAL NIL s) (return (cdr reslist))))
				(setq reslist (append reslist (list (apply (eval (car s)) (car v)))))
				(setq s (cdr s))
				(setq v (cdr v))
			)
		)
	)

Версия Булата.

	(DEFUN gapply (q w)
	(SETQ lst '())
	(DO ((count (LENGTH w) (- count 1)))
	((= count 0) (RETURN lst))
	(SETQ lst (APPEND lst (LIST (APPLY (CAR q) (CAR w))))) (SETQ w (CDR w)) (SETQ q (CDR q))
	))

>(gapply '(+ -) '((2 3 4)(2 3 4)))

04.05
====
Задача 1 (Из контрольной второй подгруппы)
----
Список подсписков, найти суммы для всех подсписков, вернуть список ответов.

	(defun sum(l) (if (null l) 0 (+ (car l) (sum (cdr l)))))
	(defun total (v) (loop for e in v collect (sum e)))

>(total '((1 2) (3 4)))

Some Stuff
====

	(set 'list '(1 2 3 4 5 6 7)) ; задание списка

	(if (= (mod 4 2) 0) 'true 'false) ; проверка на четность

	(defun fact (n) (if (= n 0) 1 (* n (fact (- n 1))))) ; вычисление факториала числа

	(defun gcd (m n) (if (= n 0) m (gcd n (mod m n)))) ; нахождение наибольшего общего делителя двух целых чисел

	(defun pow (m n) (if (= n 0) 1 (* m (pow m (- n 1))))) ; возведение m в степень n

	(defun count (s) (if (eq s nil) 0 (+ 1 (count (cdr s)))))

	(defun sum (s) (if (eq s nil) 0 (+ (car s) (sum (cdr s)))))

	(defun max1 (x) (IF (equal x nil) 0 (max (car x) (max1 (cdr x)))))

	(DEFUN LASTM (X) (IF (EQUAL (CDR X) NIL) X (LASTM (CDR X))))

	(defun dell (s) (if (equal (cdr s) nil) nil (cons (car s) (dell (cdr s)))))

	(defun lastitem (s) (if (equal (cdr s) nil) (car s) (lastitem (cdr s))))

	(defun append (s r) (cons (car s) r))

	(defun inverse (s) (if (equal s nil) nil (cons (lastitem s)) (inverse (dell s))))

	(cons 1 '(2 3)) = (1 2 3)


Линейный список: список, элементы которого - атомы. <br>
Линейный: (a b c); <br>
Структурный: ((a b) c); <br>


Функции обработки списков
---
* ветвление
---

	(Cond (условие, действие) (условие, действие) (..,..))

* присваивания
---

	(Setq ( var) (expr))
	(Set ( (expr) (expr))
	((setq x '(a b)))
	(SETQ X' (y a))
	(set (car x) 5)

Циклы
===
Loop  
---
	(setq a 4)
>4

	(loop 
	(setq a (+ a 1))
	(when (> a 7) (return a)))
>8

	(loop
	(setq a (- a 1))
	(when (< a 3) (return)))
>NIL

DO
---
	(do ((x 1 (+ x 1))
	(y 1 (* y 2)))
	((> x 5) y)
	(print y)
	(print 'working)
	)
>1

>WORKING 

>2

>WORKING

>4 

>WORKING

>8

>WORKING 

>16

>WORKING

>32
