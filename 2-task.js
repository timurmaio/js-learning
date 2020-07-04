isNaN(NaN);          // true

isFinite(NaN);       // false
// Определяет, является ли переданное значение конечным числом.

isFinite(Infinity);  // false
isFinite(NaN);       // false
isFinite(-Infinity); // false
isFinite(123); // true

parseInt('12px'); // 12

parseInt('la12'); // NaN

parseInt('abcd'); // NaN

parseInt('abcd', 16); // 43981

parseFloat('12.3.4'); // 12.3

Math.floor(1.25) // 1

Math.ceil(1.25); // 2

Math.round(1.25); // 1

1.25.toFixed('2'); // 1.25

123..toString(); // '123'

12.3 + 34.5 ^ 0; // 46

0.1 + 0.2 == 0.3; // false

0.1 + 0.2 // 0.30000000000000004

+(0.1 + 0.2).toFixed(2) // 0.3

Math.pow(2, 3) // 8

Math.max(1, 2 ,3) // 3

Math.min()

Math.random()

+(Math.random() * 100).toFixed() // от 1 до 99 случайное число

// var str = 'bla
// bla';
// Нельзя!

var str = 'bla \
bla';
Можно!

var a = 'mine\ngot';

var a = 'my \'apple\''

var a = 'my "apple"'

a.length //10

a[0] // m

a.charAt(0) // m

a.indexOf('bla') //0

a.indexOf('bla', 1)

a.lastIndexOf('bla')

a.charCodeAt(0) //109 - unicode symbol

a.slice(0, 2) // bl

a.slice(0, -1) // blabl

a.slice(1) // labla

a.substr(1, 5) // 'labla'

string.slice(beginIndex, endIndex)

string.substr(beginIndex, length);

var str = 'Марсоход пока не обнаружил следы жизни на Марсе';

let string = 'Имя: Артём Фамилия: Василец Отчество: Викторович';

let name = string.slice(string.indexOf('Имя') + 'Имя'.length + 2, string.indexOf('Фамилия'));

function extractField(start, end, string) {
	return string.slice(string.indexOf(start) + start.length + 2, string.indexOf(end) - 1);
}

extractField('Опыт работы', 'Образование', string);

name = string.slice(string.indexOf('Имя') + 'Имя'.length + 2, string.indexOf('Фамилия') - 1);

var newStr = str.slice(str.indexOf('пока'), str.indexOf('следы') + 'следы'.length)

var newStr2 = str.slice(str.indexOf(' ') + 1, str.lastIndexOf(' '))

String.fromCharCode(109) //m - reverse

'AAAAA'.toLowerCase() // aaaaa

Преобразование типов

Пример

1. String(NaN)
2. "" + NaN 
3. true + ''

К числу

Number('1')

'1' - '0'

+'123'

+null, +false, +'0', +"" == 0
Но!
+undefined == NaN

+'12sadas' // NaN

+'0xff' // 255

true -> 1
false -> 0

true - false = 1

null == undefined -> true

Логическое

!!value -> Boolean

undefined, null, 0, NaN, "" -> false
Object, 's', 1 -> true

Объекты

var person = new Object;

person = {};

person.age = 25;

delete person.age

person['age'] = 25

person['мой день рождения'] = '15.09.1995'

var key = 'age'

console.log(person[key])

console.log(person)

По-другому

var person = {age: 30, name: 'Timur'}

for(var key in person) console.log(key)

for(var key in person) console.log(key + ' : ' + person[key])

Любое несуществующее или удаленное свойство - undefined

person.name == undefined

лучше оператор in
'age' in person // true

потому что undefined можно присвоить

Функции

Function Declaration
можно вызывать до описания

sayHi();

function sayHi() {
  console.log('hi');
}

Function Expression
вызывать только после

var sayHi = function() {
  console.log('hi');
}

if (5 > 1) 
{function h () {var b = 3;}}
    else
    {function h(){var b = 4;}}

sayHi();

Функция есть значение
вызов на месте ()

function f(a, b) {
  return a + b;
}

var f1 = f;

f1(1, 2); // 3

f1 = 6;

f1; // 6

Если f была рекурсивной и её удалили, то g не будет выполняться.
Но!

var f = function func(n) { return n>1 ? n*func(n-1): 1}
так будет работать всегда именованные функции
// named function expression

Массивы

var arr = [1 , true , 'string']

arr.length === 3


var first = arr.shift() // .shift - удаляет из массива первый элемент и присваивает переменной first

arr.unshift('1', 'bla', 1, true); // добавляет в начало массива элементы и возвращает его длину

arr.push('sads','asd') // добаить в конец массива

var popped = arr.pop() // изъять

arr.splice(2,1) // удалить со 2торого элемента 1 элемент, возвращает массив

var cut = arr.splice(0, 2)

arr.splice(1, 1, 'sada', 12) // на первой позиции удалить 1 элемент, на его место два других

arr.splice(1, 0, '125', 125)
// только вставить

arr.concat(cut)
// добавляет в конец массив 