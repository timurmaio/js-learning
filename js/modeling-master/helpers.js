function fillWithOnes (arr, height, width) {
  for (var i = 0; i < 4; i++) {
    arr[i] = []
    for (var j = 0; j < height + 1; j++) {
      arr[i][j] = 0
      arr[0][j] = 1
    }
  }
  return arr
}

function initInputMatrix (x, height, width) {
  var result = []
  for (var i = 0; i < width; i++) {
    for (var j = i + 1; j < height; j++) {
      let arr = []
      arr = fillWithOnes(arr, height, width)
      for (var k = 0; k <= height; k++) {
        arr[1][k] = x[i][k]
        arr[2][k] = x[j][k]
        arr[3][0] = i
        arr[3][1] = j
      }
      result.push(arr)
    }
  }
  return result
}

function criterionDarbin (y, resultY) {
  var e = []
  var e2 = []
  var e3 = 0
  var e4 = 0
  var criterionDarbin = []
  for (var i = 0; i < y.length; i++) {
    e[i] = y[i] - resultY[i]
    e2[i] = Math.pow(e[i], 2)
    if (i === 0) {
      criterionDarbin[i] = 0
    } else {
      criterionDarbin[i] = Math.pow((e[i] - e[i - 1]), 2)
    }
    e3 += criterionDarbin[i]
    e4 += e2[i]
  }
  return e3 / e4
}

// Тест Голдфелда-Квандта проверяет модель на наличие гетероскедастичности
function testGoldfeldaKvandta (model, y, criterionF) {
  var sortMatrix = []
  var S = []
  var matrix = []

  for (var sortIndex = 0; sortIndex < 2; sortIndex++) {
    sortMatrix = sort(model.inputMatrix, model.resultY, y, sortIndex)
    for (var sIndex = 0; sIndex < 3; sIndex++) {
      matrix[sIndex] = cut(sortMatrix, sIndex + 1, 3)
      S[sIndex] = matrixS(matrix[sIndex])
    }
  }
  return S[0] / S[2]
}

// Вычисляет S по формуле квадрата разности у и у(х)
function getS (y, resultY, n) {
  var S = 0
  for (var i = 0; i < n; i++) {
    S += (y[i] - resultY[i]) * (y[i] - resultY[i])
  }
  return S
}

// На основе входной матрицы вычисляет МНК
function matrixS (matrix) {
  // массив данных показателей х1 и х2
  var inputMatrixX = []
  // массив данных показателей у
  var inputMatrixY = []
  // массив результативного у(х) (вычисленного по формуле при построении модели)
  var inputMatrixResultY = []

  for (var j = 0; j < matrix.length; j++) {
    if (j < matrix.length - 2) {
      inputMatrixX.push(matrix[j])
    }
    if (j === matrix.length - 2) {
      inputMatrixResultY = matrix[j]
    }
    if (j === matrix.length - 1) {
      inputMatrixY = matrix[j]
    }
  }
  return getS(inputMatrixY, inputMatrixResultY, inputMatrixY.length)
}

// Функция возвращает запрашиваемую часть отсортированного массива (1 или 3)
function cut (sortMatrix, part, partCount) {
  var length = sortMatrix[0].length
  var elemCount = Math.ceil(length / partCount)
  var arr = []
  var start = 0
  var end = 0
  for (var i = 0; i < sortMatrix.length; i++) {
    var arr2 = []
    arr[i] = arr2
    start = elemCount * (part - 1)
    end = elemCount * part
    if (length < elemCount * part) {
      start = elemCount * (part - 1) - 1
      end = elemCount * part - 1
    }
    for (var j = start; j < end; j++) {
      arr[i].push(sortMatrix[i][j])
    }
  }
  return arr
}

// Нормализация матрицы (убирается матрица с единицами, оставшаяся склеивается с матрицей у)
function normalize (inputMatrix, resultY, y) {
  let arr1 = []
  let arr2 = []
  arr1.push(inputMatrix[1])
  arr2.push(inputMatrix[2])
  var arr = [arr1, arr2, resultY, y]
  return arr
}

// Сортировка по показателю (доступно только: по х1 или х2)
function sort (inputMatrix, resultY, y, column) {
  var arr = normalize(inputMatrix, resultY, y)
  var count = arr.length + 1
  for (var i = 0; i < count; i++) {
    for (var j = 0; j < count - i; j++) {
      if (arr[column][j] > arr[column][j + 1]) {
        var min = []
        switch (column) {
          case 0:
            min[column] = arr[column][j + 1]
            min[column + 1] = arr[column + 1][j + 1]
            min[column + 2] = arr[column + 2][j + 1]
            min[column + 3] = arr[column + 3][j + 1]
            arr[column][j + 1] = arr[column][j]
            arr[column][j] = min[column]
            arr[column + 1][j + 1] = arr[column + 1][j]
            arr[column + 1][j] = min[column + 1]
            arr[column + 2][j + 1] = arr[column + 2][j]
            arr[column + 2][j] = min[column + 2]
            arr[column + 3][j + 1] = arr[column + 3][j]
            arr[column + 3][j] = min[column + 3]
            break
          case 1:
            min[column - 1] = arr[column - 1][j + 1]
            min[column] = arr[column][j + 1]
            min[column + 1] = arr[column + 1][j + 1]
            min[column + 2] = arr[column + 2][j + 1]
            arr[column - 1][j + 1] = arr[column - 1][j]
            arr[column - 1][j] = min[column - 1]
            arr[column][j + 1] = arr[column][j]
            arr[column][j] = min[column]
            arr[column + 1][j + 1] = arr[column + 1][j]
            arr[column + 1][j] = min[column + 1]
            arr[column + 2][j + 1] = arr[column + 2][j]
            arr[column + 2][j] = min[column + 2]
            break
        }
      }
    }
  }
  return arr
}

function multiNormalize (matrix) {
  return [matrix[1], matrix[2]]
}

function multicollinearity (model) {
  var matrix = multiNormalize(model.inputMatrix)
  var sumX = getSum(matrix[0], matrix[0].length)
  var sumY = getSum(matrix[1], matrix[1].length)

  var sumXY = getSumXY(matrix)
  var sumX2 = 0
  var sumY2 = 0

  for (var i = 0; i < matrix[0].length; i++) {
    sumX2 += matrix[0][i] * matrix[0][i]
    sumY2 += matrix[1][i] * matrix[1][i]
  }

  var qX = sumX2 - sumX * sumX
  var qY = sumY2 - sumY * sumY

  return (sumXY - sumX * sumY) / (qX * qY)
}

function getSum (q, n) {
  var sum = 0
  for (var i = 0; i < n; i++) {
    sum += q[i]
  }
  return 1 / n * sum
}

function getSumXY (matrix) {
  var sum = 0
  var x = matrix[0]
  var y = matrix[1]
  var n = matrix[0].length
  for (var i = 0; i < n; i++) {
    sum += x[i] * y[i]
  }
  return 1 / n * sum
}

function equal (arr1, arr2) {
  for (var i = 0; i < arr1.length; i++) {
    if (arr1[i] === arr2[i]) {
      return true
    } else {
      return false
    }
  }
}

function initTestX (x, height, width) {
  var arr = []
  var row = []
  for (var i = 0; i < width; i++) {
    row.push(1)
  }
  arr.push(row)
  for (var i = 0; i < height; i++) {
    arr.push(x[i])
  }
  return arr
}

module.exports.multicollinearity = multicollinearity
module.exports.initTestX = initTestX
module.exports.initInputMatrix = initInputMatrix
module.exports.criterionDarbin = criterionDarbin
module.exports.sort = sort
module.exports.testGoldfeldaKvandta = testGoldfeldaKvandta
module.exports.equal = equal
