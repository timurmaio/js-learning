const Model = require('./model')

class ModelFamily {
  constructor (inputMatrix, y, familyNumber, factor, inputModel) {
    var models = []

    for (var i = 0; i < inputMatrix.length; i++) {
      if (inputModel) {
        var model = new Model(inputMatrix[i], y, familyNumber, i, factor[i], inputModel[i])
      } else {
        var model = new Model(inputMatrix[i], y, familyNumber, i, factor[i])
      }
      models.push(model)
    }
    this.models = models
    this.number = familyNumber
    this.modelCount = inputMatrix.length
  }
}

module.exports = ModelFamily
