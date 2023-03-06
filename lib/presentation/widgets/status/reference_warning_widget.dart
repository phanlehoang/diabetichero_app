import 'package:flutter/material.dart';

class ReferenceWarningWidget extends StatelessWidget {
  const ReferenceWarningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.warning,
              color: Colors.black,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Các chỉ dẫn này chỉ mang tính tham khảo.',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
