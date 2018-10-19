const fs = require('fs')
const Canal = require('./Canal')
const Stock = require('./Stock')

// reading files from directory and return array of each file content with name (Stock) : return Promise(Array[])


function readFilesFromDir (path) {
  return new Promise((resolve, reject) => {
    fs.readdir(path, (err, files) => {
      if (err) reject(err)
      let stocks = []
      let count = 0
      files.forEach((file) => {
        if (file === '.DS_Store') count++
        if (file !== '.DS_Store') {
          fs.readFile(`${path}/${file}`, 'UTF8', (err, data) => {
            if (err) reject(err)
            stocks.push(new Stock(file, data))
            count++
            if (count === files.length) { resolve(stocks) }
          })
        }
      })
    })
  })
}

// building canals from file content array : return Array[]
function buildCanals (dataArr) {
  // calculate canal width, epsilon : number
  let e = Math.abs(dataArr[dataArr.length - 1][1] - dataArr[0][1]) / dataArr.length * 30

  let canals = []

  let arr = [dataArr[0], dataArr[1]]
  let i = 0

  canals[i] = new Canal(arr, e)

  let aboveCounter = 0
  let belowCounter = 0

  let aboveArr = []
  let belowArr = []

  dataArr.forEach((item) => {
    if (item !== dataArr[0] && item !== dataArr[1]) {
      if (canals[i].isBelongs(item)) {
        if (aboveCounter !== 0) {
          aboveCounter = 0
          aboveArr = []
        }

        if (belowCounter !== 0) {
          belowCounter = 0
          belowArr = []
        }

        arr.push(item)
        canals[i] = new Canal(arr, e)
      } else if (canals[i].isAbove(item)) {
        aboveCounter++
        aboveArr.push(item)

        if (aboveCounter === 2) {
          i++
          canals[i] = new Canal(aboveArr, e)
          arr = aboveArr
          aboveCounter = 0
          aboveArr = []
        }
      } else if (canals[i].isBelow(item)) {
        belowCounter++
        belowArr.push(item)

        if (belowCounter === 2) {
          i++
          canals[i] = new Canal(belowArr, e)
          arr = belowArr
          belowCounter = 0
          belowArr = []
        }
      }
    }
  })

  return canals
}

// make forecast whether to buy the stock : return Boolean
function makeForecast (canals) {
  let pointsNum = 0

  for (let i = 0; i < canals.length; i++) {
    pointsNum += canals[i].allPoints.length
  }

  let avgCanalLength = Math.ceil(pointsNum / canals.length)
  let last = canals.length - 1

  if (canals[last].params.m > 0 && canals[last].allPoints.length < avgCanalLength) return true

  return false
}

module.exports.readFilesFromDir = readFilesFromDir
module.exports.buildCanals = buildCanals
module.exports.makeForecast = makeForecast
