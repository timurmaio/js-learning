package algorithms

/**
 * Нахождение наименьшего общего кратного двух чисел.
 * Least Common Multiple
 */
fun lcm(a: Int, b: Int): Int = (a * b) / gcd(a, b)
