function findBestD (itemD, bestD) {
  if (itemD < 0 && bestD < 0) {
    itemD += 1
    bestD += 1
  }
  if (itemD < 0 && bestD > 0) {
    itemD += 1
  }
  if (itemD > 0 && bestD < 0) {
    bestD += 1
  }
  return ffindBestD(itemD, bestD)
}

function ffindBestD (itemD, bestD) {
  if (itemD > bestD) return true
  else return false
}

function findBestR (itemR, bestR) {
  if (itemR < 1 && bestR > 1) {
    itemR = 1 - itemR
    bestR = bestR - 1
  }
  if (itemR > 1 && bestR < 1) {
    itemR = itemR - 1
    bestR = 1 - bestR
  }
  if (itemR < 1 && bestR < 1) {
    itemR = 1 - itemR
    bestR = 1 - bestR
  }
  if (itemR > 1 && bestR > 1) {
    itemR = itemR - 1
    bestR = bestR - 1
  }
  return ffindBestR(itemR, bestR)
}

function ffindBestR (itemR, bestR) {
  if (itemR > bestR) return true
  else return false
}

function findBestG (itemG, bestG) {
  if (itemG > bestG) return true
  else return false
}

function findBestM (itemM, bestM) {
  if (itemM > bestM) return true
  else return false
}

function sortModelFamilyR (modelFamily) {
  var arr = []
  modelFamily.models.forEach(function (item, i) {
    var arr2 = []
    arr2.push(i)
    arr2.push(item.r)
    arr.push(arr2)
  })

  var best = arr[0]
  var count = arr.length - 1
  var arrNew = arr
  for (var i = 0; i < count; i++) {
    for (var j = 0; j < count - i; j++) {
      if (findBestR(arrNew[j][1], arrNew[j + 1][1])) {
        best = arrNew[j]
        arrNew[j] = arrNew[j + 1]
        arrNew[j + 1] = best
      }
    }
  }
  return arr
}

function sortModelFamilyD (modelFamily) {
  var arr = []
  modelFamily.models.forEach(function (item, i) {
    var arr2 = []
    arr2.push(i)
    arr2.push(item.criterionDarbin)
    arr.push(arr2)
  })

  var best = arr[0]
  var count = arr.length - 1
  var arrNew = arr
  for (var i = 0; i < count; i++) {
    for (var j = 0; j < count - i; j++) {
      if (findBestD(arrNew[j][1], arrNew[j + 1][1])) {
        best = arrNew[j]
        arrNew[j] = arrNew[j + 1]
        arrNew[j + 1] = best
      }
    }
  }
  return arr
}

function sortModelFamilyG (modelFamily) {
  var arr = []
  modelFamily.models.forEach(function (item, i) {
    var arr2 = []
    arr2.push(i)
    arr2.push(item.testGoldfeldaKvandta)
    arr.push(arr2)
  })

  var best = arr[0]
  var count = arr.length - 1
  var arrNew = arr
  for (var i = 0; i < count; i++) {
    for (var j = 0; j < count - i; j++) {
      if (findBestG(arrNew[j][1], arrNew[j + 1][1])) {
        best = arrNew[j]
        arrNew[j] = arrNew[j + 1]
        arrNew[j + 1] = best
      }
    }
  }
  return arr
}

function sortModelFamilyM (modelFamily) {
  var arr = []
  modelFamily.models.forEach(function (item, i) {
    var arr2 = []
    arr2.push(i)
    arr2.push(item.multicollinearity)
    arr.push(arr2)
  })

  var best = arr[0]
  var count = arr.length - 1
  var arrNew = arr
  for (var i = 0; i < count; i++) {
    for (var j = 0; j < count - i; j++) {
      if (findBestM(arrNew[j][1], arrNew[j + 1][1])) {
        best = arrNew[j]
        arrNew[j] = arrNew[j + 1]
        arrNew[j + 1] = best
      }
    }
  }
  return arr
}

function findBestModel (modelFamily) {
  var arr = []
  var modelFamilyR = sortModelFamilyR(modelFamily)
  var modelFamilyD = sortModelFamilyD(modelFamily)
  var modelFamilyG = sortModelFamilyG(modelFamily)
  var modelFamilyM = sortModelFamilyM(modelFamily)

  modelFamily.models.forEach(function (item, number) {
    var count = 0
    for (var i = 0; i < modelFamily.modelCount; i++) {
      if (modelFamilyR[i][0] === number) count += i
      if (modelFamilyD[i][0] === number) count += i
      if (modelFamilyG[i][0] === number) count += i
      if (modelFamilyM[i][0] === number) count += i
    }
    arr[number] = count
  })

  for (var j = 0; j < arr.length; j++) {
    if (Math.min.apply(Math, arr) === arr[j]) return j
  }
}

module.exports.findBestModel = findBestModel
