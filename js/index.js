'use strict'

class Human {
	constructor (params) {
		this.state = params
	}
	setState (params) {
		this.state = params
	}
}

class Person extends Human {
	constructor(name, age) {
		super()
		// console.log(this)
		// this.setState({ name: name, age: age })
		// console.log(super.setState)
		this.state = {
			name: name,
			age: age
		}
	}
	setName (params) {
		// console.log(this)
		this.setState(params)
	}
	innerChangeState () {
		return `Hey ${this.setName({ name: 'Булат' })}`
		// return `Hey ${this.setName()}`this.setName('Булат')
		// console.log(`Hey ${this.setName()}`)
	}
	getState () {
		console.log(this.state)
	}
}


class User {
	constructor() {
		this.name = 'Тимур'
	}
	sayHi () {
		// console.log(`Привет ${this.name}!`)
		console.log(this)
	}
}

const t = new User()

var user = {
  firstName: "Вася",
  sayHi: function() {
    console.log( this.firstName );
  }
};

var func1 = function () {
	console.log(1, this)
	var func2 = function () {
		console.log(2, this)
	}
	var func4 = () => {
		console.log(4, this)
	}
	// func2 = func2.bind(user)
	func2()
	func4()
}

func1 = func1.bind(user)


function Person2() {
  // В конструкторе Person() `this` указывает на себя.
  this.age = 0;

  // setTimeout(function growUp() {
    // В нестрогом режиме, в функции growUp() `this` указывает 
    // на глобальный объект, который отличается от `this`,
    // определяемом в конструкторе Person().
    // this.age++;
    // console.log('hi!')
    // console.log(this.age)
  // }, 0);
  function ageIncrement () {
  	console.log(this)
  	// this.age++
  }

  let agePlus = () => {
  	console.log(this)
  	// this.age++
  }

  // ageIncrement()
  // agePlus()
}

Person2.prototype.getAge = function () {
	console.log(this.age)
}

var p = new Person2();
// p.getAge()



var obj = {
	name: 'Hey',
	func: function () {
		console.log('\n' + this.name + '\n')
    },
  func2: () => {
  	console.log(this)
  }
}

// var func5 = obj.func
// var func6 = obj.func2

var arrowObject = {};
arrowObject.name = 'arrowObject';
arrowObject.printName = () => {
  // console.log(this);
};


(function () {
    console.log(this)
}());


// ff()

var o1 = { a: 1 }
var o2 = { b: 2 }

console.log(Object.assign({}, o1, o2))

var spreadO = { ...o1 }
console.log(spreadO)


// for (var i = 0; i < 10; i++) { 
//   setTimeout(function () { 
//     console.log(i); 
//   }, 0); 
// }

var animal = {
	name: 'Animal',
	standUp: function () {
		console.log('stand ' + this.name)
	}
}	

var cat = {
	name: 'Cat',
	__proto__: animal
}

// cat.standUp()

function speak() {
  var words = 'hi';
  return function logIt() {
    console.log(words);
  }
}

var sayHello = speak()

// sayHello()

// console.log(sayHello)


function hi() {
	return
	3;
}


// console.log(hi())




var Counter = (function() {
  var privateCounter = 0;
  function changeBy(val) {
    privateCounter += val;
  }
  return {
    increment: function() {
      changeBy(1);
    },
    decrement: function() {
      changeBy(-1);
    },
    value: function() {
      return privateCounter;
    }
  };   
})();

// console.log(Counter)

// console.log(Counter.value()); /* Alerts 0 */
// Counter.increment();
// Counter.increment();
// alert(Counter.value()); /* Alerts 2 */
// Counter.decrement();
// alert(Counter.value()); /* Alerts 1 */


// var x = 1; 
// console.log(x); // 1 
// if (true) { 
//     var x = 2; 
//     // console.log(arguments); // 2 
// } 
// console.log(x); // 2



// function x() {
// 	var y
// 	return y
// 	y = 5
// }





// console.log(x())
// console.log(y)


function add(elem) {
  return function (elem2) {
    return elem + elem2
  }
}


console.log(add(8)(2))


const add2 = add(2)

console.log(add2(12))


var person = {  
  name: "Brendan Eich",
}

function hello(thing) {  
  console.log(this.name + " says hello " + thing);
}


// this:
console.log(person.prototype)



// desugars to this:
// person.hello.call(person, "world");  

function func () {
  let summ = 0
  Object.keys(arguments).map(item => {
    summ += arguments[item]
  })
  return summ
}

console.log(func(23, 2, 3, 4))



// let obj = {
//   a: 1,
//   b: 2,
//   c: 3
// };

// const obj2 = Object.create(obj);
// console.log(obj2);

function Animal (name) {
	this.name = name;
	this.jump = function () {
		console.log(`${this.name} jumps`);
	}
}

function Tiger (name) {

	// Animal.call(this);
	this.name = name;

	this.bites = function () {
		console.log(`${this.name} bites`);
	}
}

const timur = Object.create(Tiger.prototype);

console.log(timur.name)

const hui = new function(name) { this.name = name} ('Pidor');

// console.log(Tiger.prototype)
// console.log(new function(name) { this.name = name} ('Pidor'));

let arr = [ 1, 2, 3, 4 ]

function isEven(number) {
	return number % 2 === 0;
}

let evenArr = arr.filter(isEven);

console.log(arr);
console.log(evenArr);








