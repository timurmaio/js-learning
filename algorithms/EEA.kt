package algorithms

/**
 * Нахождение пары чисел таких, что a*x + b*y = gcd(a, b)
 * Результат - пара чисел-коэффициентов, для которых выполняется соотношение Безу.
 */
fun extendedEuclidean(a: Int, b: Int): Pair<Int, Int> {
    // построение списка с a/b
    val aDivBList = mutableListOf<Int>()
    var tmpA = a
    var tmpB = b
    while (tmpB != 0) {
        aDivBList.add(tmpA/tmpB)
        val tmp = tmpB
        tmpB = tmpA % tmpB
        tmpA = tmp
    }

    val steps = aDivBList.size
    var xPrev = 0
    var yPrev = 1
    var x = xPrev
    var y = yPrev
    for (i in (steps-2 downTo 0)) {
        x = yPrev
        y = xPrev - yPrev * aDivBList[i]
        xPrev = x
        yPrev = y
    }

    return Pair(x, y)
}
