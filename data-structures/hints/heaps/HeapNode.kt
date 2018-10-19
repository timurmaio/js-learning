package dataStructures.heaps

data class HeapNode<T>(var priority: Int, val value: T) {
    override fun toString(): String {
        return "[priority=$priority value=$value]"
    }
}
