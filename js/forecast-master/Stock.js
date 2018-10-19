class Stock {
  constructor (name, arr) {
    this.name = name
    this.values = this.makeArrFromData(arr)
  }

  // making array from file content : return Array[]
  makeArrFromData (data) {
    let dataArr = data.split(/\n/)
    dataArr.shift()
    dataArr.pop()

    let arr = dataArr.map((item, i) => {
      let row = item.split(/,/)
      return [
        // ++i, +row[7], row[2] // with Date
        ++i, +row[7] // without Date
      ]
    })

    return arr
  }
}

module.exports = Stock
