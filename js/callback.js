function f(param1, param2, callback) {
  var sum = param1 + param2;

  if (typeof callback === 'function') {
    callback(sum);
  }

}

f(1, 11, function(summ) {
  console.log('Сумма равна ' + summ);
});

function f2(param1, param2) {
  var sum = param1 + param2;
  return sum;
}

console.log(f2(1, 11));

var fruits = ['Apple', 'Pear'];

fruits.forEach(function(eachName, index) {
  console.log(index + 1 + '. ' + eachName);
});

/* глобальная переменная (внимание - использование глобальных переменных является антипаттерном) */
var allUserData = [];
// определение функции logStuff для вывода в консоль
function logStuff(userData) {
  if (typeof userData === 'string') {
    console.log(userData);
  } else if (typeof userData === 'object') {
    for (var item in userData) {
      console.log(item + ': ' + userData[item]);
    }
  }
}
// Функция, принимающая два параметра, одним из которых является коллбэк 
function getInput(options, callback) {
  allUserData.push(options);
  callback(options);
}
// Пример вызова функции getInput с коллбком
getInput({ name: 'Rich', speciality: 'JavaScript' }, logStuff);
var userData = {
  id: 094545,
  fullName: 'Unknown',
  setUserName: function(firstName, lastName) {
    this.fullName = firstName + ' ' + lastName;
    // console.log(this);
  }
}

// userData.setUserName('john', 'snow');
function getUserInput(firstName, lastName, callback, scope) {
  callback.call(scope, firstName, lastName);
}
// иначе this == global (window) 
getUserInput('John', 'Snow', userData.setUserName, userData);
console.log(userData.fullName); // Unknown
// console.log(window.fullName); // John Snow
