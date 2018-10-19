package dataStructures.graphs

/**
 * Граф с различными представлениями.
 */
class Graph(vertices: Int, edgeArray: Array<Pair<Int, Int>>, direction: GraphDirection = GraphDirection.UNDIRECTED) {
    /**
     * Размер графа.
     */
    val size: Int = vertices

    /**
     * Массив, в ячейки которого записывается true, если мы побывали в вершине с таким индексом.
     */
    var visited: Array<Boolean> = Array(size, { false })

    /**
     * Количество компонент связности.
     */
    var connectedComponentCount: Int = 0

    /**
     * Массив, индексы которого - номера вершин графа,
     * а значение ячеек это номера компонент связности, к которым принадлежит данная вершина.
     *
     * Компонента связности - максимальный подграф, в который входит некоторый набор вершин.
     */
    var connectedComponents: Array<Int> = Array(size, { 0 })

    /**
     * Текущий момент времени при обходе графа в поисках циклов.
     */
    var currentTime: Int = 0

    /**
     * Массив с моментами начала и завершения обработки каждой вершины при обходе графа.
     */
    var visitTimestamps: Array<VertexVisitTime> = Array(size, { VertexVisitTime(0, 0) })

    /**
     *  Содержит ли граф циклы.
     */
    var hasCycles: Boolean = false

    /**
     * Список смежности (для каждой вершины (массив) храним список вершин, до которых можно добраться).
     *
     * storage: O(|V|+|E|)
     * add(v||e): O(1)
     * remove(v||e): O(|E|)
     * query(u,v): O(|V|)
     * adjacent vertices enumeration: O(|V|) (d - vertices, adjacent to this)
     */
    val adjacencyList: Array<List<Int>> = Array(0, { emptyList<Int>() })

    /**
     * Матрица смежности (для весов используем int вместо bool).
     * Наиболее подходит для небольших и плотных графов.
     *
     * storage: O(|V|^2)
     * add|remove(v): O(|V|^2)
     * add|remove(e): O(1)
     * query(u,v): O(1)
     * adjacent vertices enumeration: O(|V|)
     */
    val adjacencyMatrix: Array<Array<Boolean>>

    /**
     * Матрица инцидентности (строки - вершины, столбцы - рёбра;
     * в ячейке(строка i, столбец j) ставим:
     * 1, если ребро j выходит из вершины i;
     * -1, если ребро j входит в вершину i;
     * 0, если ребро является петлёй или ребро не инцидентно вершине).
     *
     * storage|add|remove: O(|V|*|E|)
     * query(u,v): O(|E|)
     */
    val incidenceMatrix: Array<Array<Boolean>> = Array(0, { Array(0, { false }) })

    /**
     * Список инцидентности (список рёбер) (две вершины, имеющие ребро).
     *
     * storage: O(|V|+|E|)
     * add(v||e): O(1)
     * remove(v||e): O(|E|)
     * query(u,v): O(|E|)
     * adjacent vertices enumeration: O(|E|)
     */
    val incidenceList: List<GraphVertexPair> = emptyList()

    /**
     * Создание неориентированного графа (матрицы смежности).
     */
    init {
        adjacencyMatrix = Array(size, { Array(size, { false }) })

        edgeArray.forEach {
            adjacencyMatrix[it.first][it.second] = true

            // для неориентированных графов добавляем ребро назад
            if (direction == GraphDirection.UNDIRECTED) {
                adjacencyMatrix[it.second][it.first] = true
            }
        }
    }

    /**
     * Устанавливает visited[u]==true, для всех вершин u, достижимых из v.
     */
    private fun explore(v: Int) {
        // побывали в текущей вершине
        visited[v] = true

        // для каждой вершины, до которой можно добраться
        // из данной (v)
        for (u in 0 until size) {
            // если мы можем до неё добраться и не были в ней
            if (adjacencyMatrix[v][u] && !visited[u]) {
                // то идём в неё
                explore(u)
            }
        }
    }

    /**
     * Алгоритм поиска в глубину.
     *
     * Сложность: O(|V|+|E|)
     */
    private fun depthFirstSearch() {
        visited = Array(size, { false })

        // для каждой вершины в графе
        for (v in 0 until size) {
            // если мы там не были
            if (!visited[v]) {
                // заходим и делаем что-то
                explore(v)
            }
        }
    }

    /**
     * Проверка, можно ли добраться из одной вершины до другой.
     */
    fun checkAttainability(v: Int, u: Int): Boolean {
        explore(v)
        return visited[u]
    }

    /**
     * Просмотр вершины и присвоение ей номера компоненты связности.
     */
    private fun exploreConnectedComponents(v: Int) {
        connectedComponents[v] = connectedComponentCount

        visited[v] = true

        for (u in 0 until size) {
            if (adjacencyMatrix[v][u] && !visited[u]) {
                exploreConnectedComponents(u)
            }
        }
    }

    /**
     * Определение количества компонент связности поиском в глубину.
     */
    fun depthFirstSearchConnectedComponents() {
        visited = Array(size, { false })
        connectedComponents = Array(size, { 0 })
        connectedComponentCount = 0

        for (v in 0 until size) {
            if (!visited[v]) {
                exploreConnectedComponents(v)

                // в вызове Explore выше мы обошли все вершины, достижимые
                // из v. Значит мы имеем очередную компоненту связности
                connectedComponentCount++
            }
        }
    }

    private fun exploreHasCycles(v: Int) {
        visited[v] = true
        visitTimestamps[v].entry = ++currentTime

        for (u in 0 until size) {
            if (adjacencyMatrix[v][u] && !visited[u]) {
                exploreHasCycles(u)

                // TODO: целесообразно ли?
                if (visitTimestamps[v].entry < visitTimestamps[u].entry &&
                        visitTimestamps[v].leave > visitTimestamps[u].leave) {
                    hasCycles = true
                }
            }
        }

        visitTimestamps[v].leave = ++currentTime
    }

    private fun depthFirstSearchHasCycles() {
        visited = Array(size, { false })
        visitTimestamps = Array(size, { VertexVisitTime(0, 0) })

        for (v in 0 until size) {
            if (!visited[v]) {
                exploreHasCycles(v)
            }
        }
    }

    private fun findCycle(): Boolean {
        for (v in 0 until size) {
            for (u in 0 until size) {
                if (adjacencyMatrix[v][u] &&
                        visitTimestamps[v].entry > visitTimestamps[u].entry &&
                        visitTimestamps[v].leave < visitTimestamps[u].leave) {
                    return true
                }
            }
        }

        return false
    }

    /**
     * Определение, есть ли в графе циклы.
     */
    fun graphHasCycles(): Boolean {
        depthFirstSearchHasCycles()

        if (!hasCycles)
        {
            hasCycles = findCycle()
        }

        return hasCycles
    }
}
