class Canal {
  constructor (points) {
    this.params = this.calculateApproximateLine(points)
    var e = 3
    this.epsilon = Math.sqrt(Math.pow(e, 2) + Math.pow(this.params.m, 2) * Math.pow(e, 2))
    this.allPoints = points
  }

  isBelongs (point) {
    var y = this.params.m * point[0] + this.params.b
    return !!(((point[1] <= (y + this.epsilon)) && (point[1] >= (y - this.epsilon))))
  }

  isAbove (point) {
    var y = this.params.m * point[0] + this.params.b
    return point[1] > (y + this.epsilon)
  }

  isBelow (point) {
    var y = this.params.m * point[0] + this.params.b
    return point[1] < (y - this.epsilon)
  }

  calculateApproximateLine (data) {
    var m
    var b

    var dataLength = data.length

    if (dataLength === 1) {
      m = 0
      b = data[0][1]
    } else {
      var sumX = 0
      var sumY = 0
      var sumXX = 0
      var sumXY = 0

      var point
      var x
      var y

      for (var i = 0; i < dataLength; i++) {
        point = data[i]
        x = point[0]
        y = point[1]

        sumX += x
        sumY += y

        sumXX += x * x
        sumXY += x * y
      }

      m = ((dataLength * sumXY) - (sumX * sumY)) / ((dataLength * sumXX) - (sumX * sumX))

      b = (sumY / dataLength) - ((m * sumX) / dataLength)
    }

    return { m: m, b: b }
  }
}

module.exports = Canal
