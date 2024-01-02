package com.example.blueprinting

import android.app.AlertDialog
import android.content.DialogInterface
import android.os.Bundle
import androidx.fragment.app.DialogFragment
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.blueprinting"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        call, result ->
            if (call.method == "showDialog") {
                showCustomDialog()
                result.success("Dialog shown")
            } else if(call.method == "showToast"){
                showToast();
            } else {
                result.notImplemented()
            }
        }
    }

     private fun showCustomDialog() {
        // Create an AlertDialog Builder
        val builder = AlertDialog.Builder(this)

        // Set the dialog title and message
        builder.setTitle("Dialog Title")
        builder.setMessage("This is a custom dialog in Android")

        // Add positive button (OK)
        builder.setPositiveButton("OK") { dialog, _ ->
            // User clicked OK button
            dialog.dismiss()
        }

        // Add negative button (Cancel)
        builder.setNegativeButton("Cancel") { dialog, _ ->
            // User clicked Cancel button
            dialog.dismiss()
        }

        // Create and show the AlertDialog
        val dialog: AlertDialog = builder.create()
        dialog.show()
    }

     private fun showToast() {
        println("showing a toast!")
        // Create and show a short-duration toast message
        Toast.makeText(this, "This is a toast message", Toast.LENGTH_SHORT).show()
    }
}
