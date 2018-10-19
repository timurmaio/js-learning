package algorithms

/**
 * В консоль вводятся числа. Вывести их в обратном порядке
 */
fun reverseInput() {
    val value = readLine()
    if (value != null) {
        reverseInput()
        print("$value ")
    }
}
