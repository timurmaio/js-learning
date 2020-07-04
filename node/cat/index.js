function Cat(name) {
  this.name = name;
  this.getName = function() {
    return this.name;
  }
}

module.exports = Cat;

// console.log(module);
