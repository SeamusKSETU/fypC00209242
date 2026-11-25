import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:get_mac_address/get_mac_address.dart';
//import 'package:get_mac_address/get_mac_address_platform_interface.dart';
import 'package:unique_device_identifier/unique_device_identifier.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  String _deviceID = 'Press the Register button to get Device ID';
  String? _qrData;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<String> initDeviceID() async {
    String deviceId;
    //final getMacAddressPlugin = GetMacAddress();
    try {
      //  macAddress = await getMacAddressPlugin.getMacAddress() ?? 'Unknown Device ID';
      deviceId =
          await UniqueDeviceIdentifier.getUniqueIdentifier() ??
          'Unknown Device ID';
    } on PlatformException {
      deviceId = 'Error getting the Device ID.';
    }
    if (mounted) {
      setState(() {
        _deviceID = deviceId;
      });
    }
    return deviceId;
  }

  Future<void> _submit() async {
    final deviceId = await initDeviceID();
    if (!_formKey.currentState!.validate()) {
      setState(() => _qrData = null);
      return;
    }
    if (!mounted) return;
    setState(() {
      _qrData = jsonEncode({
        'email': _emailController.text.trim(),
        'code': _codeController.text.trim(),
        'password': _passwordController.text,
        'deviceID': deviceId,
        'action': 'register'
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration details valid. Have the QR code scanned.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color.fromARGB(255, 0, 77, 68),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_qrData != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 16),
                        child: Center(
                          child: QrImageView(data: _qrData!, size: 220),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your email, verification code, and password.',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      _deviceID,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 28),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'your@email.com',
                        prefixIcon: Icon(Icons.email),
                        errorStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                      ),
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (email.isEmpty) return 'Enter your email';
                        if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                            .hasMatch(email)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: const InputDecoration(
                        labelText: '6-digit code',
                        prefixIcon: Icon(Icons.verified_outlined),
                        errorStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length != 6) {
                          return 'Enter your 6-digit verification code';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.newPassword],
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        errorStyle: const TextStyle(fontSize: 18),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                        suffixIcon: IconButton(
                          tooltip: _passwordVisible
                              ? 'Hide password'
                              : 'Show password',
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => setState(() {
                            _passwordVisible = !_passwordVisible;
                          }),
                        ),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(// Validation for required field.
                          errorText: 'Please enter Password',
                        ),
                        MinLengthValidator(8,// Minimum length validation.
                          errorText: 'Password must be at least 8 characters',
                        ),
                        PatternValidator(r'(?=.*?[#!@$%^&*-])',// Special character validation.
                          errorText: 'One special character minimum required',
                        ),
                      ]).call,
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.all(28),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255,0,102,88),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
