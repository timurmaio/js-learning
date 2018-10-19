package algorithms

/**
 * Получение n-го числа Фибоначчи.
 */
fun getFibonacciNumber(n: Int): Long {
    val numbers = Array<Long>(100, { 0 })
    numbers[1] = 1

    for (i in (2..n)) {
        numbers[i] = numbers[i-1] + numbers[i-2]
    }

    return numbers[n]
}

/**
 * Последняя цифра n-го числа Фибоначчи.
 */
fun getLasDigitOfFibonacciNumber(n: Int): Int {
    return when (n) {
        0 -> 0
        1, 2 -> 1
        else -> {
            var fibNum = 1
            var prevFibNum = 1
            var prevPrevNum = 0

            for (i in (3..n)) {
                val newPrevPrevNum = prevFibNum
                fibNum = (fibNum + prevFibNum) % 10
                prevFibNum = (prevFibNum + prevPrevNum) % 10
                prevPrevNum = newPrevPrevNum
            }

            fibNum
        }
    }
}
