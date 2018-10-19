package dataStructures.graphs

/**
 * Представление пары моментов времени начала и окончания обработки вершины при обходе графа.
 */
data class VertexVisitTime(var entry: Int, var leave: Int)
