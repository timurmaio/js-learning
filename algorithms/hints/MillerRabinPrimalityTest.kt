package algorithms

import java.util.*

/**
 * Тест простоты Миллера-Рабина
 * @return true, если число вероятно простое
 */
fun millerRabinPrimalityTest(n: Int, rounds: Int = Math.log(n.toDouble()).toInt()): Boolean {
    if (n % 2 == 0) {
        return false
    }

    val (s, u) = extractPowerOfTwo(n - 1)

    for (r in 1..rounds) {
        // проверяем a как свидетеля простоты n
        val a = (2..n).random()

        var x = powMod(a.toLong(), u.toLong(), n.toLong()).toInt()
        if (x == 1 || x == n - 1) {
            continue
        }

        for (i in 1 until s) {
            x = powMod(x.toLong(), 2, n.toLong()).toInt()

            if (x == 1) {
                return false
            }

            if (x == n - 1) {
                continue
            }

            return false
        }
    }

    return true
}

/**
 * Приведение числа к виду n = 2^s * u
 * @return <s, u>
 */
fun extractPowerOfTwo(n: Int): Pair<Int, Int> {
    var s = 0

    var u = n
    while (u % 2 == 0) {
        s++
        u /= 2
    }

    return Pair(s, u)
}

/**
 *  (0..10) => between 0 and 9 inclusive
 */
fun ClosedRange<Int>.random() = Random().nextInt(endInclusive - start) + start
