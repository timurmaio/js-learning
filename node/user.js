var phrases = require('./ru');

function User(name) {
  this.name = name;
  this.hi = function(argument) {
    return phrases.Hello + ' ' + this.name;
  }
}

function Dog(name) {
  this.name = name;
  this.getName = function() {
    return phrases.Hello + ' ' + this.name;
  }
}

global.Dog = Dog;

User.prototype.hello = function(first_argument) {
  return phrases.Hello + ' ' + this.name;
};

// console.log('user.js is required');

module.exports = User;

// exports.User = User;

// console.log(module);
