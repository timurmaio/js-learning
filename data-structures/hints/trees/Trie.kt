package dataStructures.trees

/**
 * Структура данных Trie, она же нагруженное дерево, префиксное дерево, бор.
 */
class Trie {
    private val root: TrieNode = TrieNode(data = '\u0000')

    /**
     * Добавление слова.
     */
    fun insertWord(word: String)
    {
        var currentTrie = root

        for (letter in word)
        {
            var inserted = false
            for (downTrie in currentTrie.downLevel)
            {
                if (downTrie.data == letter)
                {
                    currentTrie = downTrie
                    inserted = true
                    break
                }
            }

            if (!inserted)
            {
                val down = TrieNode(data = letter, base = currentTrie)
                currentTrie.downLevel.add(down)
                currentTrie = down
            }
        }

        currentTrie.count++
    }
}
