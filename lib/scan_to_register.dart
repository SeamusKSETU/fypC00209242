//used for registering registrars and counters, depending on the URI passed in
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:unique_device_identifier/unique_device_identifier.dart';

class ScanRegister extends StatefulWidget {
	//const ScanRegister({super.key});
  const ScanRegister({super.key, required this.apiEndpoint});

	final Uri apiEndpoint;

	@override
	State<ScanRegister> createState() => _ScanRegisterState();
}

class _ScanRegisterState extends State<ScanRegister> {
	final MobileScannerController _controller = MobileScannerController(
		detectionSpeed: DetectionSpeed.noDuplicates,
		formats: const [BarcodeFormat.qrCode],
	);

	bool _isSending = false;
	String _message = 'Align the registration QR code inside the frame.';
	bool? _wasSuccessful;

	@override
	void dispose() {
		_controller.dispose();
		super.dispose();
	}

	Future<void> _handleDetection(BarcodeCapture capture) async {
		if (_isSending) return;
    String deviceId;
		final rawValue = capture.barcodes
				.map((barcode) => barcode.rawValue)
				.whereType<String>()
				.firstOrNull;
		if (rawValue == null) return;

		setState(() {
			_isSending = true;
			_wasSuccessful = null;
			_message = 'Validating registration QR code...';
		});
		await _controller.stop();

		try {
			final decoded = jsonDecode(rawValue);
			if (decoded is! Map<String, dynamic> ||
					decoded['action'] != 'register' ||
					['email', 'code', 'password', 'deviceID'].any(
						(key) => decoded[key] is! String || (decoded[key] as String).isEmpty,
					)) {
				throw const FormatException('QR code is not valid registration data.');
			}
			if (mounted) {
				setState(() => _message = 'Sending registration ...');
			}
      deviceId = await UniqueDeviceIdentifier.getUniqueIdentifier() ?? 'Unknown Device ID';
      decoded.addAll({'regID':deviceId});
			final response = await http
					.post(
						widget.apiEndpoint,
						headers: const {'Content-Type': 'application/json'},
						body: jsonEncode(decoded),
					)
					.timeout(const Duration(seconds: 20));

			if (response.statusCode < 200 || response.statusCode >= 300) {
				throw HttpException('The API returned HTTP ${response.statusCode}.');
			}

			if (!mounted) return;
			setState(() {
				_isSending = false;
				_wasSuccessful = true;
				_message = 'Registration submitted successfully.';
			});
		} on FormatException catch (error) {
			await _showScanError(error.message);
		} on TimeoutException {
			await _showScanError('The API request timed out. Scan to try again.');
		} on http.ClientException {
			await _showScanError('Could not reach the API. Check the connection and retry.');
		} on HttpException catch (error) {
			await _showScanError(error.message);
		} catch (_) {
			await _showScanError('Registration could not be submitted. Scan to retry.');
		}
	}

	Future<void> _showScanError(String message) async {
		if (!mounted) return;
		setState(() {
			_isSending = false;
			_wasSuccessful = false;
			_message = message;
		});
		await _controller.start();
	}

	@override
	Widget build(BuildContext context) {
		final colorScheme = Theme.of(context).colorScheme;
		final statusColor = _wasSuccessful == null
				? colorScheme.onSurfaceVariant
				: _wasSuccessful!
						? Colors.green.shade700
						: colorScheme.error;

		return Scaffold(
			appBar: AppBar(
				title: const Text('Registration QR Scan'),
				backgroundColor: const Color.fromARGB(255, 0, 77, 68),
				foregroundColor: Colors.white,
				centerTitle: true,
			),
			body: SafeArea(
				child: Center(
					child: ConstrainedBox(
						constraints: const BoxConstraints(maxWidth: 520),
						child: Padding(
							padding: const EdgeInsets.all(20),
							child: Column(
								children: [
									Expanded(
										child: ClipRRect(
											borderRadius: BorderRadius.circular(12),
											child: Stack(
												fit: StackFit.expand,
												children: [
													MobileScanner(
														controller: _controller,
														onDetect: _handleDetection,
													),
													IgnorePointer(
														child: Center(
															child: Container(
																width: 230,
																height: 230,
																decoration: BoxDecoration(
																	border: Border.all(
																		color: Colors.white,
																		width: 3,
																	),
																	borderRadius: BorderRadius.circular(16),
																),
															),
														),
													),
													if (_isSending)
														const ColoredBox(
															color: Color(0x66000000),
															child: Center(child: CircularProgressIndicator()),
														),
												],
											),
										),
									),
									const SizedBox(height: 20),
									Row(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											Icon(
												_wasSuccessful == true
														? Icons.check_circle_outline
														: _wasSuccessful == false
																? Icons.error_outline
																: Icons.qr_code_scanner,
												color: statusColor,
											),
											const SizedBox(width: 12),
											Expanded(
												child: Text(
													_message,
													style: TextStyle(color: statusColor, fontSize: 16),
												),
											),
										],
									),
									if (_wasSuccessful == true) ...[
										const SizedBox(height: 16),
										SizedBox(
											width: double.infinity,
											child: OutlinedButton.icon(
												onPressed: () async {
													setState(() {
														_wasSuccessful = null;
														_message =
																'Align the registration QR code inside the frame.';
													});
													await _controller.start();
												},
												icon: const Icon(Icons.qr_code_scanner),
												label: const Text('Scan another code'),
											),
										),
									],
								],
							),
						),
					),
				),
			),
		);
	}
}
