// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class Environment(val raw: Int) {
  TEST(0),
  EUROPE(1),
  UNITEDSTATES(2),
  AUSTRALIA(3),
  INDIA(4),
  APSE(5);

  companion object {
    fun ofRaw(raw: Int): Environment? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class Locale(val raw: Int) {
  CANADA(0),
  CANADAFRENCH(1),
  CHINA(2),
  CHINESE(3),
  ENGLISH(4),
  FRANCE(5),
  FRENCH(6),
  GERMAN(7),
  GERMANY(8),
  ITALIAN(9),
  ITALY(10),
  JAPAN(11),
  JAPANESE(12),
  KOREA(13),
  KOREAN(14),
  PRC(15),
  ROOT(16),
  SIMPLIFIEDCHINESE(17),
  TAIWAN(18),
  TRADITIONALCHINESE(19),
  UK(20),
  US(21);

  companion object {
    fun ofRaw(raw: Int): Locale? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class SessionDropInResultEnum(val raw: Int) {
  CANCELLEDBYUSER(0),
  ERROR(1),
  FINISHED(2);

  companion object {
    fun ofRaw(raw: Int): SessionDropInResultEnum? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class SessionModel (
  val id: String,
  val sessionData: String

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): SessionModel {
      val id = list[0] as String
      val sessionData = list[1] as String
      return SessionModel(id, sessionData)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      id,
      sessionData,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class Amount (
  val currency: String? = null,
  val value: Long

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): Amount {
      val currency = list[0] as String?
      val value = list[1].let { if (it is Int) it.toLong() else it as Long }
      return Amount(currency, value)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      currency,
      value,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class DropInConfigurationModel (
  val shopperLocale: Locale? = null,
  val environment: Environment,
  val clientKey: String,
  val amount: Amount,
  val isAnalyticsEnabled: Boolean? = null,
  val showPreselectedStoredPaymentMethod: Boolean? = null,
  val skipListWhenSinglePaymentMethod: Boolean? = null,
  val isRemovingStoredPaymentMethodsEnabled: Boolean? = null,
  val additionalDataForDropInService: String? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): DropInConfigurationModel {
      val shopperLocale: Locale? = (list[0] as Int?)?.let {
        Locale.ofRaw(it)
      }
      val environment = Environment.ofRaw(list[1] as Int)!!
      val clientKey = list[2] as String
      val amount = Amount.fromList(list[3] as List<Any?>)
      val isAnalyticsEnabled = list[4] as Boolean?
      val showPreselectedStoredPaymentMethod = list[5] as Boolean?
      val skipListWhenSinglePaymentMethod = list[6] as Boolean?
      val isRemovingStoredPaymentMethodsEnabled = list[7] as Boolean?
      val additionalDataForDropInService = list[8] as String?
      return DropInConfigurationModel(shopperLocale, environment, clientKey, amount, isAnalyticsEnabled, showPreselectedStoredPaymentMethod, skipListWhenSinglePaymentMethod, isRemovingStoredPaymentMethodsEnabled, additionalDataForDropInService)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      shopperLocale?.raw,
      environment.raw,
      clientKey,
      amount.toList(),
      isAnalyticsEnabled,
      showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod,
      isRemovingStoredPaymentMethodsEnabled,
      additionalDataForDropInService,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class SessionPaymentResultModel (
  val sessionId: String? = null,
  val sessionResult: String? = null,
  val sessionData: String? = null,
  val resultCode: String? = null,
  val order: OrderResponseModel? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): SessionPaymentResultModel {
      val sessionId = list[0] as String?
      val sessionResult = list[1] as String?
      val sessionData = list[2] as String?
      val resultCode = list[3] as String?
      val order: OrderResponseModel? = (list[4] as List<Any?>?)?.let {
        OrderResponseModel.fromList(it)
      }
      return SessionPaymentResultModel(sessionId, sessionResult, sessionData, resultCode, order)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      sessionId,
      sessionResult,
      sessionData,
      resultCode,
      order?.toList(),
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class OrderResponseModel (
  val pspReference: String,
  val orderData: String,
  val amount: Amount? = null,
  val remainingAmount: Amount? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): OrderResponseModel {
      val pspReference = list[0] as String
      val orderData = list[1] as String
      val amount: Amount? = (list[2] as List<Any?>?)?.let {
        Amount.fromList(it)
      }
      val remainingAmount: Amount? = (list[3] as List<Any?>?)?.let {
        Amount.fromList(it)
      }
      return OrderResponseModel(pspReference, orderData, amount, remainingAmount)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      pspReference,
      orderData,
      amount?.toList(),
      remainingAmount?.toList(),
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class SessionDropInResultModel (
  val sessionDropInResult: SessionDropInResultEnum,
  val reason: String? = null,
  val result: SessionPaymentResultModel? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): SessionDropInResultModel {
      val sessionDropInResult = SessionDropInResultEnum.ofRaw(list[0] as Int)!!
      val reason = list[1] as String?
      val result: SessionPaymentResultModel? = (list[2] as List<Any?>?)?.let {
        SessionPaymentResultModel.fromList(it)
      }
      return SessionDropInResultModel(sessionDropInResult, reason, result)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      sessionDropInResult.raw,
      reason,
      result?.toList(),
    )
  }
}

@Suppress("UNCHECKED_CAST")
private object CheckoutPlatformInterfaceCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Amount.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          DropInConfigurationModel.fromList(it)
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          SessionModel.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is Amount -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is DropInConfigurationModel -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      is SessionModel -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface CheckoutPlatformInterface {
  fun getPlatformVersion(callback: (Result<String>) -> Unit)
  fun startPayment(sessionModel: SessionModel, dropInConfiguration: DropInConfigurationModel, callback: (Result<Unit>) -> Unit)

  companion object {
    /** The codec used by CheckoutPlatformInterface. */
    val codec: MessageCodec<Any?> by lazy {
      CheckoutPlatformInterfaceCodec
    }
    /** Sets up an instance of `CheckoutPlatformInterface` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: CheckoutPlatformInterface?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.getPlatformVersion", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.getPlatformVersion() { result: Result<String> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startPayment", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val sessionModelArg = args[0] as SessionModel
            val dropInConfigurationArg = args[1] as DropInConfigurationModel
            api.startPayment(sessionModelArg, dropInConfigurationArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
@Suppress("UNCHECKED_CAST")
private object CheckoutResultFlutterInterfaceCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Amount.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          OrderResponseModel.fromList(it)
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          SessionDropInResultModel.fromList(it)
        }
      }
      131.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          SessionPaymentResultModel.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is Amount -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is OrderResponseModel -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      is SessionDropInResultModel -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }
      is SessionPaymentResultModel -> {
        stream.write(131)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class CheckoutResultFlutterInterface(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by CheckoutResultFlutterInterface. */
    val codec: MessageCodec<Any?> by lazy {
      CheckoutResultFlutterInterfaceCodec
    }
  }
  fun onSessionDropInResult(sessionDropInResultArg: SessionDropInResultModel, callback: () -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutResultFlutterInterface.onSessionDropInResult", codec)
    channel.send(listOf(sessionDropInResultArg)) {
      callback()
    }
  }
}
