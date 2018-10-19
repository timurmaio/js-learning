package algorithms.sortings

/**
 * Сортировка подсчётом.
 *
 * Входная последовательность содержит натуральные числа, не превышающие 9.
 * Необходимо вернуть упорядоченную по возрастанию последовательность этих чисел.
 */
fun countingSort(array: Array<Int>): Array<Int> {
    val numbers = Array(10, { 0 })

    array.forEach { numbers[it]++ }

    val result = mutableListOf<Int>()

    for (i in (0..array.size+1)) {
        while (numbers[i] != 0) {
            result.add(i)
            numbers[i]--
        }
    }

    return result.toTypedArray()
}
