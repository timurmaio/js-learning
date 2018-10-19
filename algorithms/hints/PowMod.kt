package algorithms

/**
 * Возведение в степень по модулю.
 *
 * @param b Число, возводимое в степень по модулю.
 * @param n Степень, в которую возводится число.
 * @param m Модуль, по которому число возводится в степень.
 */
fun powMod(b: Long, n: Long, m: Long): Long {
    var result = 1L
    var base = b
    var power = n

    while (power != 0L) {
        if (power % 2 == 0L) {
            power /= 2
            base = (base * base) % m
        }
        else {
            power--
            result = (result * base) % m
        }
    }

    return result
}
