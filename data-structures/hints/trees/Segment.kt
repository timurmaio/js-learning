package dataStructures.trees

import algorithms.isPowerOfTwo

/**
 * Дерево отрезков.
 */
class Segment(collection: Iterable<Int>) {
    /**
     * Массив с узлами дерева.
     *
     * Дерево на самом деле виртуальное. Отображение индексов:
     * левый потомок: 2*i + 1
     * правый потомок: 2*i + 2
     * родитель: (i-1)/2
     */
    private val nodes: Array<Int>

    /**
     * Создание дерева отрезков из коллекции.
     *
     * Для правильности работы алгоритмов необходимо, чтобы размер коллекция был равен степени двойки.
     * Следовательно, если это не так, необходимо выровнять её до ближайшей большей степени двойки.
     */
    init {
        // дополнение длины массива до степени двойки
        var length = collection.count()
        while (!isPowerOfTwo(length.toLong()))
        {
            length++
        }

        // дерево будет иметь размер (выровненная длина)*2-1
        nodes = Array(length * 2 - 1, { 0 })

        // копирование элементов массива в листья дерева
        var j = length - 1
        for (item in collection) {
            nodes[j] = item
            j++
        }

        // заполнение пустых листов дерева в зависимости от задачи
        // для поиска минимума - максимальными значениями и т.д.
        for (i in length - 1 + collection.count() until nodes.size) {
            nodes[i] = Int.MAX_VALUE
        }

        // выстраивание дерева вверх от листьев к корню
        // downTo 1 - корневая вершина не требует обновления родителей
        // step 2 - чтобы не обновлять родителя дважды от обоих потомков
        for (i in nodes.size - 1 downTo 1 step 2) {
            updateParent(i)
        }
    }

    /**
     * Функция над двумя узлами дерева, результат которой соответствует значению родительского узла для двух данных.
     */
    private fun function(x: Int, y: Int): Int = if (x < y) x else y

    /**
     * Вычисление значения для отрезка по узлам дерева.
     *
     * @param curIndex Индекс текущего узла.
     * @param curNodeL Левая граница отрезка, на котором подсчитана функция и записана в данном узле.
     * @param curNodeR Правая граница отрезка, на котором подсчитана функция и записана в данном узле.
     * @param l Левая граница отрезка, на котором необходимо вычислить функцию.
     * @param r Правая граница отрезка, на котором необходимо вычислить функцию.
     *
     * @return Значение, вычисленное для заданного отрезка.
     */
    private fun queryInternal(curIndex: Int, curNodeL: Int, curNodeR: Int, l: Int, r: Int): Int {
        // отрезок, для которого вершина хранит значение,
        // лежит в запрашиваемом отрезке
        if (curNodeL >= l && curNodeR <= r)
        {
            return nodes[curIndex]
        }

        // отрезок, для которого вершина хранит значение,
        // никак не связан с запрашиваемым отрезком
        // возвращаем нейтральное значение для функции
        if (curNodeL > r || curNodeR < l)
        {
            return Int.MAX_VALUE
        }

        // передаём запросы потомкам
        // TODO: возможно здесь можно сделать оптимизацию и не вычислять значения
        // для тех потомков, которые не лежат в запрашиваемом отрезке
        val lResult = queryInternal(2 * curIndex + 1, curNodeL, (curNodeL + curNodeR) / 2, l, r)
        val rResult = queryInternal(2 * curIndex + 2, (curNodeL + curNodeR) / 2 + 1, curNodeR, l, r)

        return function(lResult, rResult)
    }

    /**
     * Обновление значения у родителя узла дерева по одному из его потомков,
     * а также, возможно, и всех родителей узла до корня.
     *
     * @param currentIndex Индекс узла дерева в массиве узлов.
     * @param updateAllParents Обновлять только непосредственно родительский узел или
     * также все родительские узлы до корня.
     */
    private fun updateParent(currentIndex: Int, updateAllParents: Boolean = false) {
        var index = currentIndex
        while (index != 0)
        {
            val parentIndex = (index - 1)/2

            // индекс вершины чётный, она является правым потомком
            val otherIndex = if (index%2 == 0) index - 1 else index + 1

            val value = function(nodes[index], nodes[otherIndex])
            nodes[parentIndex] = value

            if (!updateAllParents)
            {
                return
            }

            index = parentIndex
        }
    }

    /**
     * Вычисление функции на отрезке в массиве от левой до правой границы отрезка.
     *
     * Сложность: O(log(n)).
     */
    fun query(left: Int, right: Int): Int = queryInternal(0, 0, nodes.size/2, left, right)

    /**
     * Изменение значения в массиве по индексу на новое значение.
     *
     * Сложность: O(log(n)).
     */
    fun update(index: Int, value: Int) {
        // нахождение индекса (позиции) листа, который необходимо изменить
        val position = nodes.size / 2 + index

        nodes[position] = value
        updateParent(position, true)
    }
}
