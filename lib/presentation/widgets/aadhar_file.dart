import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:magical_walls/core/constants/app_colors.dart';

import '../../core/constants/app_text.dart';

class AadhaarUploadWidget extends StatefulWidget {
  final Function(String?) onFileSelected;

  const AadhaarUploadWidget({super.key, required this.onFileSelected});

  @override
  State<AadhaarUploadWidget> createState() => _AadhaarUploadWidgetState();
}

class _AadhaarUploadWidgetState extends State<AadhaarUploadWidget> {
  String? selectedFile;

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.single.name;
        widget.onFileSelected(selectedFile);
      });
    }
  }

  void _removeFile() {
    setState(() {
      selectedFile = null;
      widget.onFileSelected(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectedFile == null ? _pickPdf : null,
      child: Stack(
        children: [
          Container(
            height: 44,
            width: double.infinity,
            decoration: BoxDecoration(
              color: CommonColors.fileUpload,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent, width: 1.2),
            ),
            child: Center(
              child: selectedFile == null
                  ? Row(
                children: [
                  const SizedBox(width: 12),
                  Image.asset('assets/images/pdf.png', width: 20),
                  const SizedBox(width: 12),
                  Text(
                    "Click to Upload Aadhaar (PDF only)",
                    style: CommonTextStyles.regular14,
                  ),
                ],
              )
                  : Row(
                children: [
                  const SizedBox(width: 12),
                  Image.asset('assets/images/pdf.png', width: 20),
                  const SizedBox(width: 12),
                  Text(
                    selectedFile!,
                    textAlign: TextAlign.center,
                    style: CommonTextStyles.regular14,
                  ),
                ],
              ),
            ),
          ),
          if (selectedFile != null)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: _removeFile,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black26,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}