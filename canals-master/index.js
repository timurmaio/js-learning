var fs = require('fs')

var Canal = require('./Canal')

var canals = []

fs.readFile('data.csv', 'utf8', (err, data) => {
  if (err) { throw err }

  var data2 = data.split(/\n/)

  data2.shift()
  data2.pop()

  var data3 = data2.map((item, i) => {
    var row = item.split(/,/)
    return [
      ++i, +row[7], row[2]
    ]
  })

  main(data3)

  console.log('Количество каналов: ' + canals.length)

  canals.forEach((item, i) => {
    console.log('Канал номер ' + ++i)
    console.log(item.allPoints)
  })
})

function main (data) {
  var array = [data[0], data[1]]

  var i = 0

  canals[i] = new Canal(array)

  var aboveCounter = 0
  var belowCounter = 0

  var aboveArray = []
  var belowArray = []

  data.forEach((item) => {
    if (item !== data[0] && item !== data[1]) {
      if (canals[i].isBelongs(item)) {
        if (aboveCounter !== 0) {
          aboveCounter = 0
          aboveArray = []
        }

        if (belowCounter !== 0) {
          belowCounter = 0
          belowArray = []
        }

        array.push(item)
        canals[i] = new Canal(array)
      } else if (canals[i].isAbove(item)) {
        aboveCounter++
        aboveArray.push(item)

        if (aboveCounter === 2) {
          i++
          canals[i] = new Canal(aboveArray)
          array = aboveArray
          aboveCounter = 0
          aboveArray = []
        }
      } else if (canals[i].isBelow(item)) {
        belowCounter++
        belowArray.push(item)

        if (belowCounter === 2) {
          i++
          canals[i] = new Canal(belowArray)
          array = belowArray
          belowCounter = 0
          belowArray = []
        }
      }
    }
  })
}
