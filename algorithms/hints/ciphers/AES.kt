package algorithms.ciphers

import java.security.Key
import java.security.SecureRandom
import javax.crypto.Cipher
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.PBEKeySpec
import javax.crypto.spec.SecretKeySpec

class AES {
    // размер ключа для алгоритма шифрования
    private val keySize = 256

    // количество итераций для генерирования ключа
    private val keyGenerateIterations = Short.MAX_VALUE.toInt()

    // размер вектора инициализации для OFB режима
    private val IVSize = 16

    // пароль, необходимый для случайности генерирования ключа шифрования
    private val password = "password"

    // вектор инициализации для OFB режима
    val IV: ByteArray = ByteArray(IVSize)

    init {
        SecureRandom().nextBytes(IV)
    }

    /**
     * Генерирование ключа для алгоритма шифрования.
     */
    fun nextKey(): Key {
        // создаём случайную соль
        val salt = ByteArray(keySize)
        SecureRandom().nextBytes(salt)

        // ключ будет генерироваться по алгоритму PBKDF2 со случайной функцией SHA512
        val factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512")
        val specification = PBEKeySpec(password.toCharArray(), salt, keyGenerateIterations, keySize)

        return SecretKeySpec(factory.generateSecret(specification).encoded, "AES")
    }

    /**
     * Шифрование блока данных алгоритмом AES-256 с типом OFB.
     */
    fun encrypt(input: ByteArray, key: Key): ByteArray {
        val cipher = Cipher.getInstance("AES/OFB/NoPadding")
        cipher.init(Cipher.ENCRYPT_MODE, key, IvParameterSpec(IV))

        return cipher.doFinal(input)
    }

    /**
     * Расшифровка блока данных алгоритмом AES-256 с типом OFB.
     */
    fun decrypt(input: ByteArray, key: Key): ByteArray {
        val cipher = Cipher.getInstance("AES/OFB/NoPadding")
        cipher.init(Cipher.DECRYPT_MODE, key, IvParameterSpec(IV))

        return cipher.doFinal(input)
    }
}

fun printByteArray(array: ByteArray) {
    array.forEach { print(String.format("%02x ", it)) }
    println()
}

fun main(args: Array<String>) {
    // кодировка, в которой представлены строки шифрования
    val utf8Charset = charset("UTF-8")

    println("Enter message to encrypt: ")
    val message = readLine().orEmpty()
    val input = message.toByteArray(utf8Charset)

    println("Message is: $message")
    print("Message bytes are: ")
    printByteArray(input)
    println()

    val aes = AES()
    val key = aes.nextKey()

    println("AES-256 OFB initialization")
    print("Initialize Vector is: ")
    printByteArray(aes.IV)

    print("Key is: ")
    printByteArray(key.encoded)
    println()

    val encryptedMessageBytes = aes.encrypt(input, key)
    print("Encrypted message bytes are: ")
    printByteArray(encryptedMessageBytes)

    val decryptedMessageBytes = aes.decrypt(encryptedMessageBytes, key)
    print("Decrypted message bytes are: ")
    printByteArray(decryptedMessageBytes)

    val decryptedMessage = String(decryptedMessageBytes, utf8Charset)
    println("Decrypted message is: $decryptedMessage")
}
