import 'package:flutter/material.dart';

class FolderSelectionDialog extends StatefulWidget {
  final List<String> existingFolders;
  final Function(String) onFolderSelected;

  const FolderSelectionDialog({
    super.key,
    required this.existingFolders,
    required this.onFolderSelected,
  });

  @override
  State<FolderSelectionDialog> createState() => _FolderSelectionDialogState();
}

class _FolderSelectionDialogState extends State<FolderSelectionDialog> {
  final _newFolderController = TextEditingController();
  bool _isCreatingNew = false;

  @override
  void dispose() {
    _newFolderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Folder',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (!_isCreatingNew) ...[
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.folder),
                        title: const Text('Default'),
                        onTap: () {
                          widget.onFolderSelected('Default');
                          Navigator.pop(context);
                        },
                      ),
                      ...widget.existingFolders
                          .where((f) => f != 'Default')
                          .map((folder) => ListTile(
                                leading: const Icon(Icons.folder_open),
                                title: Text(folder),
                                onTap: () {
                                  widget.onFolderSelected(folder);
                                  Navigator.pop(context);
                                },
                              )),
                    ],
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.create_new_folder),
                title: const Text('Create New Folder'),
                onTap: () {
                  setState(() {
                    _isCreatingNew = true;
                  });
                },
              ),
            ] else ...[
              TextField(
                controller: _newFolderController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Folder Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isCreatingNew = false;
                      });
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      final name = _newFolderController.text.trim();
                      if (name.isNotEmpty) {
                        widget.onFolderSelected(name);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Create'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
