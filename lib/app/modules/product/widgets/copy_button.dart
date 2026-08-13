import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyContainer extends StatefulWidget {
  final String text;

  const CopyContainer({
    super.key,
    required this.text,
  });

  @override
  State<CopyContainer> createState() => _CopyContainerState();
}

class _CopyContainerState extends State<CopyContainer> {
  bool copied = false;

  Future<void> copyText() async {
    await Clipboard.setData(
      ClipboardData(text: widget.text),
    );

    setState(() {
      copied = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        copied = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: copyText,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: copied
              ? Colors.green.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: copied
                ? Colors.green.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                copied
                    ? Icons.check_rounded
                    : Icons.copy_rounded,
                key: ValueKey(copied),
                size: 18,
                color: copied
                    ? Colors.green
                    : Colors.white,
              ),
            ),

            const SizedBox(width: 8),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                copied ? 'Copied!' : widget.text,
                key: ValueKey(copied),
                style: TextStyle(
                  color: copied
                      ? Colors.green
                      : Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}