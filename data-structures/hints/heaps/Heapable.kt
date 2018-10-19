package dataStructures.heaps

/**
 * Основные операции кучи.
 */
interface Heapable<TNode, TNodeValue> where TNode: HeapNode<TNodeValue> {
    /**
     * Количество элементов в куче.
     */
    val count: Int

    /**
     * Добавление элемента в кучу.
     */
    fun insert(item: TNode)

    /**
     * Извлечение элемента с наивысшим приоритетом из кучи.
     */
    fun extractMaximal(): TNode

    /**
     * Показать элемент с наивысшим приоритетом в куче.
     */
    fun peekMaximal(): TNode

    /**
     * Изменение приоритета у элемента в куче.
     */
    fun changePriority(item: TNode, newPriority: Int)

    /**
     * Удаление элемента из кучи.
     */
    fun remove(item: TNode)

    /**
     * Слияние двух куч в одну.
     *
     * @param heap Куча, с которой выполняется слияние.
     */
    fun merge(heap: Heapable<TNode, TNodeValue>)
}
