package algorithms

/**
 * Нахождение наибольшего общего делителя двух чисел алгоритмом Евклида.
 * Greatest Common Divisor
 */
fun gcd(a: Int, b: Int): Int {
    var quotient = a
    var remainder = b

    while (remainder != 0) {
        val tmp = remainder
        remainder = quotient % remainder
        quotient = tmp
    }

    return quotient
}

/**
 * Рекурсивный алгоритм нахождения НОД.
 */
fun gcdRecursive(a: Int, b: Int): Int {
    return when {
        b != 0 -> gcdRecursive(b, a % b)
        else -> a
    }
}
