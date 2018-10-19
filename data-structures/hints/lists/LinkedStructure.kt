package dataStructures.lists

data class LinkedStructure<T>(val value: T, var next: LinkedStructure<T>? = null)

fun <T> linkedListSize(head: LinkedStructure<T>): Int {
    var size = 0
    var current: LinkedStructure<T>? = head
    while (current != null) {
        current = current.next
        size++
    }

    return size
}

fun <T> linkedListInsertFirst(head: LinkedStructure<T>, value: T): LinkedStructure<T> {
    return LinkedStructure(value, head)
}

fun <T> linkedListInsertLast(head: LinkedStructure<T>, value: T) {
    var iterator: LinkedStructure<T>? = head
    while (iterator?.next != null) {
        iterator = iterator.next
    }

    iterator?.next = LinkedStructure(value)
}

fun <T> linkedListDeleteFirst(head: LinkedStructure<T>): LinkedStructure<T>? {
    return head.next
}

fun <T> linkedListDeleteLast(head: LinkedStructure<T>): LinkedStructure<T>? {
    if (linkedListSize(head) == 1) {
        return null
    }

    var iterator = head.next
    var newTail: LinkedStructure<T>? = head

    while (iterator?.next != null) {
        iterator = iterator.next
        newTail = newTail?.next
    }

    newTail?.next = null
    return newTail
}

/**
 * в рекурсивном варианте можно сначала дойти до конца списка,
 * развернуть последний указатель, а при выходе из рекурсии менять остальные указатели
 */
fun <T> linkedListReverse(head: LinkedStructure<T>): LinkedStructure<T> {
    var current: LinkedStructure<T>? = head

    if (current?.next != null) {
        var previous: LinkedStructure<T>? = null
        var next: LinkedStructure<T>?

        while (current != null) {
            next = current.next
            current.next = previous
            previous = current
            current = next
        }

        return previous!!
    }

    return head
}

fun <T> linkedListIsLooped(head: LinkedStructure<T>): Boolean {
    if (head.next != null) {
        var iterator: LinkedStructure<T>? = head

        while (iterator !== head && iterator !== null) {
            iterator = iterator.next
        }

        if (iterator === head) {
            return true
        }
    }

    return false
}
