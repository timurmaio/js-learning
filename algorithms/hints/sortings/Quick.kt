package algorithms.sortings

fun swap(array: Array<Int>, i: Int, j: Int) {
    val tmp = array[i]
    array[i] = array[j]
    array[j] = tmp
}

/**
 * Быстрая сортировка в реализации K&R в порядке возрастания.
 *
 * @param left левая граница сортировки
 * @param right правая граница сортировки
 */
fun quickSort(array: Array<Int>, left: Int, right: Int) {
    // в коллекции меньше двух элементов
    if (left >= right) {
        return
    }

    swap(array, left, (left + right) / 2)

    // разделитель в collection[0]
    var last = left

    // упорядочивание
    (left+1..right)
            .filter { array[it] < array[left] }
            .forEach { swap(array, ++last, it) }

    // вернуть разделитель на место
    swap(array, left, last)
    quickSort(array, left, last - 1)
    quickSort(array, last + 1, right)
}
