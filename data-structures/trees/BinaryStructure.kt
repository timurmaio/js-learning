package dataStructures.trees

import java.util.*

data class BinaryStructure<T>(val value: T, var left: BinaryStructure<T>? = null, var right: BinaryStructure<T>? = null)

fun <T> binaryStructureEnumeration(root: BinaryStructure<T>) {
    val stack: Stack<BinaryStructure<T>> = Stack()
    stack.push(root)

    var node: BinaryStructure<T>

    while (!stack.empty()) {
        node = stack.pop()

        println(node.value)

        if (node.right != null) {
            stack.push(node.right)
        }

        if (node.left != null) {
            stack.push(node.left)
        }
    }
}

fun <T> binaryStructureContains(root: BinaryStructure<T>, value: T): Boolean {
    val queue: PriorityQueue<BinaryStructure<T>> = PriorityQueue()
    queue.add(root)

    var node: BinaryStructure<T>

    while (queue.isNotEmpty()) {
        node = queue.first()

        if (node.value == value) {
            return true
        }
        else {
            if (node.left != null) {
                queue.add(node.left)
            }
            if (node.right != null) {
                queue.add(node.right)
            }
        }
    }

    return false
}

fun binarySearchStructureFind(root: BinaryStructure<Int>, value: Int): Boolean {
    var tmp: BinaryStructure<Int>? = root

    while (tmp != null) {
        if (tmp.value == value) {
            return true
        }
        else {
            if (value > tmp.value) {
                tmp = tmp.right
            }
            else {
                tmp = tmp.left
            }
        }
    }

    return false
}

fun binarySearchStructureInsert(root: BinaryStructure<Int>, value: Int) {
    var tmp: BinaryStructure<Int>? = root
    var added = false

    while (!added) {
        if (value > tmp!!.value) {
            if  (tmp.right != null) {
                tmp = tmp.right
            }
            else {
                tmp.right = BinaryStructure(value)
                added = true
            }

        }
        else if (value < tmp.value) {
            if (tmp.left != null) {
                tmp = tmp.left
            }
            else {
                tmp.left = BinaryStructure(value)
                added = true
            }
        }
        else {
            // equal values are not allowed
            return
        }
    }
}

fun binaryStructureMeasureDepth(root: BinaryStructure<Int>?, level: Int = 0, maxLevel: Int = 0): Int {
    if (root == null) {
        return maxLevel
    }

    val currentLevel = level + 1
    val newMaxLevel = if (currentLevel > maxLevel) currentLevel else maxLevel

    val leftLevel = binaryStructureMeasureDepth(root.left, currentLevel, newMaxLevel)
    val rightLevel = binaryStructureMeasureDepth(root.right, currentLevel, newMaxLevel)

    return maxOf(newMaxLevel, leftLevel, rightLevel)
}
