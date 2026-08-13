package com.example.qr_code_generator_reader

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "qr_vault/download"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "saveQrToDownloads" -> {

                    val fileName = call.argument<String>("fileName")
                    val bytes = call.argument<ByteArray>("bytes")

                    if (fileName == null || bytes == null) {
                        result.error(
                            "INVALID_DATA",
                            "Filename or QR bytes are missing",
                            null
                        )
                        return@setMethodCallHandler
                    }

                    try {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {

                            val resolver = contentResolver

                            val values = ContentValues().apply {
                                put(
                                    MediaStore.Downloads.DISPLAY_NAME,
                                    fileName
                                )

                                put(
                                    MediaStore.Downloads.MIME_TYPE,
                                    "image/png"
                                )

                                put(
                                    MediaStore.Downloads.RELATIVE_PATH,
                                    Environment.DIRECTORY_DOWNLOADS
                                )

                                put(
                                    MediaStore.Downloads.IS_PENDING,
                                    1
                                )
                            }

                            val uri = resolver.insert(
                                MediaStore.Downloads.EXTERNAL_CONTENT_URI,
                                values
                            )

                            if (uri == null) {
                                result.error(
                                    "CREATE_FAILED",
                                    "Could not create download file",
                                    null
                                )
                                return@setMethodCallHandler
                            }

                            resolver.openOutputStream(uri)?.use { outputStream ->
                                outputStream.write(bytes)
                                outputStream.flush()
                            }

                            values.clear()

                            values.put(
                                MediaStore.Downloads.IS_PENDING,
                                0
                            )

                            resolver.update(
                                uri,
                                values,
                                null,
                                null
                            )

                            result.success(true)

                        } else {
                            result.error(
                                "UNSUPPORTED_ANDROID",
                                "This implementation requires Android 10 or higher.",
                                null
                            )
                        }

                    } catch (e: Exception) {

                        result.error(
                            "SAVE_FAILED",
                            e.message,
                            null
                        )
                    }
                }

                "saveQrToGallery" -> {

                    val fileName = call.argument<String>("fileName")
                    val bytes = call.argument<ByteArray>("bytes")

                    if (fileName == null || bytes == null) {
                        result.error(
                            "INVALID_DATA",
                            "Filename or QR bytes are missing",
                            null
                        )
                        return@setMethodCallHandler
                    }

                    try {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {

                            val resolver = contentResolver

                            val values = ContentValues().apply {
                                put(
                                    MediaStore.Images.Media.DISPLAY_NAME,
                                    fileName
                                )

                                put(
                                    MediaStore.Images.Media.MIME_TYPE,
                                    "image/png"
                                )

                                put(
                                    MediaStore.Images.Media.RELATIVE_PATH,
                                    Environment.DIRECTORY_PICTURES + "/QR Vault"
                                )

                                put(
                                    MediaStore.Images.Media.IS_PENDING,
                                    1
                                )
                            }

                            val uri = resolver.insert(
                                MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                                values
                            )

                            if (uri == null) {
                                result.error(
                                    "CREATE_FAILED",
                    "Could not create gallery file",
                                    null
                                )
                                return@setMethodCallHandler
                            }

                            resolver.openOutputStream(uri)?.use { outputStream ->
                                outputStream.write(bytes)
                                outputStream.flush()
                            }
                
                            values.clear()
                
                            values.put(
                                MediaStore.Images.Media.IS_PENDING,
                                0
                            )
                
                            resolver.update(
                                uri,
                                values,
                                null,
                                null
                            )

                            result.success(true)

                        } else {
                            result.error(
                                "UNSUPPORTED_ANDROID",
                                "This implementation requires Android 10 or higher.",
                                null
                            )
                        }

                    } catch (e: Exception) {
                        result.error(
                            "SAVE_FAILED",
                            e.message,
                            null
                        )
                    }
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

}