# История

JavaScript был представлен в 1995 году как способ добавлять программы на веб-страницы в браузере Netscape Navigator. Важно отметить, что JavaScript практически не имеет отношения к другому языку под названием Java. Похожее имя было выбрано из маркетинговых соображений. Когда появился JavaScript, язык Java широко рекламировался и набирал популярность. Кое-кто решил, что неплохо бы прицепиться к этому паровозу. А теперь мы уже никуда не денемся от этого имени.

После того, как язык вышел за пределы Netscape, был составлен документ, описывающий работу языка, чтобы разные программы, заявляющие о его поддержке, работали одинаково. Он называется стандарт ECMAScript по имени организации ECMA. На практике можно говорить о ECMAScript и JavaScript как об одном и том же.

Многие ругают JavaScript и говорят о нём много плохого. И многое из этого – правда. Когда мне первый раз пришлось писать программу на JavaScript, я быстро почувствовал отвращение – язык принимал практически всё, что я писал, при этом интерпретировал это вовсе не так, как я подразумевал. В основном это было из-за того, что я не имел понятия о том, что делаю, но тут есть и проблема: JavaScript слишком либерален. Задумывалось это как облегчение программирования для начинающих. В реальности, это затрудняет розыск проблем в программе, потому что система о них не сообщает.

Гибкость имеет свои преимущества. Она оставляет место для разных техник, невозможных в более строгих языках. Иногда, как мы увидим в главе «модули», её можно использовать для преодоления некоторых недостатков языка. После того, как я по-настоящему изучил и поработал с ним, я научился любить JavaScript.

# Величины

>JavaScript использует фиксированное число бит (64) для хранения численных величин.

```javascript
var number = 13
var number_fraction = 9.81
console.log(number%number_fraction);  // арифметика
```

>Очень большие или маленькие числа записываются научной записью с буквой “e” (exponent), за которой следует 

```javascript
2.998e8 // это 2.998 × 10^8 = 299800000

isNan(NaN); // -> true
isFinite(NaN); // -> false
isFinite(123); // -> true

parseInt('12px'); // -> 12
parseInt('la12'); //-> NaN
parseInt('abcd'); // -> NaN
parseInt('abcd', 16); // 43981
parseFloat('12.3.4'); // -> 12.3

Math.floor(1.25) // 2
Math.ceil(1.25) // 1
Math.round(1.25) //1

1.25.toFixed('1')
123..toString() // '123'

0.1 + 0.2 == 0.3 // false
0.1 + 0.2 // 0.30000000000000004
+(0.1 + 0.2).toFixed(2) // 0.3

Math.pow(2, 3) // 8
Math.max(1, 2 ,3) // 3
Math.min()
Math.random()
+(Math.random() * 100).toFixed() // от 1 до 99 случайное число
```

# Специальные числа

В JavaScript есть три специальных значения, которые считаются числами, но ведут себя не как обычные числа.

Это Infinity и -Infinity, которые представляют положительную и отрицательную бесконечности. 
Infinity - 1 = Infinity, и так далее. Не надейтесь сильно на вычисления с бесконечностями, 
они не слишком строгие.

Третье число: NaN. Обозначает «not a number» (не число), хотя это 
величина числового типа. Вы можете получить её после вычислений типа 0 / 0, Infinity – Infinity, 
или других операций, которые не ведут к точным осмысленным результатам.

# Строки

```
​```javascript
```



```javascript
var string = "Что посеешь, то из пруда";
var string1 = 'Баба с возу, потехе час';
var str = 'bla
bla' // нельзя
var str = 'bla 
\bla' //можно
var a = 'mine\ngot';
var a = 'my \'apple\''
a = 'my "apple"'
a[0]// m
a.length
//10
a = 'blabla'
a.charAt(0)// b
a.indexOf('bla')//0
a.indexOf('bla', 1)

a.lastIndexOf('bla')

a.charCodeAt(0) //109 - unicode symbol

a.slice(0, 2) // bl

a.slice(0, -1) // blabl

a.slice(1) // labla

a.substr(1, 5) // 'labla'

var str = 'Марсоход пока не обнаружил следы жизни на Марсе';

var newStr = str.slice(str.indexOf('пока'), str.indexOf('следы') + 'следы'.length)

var newStr2 = str.slice(str.indexOf(' ') + 1, str.lastIndexOf(' '))
String.fromCharCode(109) //m - reverse
'AAAAA'.toLowerCase() // aaaaa
var string2 = "Между первой и второй\nсимвол будет небольшой"
console.log(string2);
```

# Унарные 

console.log(typeof 4.5)

# Булевские

```javascript
console.log(3 > 2)
```

console.log("Арбуз" <  "Яблоко")

> Строки сравниваются по алфавиту: буквы в верхнем регистре всегда «меньше» букв в нижнем регистре. Сравнение основано на стандарте Unicode.


В JavaScript есть только одна величина, которая не равна самой себе – NaN («не число»).

```javascript
console.log(NaN == NaN)// false
```

> NaN – это результат любого бессмысленного вычисления, поэтому он не равен результату какого-то другого бессмысленного вычисления.


console.log(true && false)
// → false

console.log(true && true)
// → true

// Оператор || — логическое «или». Выдаёт true, если одна из величин true.

console.log(false || true)
// → true

console.log(true ? 1 : 2)
// → 1

# Неопределённые значения

Существуют два специальных значения, null и undefined, которые используются для 
обозначения отсутствия осмысленного значения. Сами по себе они никакой информации не несут.

Много операторов, которые не выдают значения, возвращают undefined просто для того, 
чтобы что-то вернуть. Разница между undefined и null появилась в языке случайно, 
и обычно не имеет значения.

Ранее я упоминал, что JavaScript позволяет выполнять любые, подчас очень странные программы. К примеру:

```javascript
console.log(8 * null) // 0 
console.log("5" - 1) // 4
console.log("5" + 1)// 51
console.log("пять" * 2)// NaN
console.log(false == 0)// true
```

Но что, если вам надо сравнить нечто с точной величиной? Правила преобразования типов в 
булевские значения говорят, что 0, NaN и пустая строка “” считаются false, а все остальные – true. 
Поэтому 0 == false и “” == false. В случаях, когда вам не нужно автоматическое преобразование типов, 
можно использовать ещё два оператора: === и !==. Первый проверяет, что две величины абсолютно 
идентичны, второй – наоборот. И тогда сравнение “” === false возвращает false.

Рекомендую использовать трёхсимвольные операторы сравнения для защиты от неожиданных преобразований типов, 
которые могут привести к непредсказуемым последствиям. Если вы уверены, 
что типы сравниваемых величин будут совпадать, можно спокойно использовать короткие операторы.

# Преобразование типов

> Строковые

```javascript
String(NaN)
"" + NaN 
true + ''

```

> Числовые

```javascript
Number('1')
'1' - '0'

+'123'

+null, +false, +'0', +"" == 0

Но!

+undefined == NaN

+'12sadas'

// NaN

+'0xff'

// 255

true -> 1

false -> 0

true - false = 1

null == undefined -> true

```




Логическое

```javascript
!!value -> Boolean
```

undefined, null, 0, NaN, "" -> false
Object, 's', 1 -> true

// К примеру, || вернёт значение с левой части, когда его можно преобразовать в true – 
// а иначе вернёт правую часть.

console.log(null || "user")
// → user

console.log("Karl" || "user")
// → Karl



## Директива Break

```javascript
var i = 0;
while(1) {
	console.log(i);
	i++;
	break;
}
// 0
```


## Директива Continue

```javascript
var i = 0;
while(i < 5) {
  	if(i > 3) {
      continue;
  	}
	console.log(i);
  	i++;
}
// 0, 1, 2, 3
```



## Метки

> Позволяют останавливать цикл с выходом на отмеченный уровень:

```javascript
outer: for(;;) {
  for(var i = 0; i < 10; i++) {
    if (i > 3) 
      break outer;
    console.log(i);
  }
}
```

> Метки можно ставить на блок:

```javascript
outer: {
  for(;;) {
  	for(var i = 0; i < 10; i++) {
    	if (i > 3) 
     	 break outer;
   	 	console.log(i);
  		}
	}
}
```

> Метки можно использовать совмествно с break | continue.



```javascript

```



```javascript

```



```javascript

```



## Конструкции if | else

var test = 25;

if (test > 15) { 

console.log(test + ' > 15');

}

else if (test < 30) {

console.log('No!');

}

else {

return false;

}

Оператор ?

var age = 15;

message = (age < 14) ? 'Вы слишком молоды' : 'Ну ладно, заходите';

console.log(message);



# Объекты

```javascript
var person = new Object;
person = {};

person.age = 25;

delete person.age

person['age'] = 25

person['мой день рождения'] = '15.09.1995'

var key = 'age'

console.log(person[key])

console.log(person)
```


По-другому

```javascript
var person = {age: 30, name: 'Timur'}
```

for(var key in person) console.log(key)

for(var key in person) console.log(key + ' : ' + person[key])

Любое несуществующее или удаленное свойство - undefined

```javascript
person.name == undefined
```

лучше оператор in


```javascript
'age' in person // true 
```
потому что undefined можно присвоить

В некоторых случаях JavaScript позволяет опускать точку с запятой в конце инструкции. 
В других случаях она обязательна, или следующая строка будет расцениваться как часть той же инструкции.


Переменные можно называть любым словом, которое не является ключевым (типа var). 
Нельзя использовать пробелы. Цифры тоже можно использовать, но не первым символом в названии. 
Нельзя использовать знаки пунктуации, кроме символов $ и _.»

# Функции

> Function Declaration
> можно вызывать до описания

```javascript
function sayHi() {
  console.log('hi');
}
```

  console.log('hi');

>Function Expression
>вызывать только после

```javascript
var sayHi = function() {
  console.log('hi');
}
```

>Функция есть значение

```javascript
function f(a, b) {
  return a + b;
}

var f1 = f;
f1(1, 2);
// 3
f1 = 6;
f1;
// 6
```

> Если f была рекурсивной и её удалили, то g не будет выполняться.

Но!

```javascript
var f = function func(n) { return n>1 ? n*func(n-1) : 1}
```

>так будет работать всегда именованные функции
>named function expression

# Массивы

```javascript
var arr = [1 , true , 'string']
arr.length === 3

var first = arr.shift

// .shift - удаляет из массива первый элемент и

// присваивает переменной first

arr.unshift('1', 'bla', 1, true);

// добавляет в начало массива элементы и возвращает его длину

arr.push('sads','asd')

// добаить в конец массива

var popped = arr.pop()

// изъять

arr.splice(2,1)

// удалить со 2торого элемента 1 элемент, возвращает массив

var cut = arr.splice(0, 2)

arr.splice(1, 1, 'sada', 12)

на первой позиции удалить 1 элемент, на его место два других

arr.splice(1, 0, '125', 125)

// только вставить

arr.concat(cut)

// добавляет в конец массив 

```





var $;

if (number < 5) {
  console.log('bitch!');
} 

while (number <= 12) {
  console.log(number);
  number = number + 2;
}

do {
  var name = prompt("Who are you?");
} while (!name);

console.log(name);

for (var number = 0; number <= 12; number = number + 2)
  console.log(number);


var result = 1;
for (var counter = 0; counter < 10; counter = counter + 1) {
  result = result * 2;
}

console.log(result);


for (var current = 20; ; current++) {
  if (current % 7 == 0)
    break;
}

console.log(current);

// Есть инкремент


counter += 1;
counter++;
++counter;

switch (prompt("Как погодка?")) {
  case "дождь":
    console.log("Не забудь зонт.");
    break;
  case "снег":
    console.log("Блин, мы в России!");
    break;
  case "солнечно":
    console.log("Оденься полегче.");
  case "облачно":
    console.log("Иди гуляй.");
    break;
  default:
    console.log("Непонятная погода!");
    break;
}

// fuzzyLittleTurtle - регистр

console.log(square(12));
// → 144

var makeNoise = function() {
  console.log("Хрясь!");
};

makeNoise();
// → Хрясь!

var power = function(base, exponent) {
  var result = 1;
  for (var count = 0; count < exponent; count++)
    result *= base;
  return result;
};

console.log(power(2, 10));
// → 1024

var x = "outside";

var f1 = function() {
   x = "inside f1";
};
f1();
console.log(x);
// → outside

var f2 = function() {
  x = "inside f2";
};
f2();
console.log(x);
// → inside f2


function square(x) {
  return x * x;
}


// Это объявление функции. Инструкция определяет переменную square и присваивает ей заданную функцию. 
// Пока всё ок. Есть только один подводный камень в таком определении.

console.log("The future says:", future());

function future() {
  return "We STILL have no flying cars.";
}

# Прототипы

```javascript
var head = {
  glasses: 1
};

var table = {
  pen: 3,
  proto: head
};

console.log(table.glasses);

var bed = {
sheet: 1,
pillow: 2,
__proto__: table
};
var pockets = {
  money: 2000,
  proto: bed
};

var money = { 
  value: 99999999999,
  giveGulnara: function() {
	console.log(this.value)
}}

money.giveGulnara()
```