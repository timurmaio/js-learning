package dataStructures.heaps

/**
 * Двоичная куча.
 *
 * Кучи реализуют очередь с приоритетами.
 * Основная идея реализации - использование бинарного дерева.
 * Однако дерево не хранится в явном виде, оно задаётся массивом.
 *
 * Наибольший приоритет - Int.MAX_VALUE - 1
 *
 * Например, дерево с приоритетами
 *    x
 *  y   z
 *  будет представлено массивом
 *  [x][y][z]
 *
 *  Индексы увеличиваются на 1 по уровням от элемента к элементу слева направо, начиная с нуля.
 *  Индекс левого потомка: i * 2 + 1
 *  Индекс правого потомка: i * 2 + 2
 *  Индекс предка: (i-1)/2
 */
class Binary<T>(collection: Iterable<HeapNode<T>>) : Heapable<HeapNode<T>, T> {
    private val nodes: MutableList<HeapNode<T>> = collection.toMutableList()

    override val count: Int
        get() = this.nodes.size

    /**
     * Создание кучи из (неупорядоченной) коллекции.
     *
     * Сложность O(n).
     */
    init {
        // count/2 - потому что узлы ниже по дереву не имеют
        // потомков, поэтому они уже сбалансированы.
        for (i in (count/2) downTo 0) {
            heapify(i)
        }
    }

    /**
     * Обмен двух элементов кучи местами.
     */
    private fun swapNodes(i: Int, j: Int) {
        val tmp = nodes[i]
        nodes[i] = nodes[j]
        nodes[j] = tmp
    }

    /**
     * "Всплытие" элемента вверх по дереву, если его приоритет выше родительского.
     *
     * Сложность O(log2(n)) ~ высота дерева.
     */
    private fun siftUp(itemIndex: Int) {
        var currentItemIndex = itemIndex
        var parentIndex = (itemIndex - 1)/2


        // всплываем пока имеем приоритет выше родительскоко
        while (parentIndex >= 0 && nodes[currentItemIndex].priority > nodes[parentIndex].priority)
        {
            swapNodes(currentItemIndex, parentIndex)
            currentItemIndex = parentIndex
            parentIndex = (currentItemIndex - 1)/2
        }
    }

    /**
     * Восстановление свойства кучи для поддерева, корнем которого является указанная вершина.
     */
    private fun heapify(index: Int) {
        var currentIndex = index

        while (true)
        {
            val left = currentIndex*2 + 1
            val right = currentIndex*2 + 2
            var largest = currentIndex

            // определение индекса узла, в котором нарушено свойство кучи
            if (left < count && nodes[left].priority > nodes[largest].priority)
            {
                largest = left
            }

            if (right < count && nodes[right].priority > nodes[largest].priority)
            {
                largest = right
            }

            // свойство кучи не нарушено
            if (largest == currentIndex)
            {
                return
            }

            // меняем элементы и идём вниз по дереву
            swapNodes(largest, currentIndex)
            currentIndex = largest
        }
    }

    override fun insert(item: HeapNode<T>) {
        nodes.add(item)
        siftUp(count - 1)
    }

    override fun extractMaximal(): HeapNode<T> {
        if (count == 0)
        {
            throw Throwable("heap is empty")
        }

        val item = nodes[0]
        nodes[0] = nodes[count - 1]
        nodes.removeAt(count - 1)
        heapify(0)

        return item
    }

    override fun peekMaximal(): HeapNode<T> {
        if (count == 0)
        {
            throw Throwable("heap is empty")
        }

        return nodes[0]
    }

    override fun changePriority(item: HeapNode<T>, newPriority: Int) {
        // приоритет уменьшился - просеиваем (восстанавливаем свойство кучи)
        if (newPriority < item.priority)
        {
            item.priority = newPriority
            heapify(nodes.indexOf(item))
        }

        // приоритет увеличился - всплываем
        else if (newPriority > item.priority)
        {
            item.priority = newPriority
            siftUp(nodes.indexOf(item))
        }
    }

    override fun remove(item: HeapNode<T>) {
        item.priority = Int.MAX_VALUE
        siftUp(nodes.indexOf(item))
        extractMaximal()
    }

    override fun merge(heap: Heapable<HeapNode<T>, T>) {
        for (i in 0 until heap.count) {
            insert(heap.extractMaximal())
        }
    }
}
