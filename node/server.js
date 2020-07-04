var User = require('./user');

var Cat = require('./cat');

// console.log(Cat);

function run() {
  var Sima = new Cat('Sima');
  var Timur = new User('Timur');
  var Dina = new Dog('Dina');
  var Dina2 = new global.Dog('Dina-global');

  console.log(Sima.getName());

  console.log(Dina.getName());
  console.log(Dina2.getName());

  console.log(Timur.hello());
  console.log(Timur.hi());

  // console.log(module);
}

if (module.parent) {
  exports.run = run;
} else {
  run();
}

function main() {
  console.log('main');
}
