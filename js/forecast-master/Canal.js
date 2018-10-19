class Canal {
  constructor (points, epsilon) {
    this.params = this.calculateApproximateLine(points)
    let e
    if (epsilon) e = epsilon
    else e = 3
    this.epsilon = Math.sqrt(Math.pow(e, 2) + Math.pow(this.params.m, 2) * Math.pow(e, 2))
    this.allPoints = points
  }

  isBelongs (point) {
    let y = this.params.m * point[0] + this.params.b
    return !!(((point[1] <= (y + this.epsilon)) && (point[1] >= (y - this.epsilon))))
  }

  isAbove (point) {
    let y = this.params.m * point[0] + this.params.b
    return point[1] > (y + this.epsilon)
  }

  isBelow (point) {
    let y = this.params.m * point[0] + this.params.b
    return point[1] < (y - this.epsilon)
  }

  calculateApproximateLine (data) {
    let m
    let b

    let dataLength = data.length

    if (dataLength === 1) {
      m = 0
      b = data[0][1]
    } else {
      let sumX = 0
      let sumY = 0
      let sumXX = 0
      let sumXY = 0

      let point
      let x
      let y

      for (let i = 0; i < dataLength; i++) {
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
