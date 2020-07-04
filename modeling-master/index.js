var fs = require('fs')
const ModelFamily = require('./ModelFamily.js')
const best = require('./helpersBestModel.js')
const h = require('./helpers.js')
const Model = require('./model')

// -----------------------Первая часть задания
var dataEducY = []
var dataEducX = []
var dataTestY = []
var dataTestX = []

fs.readFile('data.csv', 'utf8', (err, data) => {
  if (err) { throw err }
  main(data)
})

function main (data) {
// читаем данные из файла
  var fileData = data.split(/\n/)

// Подготовка обучающей и тестовой выборки
  for (var i = 0; i < fileData.length; i++) {
    var row = []
    var newData = fileData[i].split(/,/)

    for (var j = 0; j < newData.length; j++) {
      row.push(+newData[j])
      if (j === newData.length / 2 - 1) {
        dataEducX.push(row)
        row = []
      }
      if (j === newData.length - 1) {
        dataTestX.push(row)
      }
    }
    if (i === 5) {
      dataEducY = dataEducX[i]
      dataEducX.pop()
      dataTestY = dataTestX[i]
      dataTestX.pop()
    }
  }

// Количество семейств моделей (доступно 5)
  var modelFamilyCount = 5
// Инициализация входной матрицы данных для построения семейств моделей
  var inputMatrix = h.initInputMatrix(dataEducX, dataEducX.length, dataEducX[0].length)
// Получаем массив из сочетаний факторов
  var factor = []
  inputMatrix.forEach(function (item) {
    var row = [item[3][0], item[3][1]]
    factor.push(row)
    item.pop()
  })

// Построение семейств моделей
  var modelFamily = []
  var bestModels = []

  for (var modelFamilyNumber = 1; modelFamilyNumber < modelFamilyCount + 1; modelFamilyNumber++) {
    modelFamily[modelFamilyNumber] = new ModelFamily(inputMatrix, dataEducY, modelFamilyNumber, factor)
 // console.log("Семейство моделей №" + (modelFamilyNumber));
    for (var ModelNumber = 0; ModelNumber < modelFamily[modelFamilyNumber].modelCount; ModelNumber++) {
   // Построение модели
    // console.log("Model №" + (ModelNumber + 1))
    // console.log(modelFamily[modelFamilyNumber].models[ModelNumber]);
    // console.log('\n');
    }
// Поиск лучшей модели в семействе
    bestModels.push(modelFamily[modelFamilyNumber].models[best.findBestModel(modelFamily[modelFamilyNumber])])
  }

  // Выводим лучшие модели
  // console.log("Найдены лучшие модели: \n");
  bestModels.forEach(function (item) {
    // console.log(item);
  })

// -----------------------Вторая часть задания

// На основе результирующих у лучших моделей строим матрицу
  var newEducX = []
  var newFactor = []
  bestModels.forEach(function (item, i) {
    newEducX[i] = item.resultY
    newFactor.push(item.factor)
  })

// Инициализация входной матрицы данных для построения семейств моделей
  var newInputMatrix = h.initInputMatrix(newEducX, newEducX.length, newEducX[0].length)

// Запоминаем какие номера моделей, чьи результирующие у подавались на вход в матрице
  factor = []
  var inputModel = []
  newInputMatrix.forEach(function (item) {
    inputModel.push([item[3][0], item[3][1]])
    var row = [newFactor[item[3][0]], newFactor[item[3][1]]]
    factor.push(row)
    item.pop()
  })

  // Построение семейства моделей на основе входной матрицы, состоящей из результирующих у лучших моделей
  var bestModelFamily = new ModelFamily(newInputMatrix, dataEducY, 1, factor, inputModel)
  bestModelFamily.models.forEach(function (item) {
    // console.log(item);
  })

  // Поиск лучшей модели в семействе, построенным из лучших моделей
  var bestBestModel = bestModelFamily.models[best.findBestModel(bestModelFamily)]
   // console.log(bestBestModel);

  var testX = findTestY(bestBestModel, bestModels, dataTestX)
  var initTestX = h.initTestX(testX, testX.length, testX[0].length)

  var modelTestX = new Model(initTestX, dataTestY, 1, 1)
  console.log(modelTestX)
}

function findTestY (bestBestModel, bestModels, x) {
  var z1 = bestModels[bestBestModel.inputModel[0]].z
  var z2 = bestModels[bestBestModel.inputModel[1]].z
  var z = bestBestModel.z
  var resultY = []
  var resultA = []
  var resultB = []

  for (var i = 0; i < x[0].length; i++) {
    var resultX = []
    var testX = []
    for (var k = 0; k < dataTestX.length; k++) {
      testX.push(x[k][i])
    }
    var a = z1[0] + z1[1] * testX[bestBestModel.factor[0][0]] + z1[2] * testX[bestBestModel.factor[0][1]]
    var b = z2[0] + z2[1] * testX[bestBestModel.factor[1][0]] + z2[2] * testX[bestBestModel.factor[1][1]]
    var y = z[0] + z[1] * a + z[2] * b

    if (a === b) {
      b = Math.floor(b)
    }
    resultY.push(y)
    resultA.push(a)
    resultB.push(b)
  }
  resultX.push(resultA)
  resultX.push(resultB)

  return resultX
}
