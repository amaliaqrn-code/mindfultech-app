import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/timer_theme.dart';

/// Time Picker Bottom Sheet - Allows user to change timer duration
class TimePickerBottomSheet extends StatefulWidget {
  final int currentMinutes;
  final Function(int) onSave;

  const TimePickerBottomSheet({
    super.key,
    required this.currentMinutes,
    required this.onSave,
  });

  /// Show the bottom sheet
  static Future<void> show(
    BuildContext context, {
    required int currentMinutes,
    required Function(int) onSave,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TimePickerBottomSheet(
        currentMinutes: currentMinutes,
        onSave: onSave,
      ),
    );
  }

  @override
  State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  late TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.currentMinutes.toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateAndSave() {
    final text = _controller.text.trim();
    final minutes = int.tryParse(text);

    if (minutes == null) {
      setState(() {
        _errorText = 'Masukkan angka yang valid';
      });
      return;
    }

    if (minutes < 1) {
      setState(() {
        _errorText = 'Minimal 1 menit';
      });
      return;
    }

    if (minutes > 120) {
      setState(() {
        _errorText = 'Maksimal 120 menit';
      });
      return;
    }

    widget.onSave(minutes);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: TimerTheme.cardWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            const Text(
              'Ubah Durasi Timer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: TimerTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan durasi fokus dalam menit',
              style: TextStyle(
                fontSize: 14,
                color: TimerTheme.textGrey,
              ),
            ),
            const SizedBox(height: 24),

            // Input field
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: TimerTheme.textDark,
              ),
              decoration: InputDecoration(
                hintText: '25',
                hintStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade300,
                ),
                suffixText: 'menit',
                suffixStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: TimerTheme.textGrey,
                ),
                errorText: _errorText,
                errorStyle: const TextStyle(
                  fontSize: 12,
                  color: TimerTheme.warningRed,
                ),
                filled: true,
                fillColor: TimerTheme.primaryBluePale,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: TimerTheme.primaryBlue,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
              ),
              onChanged: (value) {
                if (_errorText != null) {
                  setState(() {
                    _errorText = null;
                  });
                }
              },
            ),
            const SizedBox(height: 24),

            // Quick select buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _QuickSelectButton(
                  minutes: 15,
                  onTap: () {
                    _controller.text = '15';
                    setState(() {
                      _errorText = null;
                    });
                  },
                ),
                _QuickSelectButton(
                  minutes: 25,
                  onTap: () {
                    _controller.text = '25';
                    setState(() {
                      _errorText = null;
                    });
                  },
                ),
                _QuickSelectButton(
                  minutes: 45,
                  onTap: () {
                    _controller.text = '45';
                    setState(() {
                      _errorText = null;
                    });
                  },
                ),
                _QuickSelectButton(
                  minutes: 60,
                  onTap: () {
                    _controller.text = '60';
                    setState(() {
                      _errorText = null;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Save button
            GestureDetector(
              onTap: _validateAndSave,
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: TimerTheme.actionButtonGradient,
                ),
                child: const Center(
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _QuickSelectButton extends StatelessWidget {
  final int minutes;
  final VoidCallback onTap;

  const _QuickSelectButton({
    required this.minutes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: TimerTheme.primaryBluePale,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$minutes mnt',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: TimerTheme.primaryBlue,
          ),
        ),
      ),
    );
  }
}