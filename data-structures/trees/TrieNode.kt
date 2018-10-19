package dataStructures.trees

/**
 * @param count сколько раз слово добавлялось в trie
 * @param base родительская вершина
 */
data class TrieNode(
        val data: Char,
        var count: Int = 0,
        val base: TrieNode? = null,
        val downLevel: MutableList<TrieNode> = emptyList<TrieNode>().toMutableList()) {

    override fun toString(): String {
        return "data=$data count=$count"
    }
}
