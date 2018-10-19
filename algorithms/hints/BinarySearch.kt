package algorithms

/**
 * Двоичный поиск в массиве.
 *
 * @return Индекс числа в массиве. Если такого числа нет, возвращает null.
 */
fun binarySearch(array: Array<Int>, n: Int): Int? {
    var l = 0
    var r = array.size

    while (l <= r) {
        val m = (l + r)/2

        if (array[m] == n) {
            return m
        }

        if (array[m] > n) {
            r = m - 1
        }
        else {
            l = m + 1
        }
    }

    return null
}
