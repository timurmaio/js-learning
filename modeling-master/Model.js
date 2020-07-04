const math = require('mathjs')
const h = require('./helpers.js')

class Model {
  constructor (inputMatrix, y, familyNumber, modelNumber, factor, inputModel) {
    // Критерий Фишера для обнаружения гетероскедастичности
    var criterionF = 3.8
    if (inputModel) {
      this.inputModel = inputModel
    }
    if (factor) {
      this.factor = factor
    }
    // Номер семейства
    this.familyNumber = familyNumber
    this.modelNumber = modelNumber
    // Входная матрица
    this.inputMatrix = inputMatrix
    // Вычисляем Z
    var B1 = math.transpose(inputMatrix)
    var F1 = math.multiply(inputMatrix, B1)
    var F4 = math.inv(F1)
    var F2 = math.multiply(F4, inputMatrix)
    this.z = math.multiply(F2, y)
    // Длина входной матрицы
    var matrixLength = inputMatrix[0].length
    // Вычисляем результат выполнения формулы каждой паре
    var u = []
    var u2 = []
    var S1 = 0
    var S2 = 0
    var S3 = 0
    // var criterionDarbin = []

    for (var i = 0; i < matrixLength; i++) {
      S3 += y[i]
      u[i] = 0
    }

    S3 = S3 / matrixLength

    for (var m = 0; m < matrixLength; m++) {
      switch (familyNumber) {
        case 1:
          u[m] = (this.z[0] + this.z[1] * inputMatrix[1][m] + this.z[2] * inputMatrix[2][m] - y[m]) * (this.z[0] + this.z[1] * inputMatrix[1][m] + this.z[2] * inputMatrix[2][m] - y[m])
          break
        case 2:
          u[m] = (this.z[0] + this.z[1] * Math.pow(inputMatrix[1][m], 2) + this.z[2] * Math.pow(inputMatrix[2][m], 2) - y[m]) * (this.z[0] + this.z[1] * Math.pow(inputMatrix[1][m], 2) + this.z[2] * Math.pow(inputMatrix[2][m], 2) - y[m])
          break
        case 3:
          u[m] = (this.z[0] + this.z[1] * Math.pow(inputMatrix[1][m], 3) + this.z[2] * Math.pow(inputMatrix[2][m], 3) - y[m]) * (this.z[0] + this.z[1] * Math.pow(inputMatrix[1][m], 3) + this.z[2] * Math.pow(inputMatrix[2][m], 3) - y[m])
          break
        case 4:
          u[m] = (this.z[0] + this.z[1] * Math.sqrt(inputMatrix[1][m]) + this.z[2] * Math.sqrt(inputMatrix[2][m]) - y[m]) * (this.z[0] + this.z[1] * Math.sqrt(inputMatrix[1][m]) + this.z[2] * Math.sqrt(inputMatrix[2][m]) - y[m])
          break
        case 5:
          u[m] = (this.z[0] + this.z[1] * Math.log(inputMatrix[1][m]) + this.z[2] * Math.log(inputMatrix[2][m]) - y[m]) * (this.z[0] + this.z[1] * Math.log(inputMatrix[1][m]) + this.z[2] * Math.log(inputMatrix[2][m]) - y[m])
          break
      }
      S1 += u[m]
      u2[m] = (S3 - y[m]) * (S3 - y[m])
      S2 += u2[m]
    }

    this.resultY = u

    // Коэффициент детерминации
    this.r = 1 - (S1 / S2)
    this.S1 = S1
    this.S2 = S2
    this.S3 = S3
    // Наличие гетероскедатичности
    this.testGoldfeldaKvandta = h.testGoldfeldaKvandta(this, y, criterionF)
    // Наличие мультиколлинеарности
    this.multicollinearity = h.multicollinearity(this)
    // Находит критерий Дарбина-Уотсона (чем ближе к 2 тем лучше)
    this.criterionDarbin = h.criterionDarbin(y, this.resultY)
  }
}

module.exports = Model
