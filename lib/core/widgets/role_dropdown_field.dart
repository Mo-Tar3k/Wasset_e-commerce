import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RoleDropdownField extends StatefulWidget {
  const RoleDropdownField({
    super.key,
    required this.labelText,
    this.onChanged,
    this.onSaved,
  });

  final String labelText;
  final ValueChanged<String?>? onChanged;
  final void Function(String?)? onSaved;

  @override
  _RoleDropdownFieldState createState() => _RoleDropdownFieldState();
}

class _RoleDropdownFieldState extends State<RoleDropdownField> {
  String? _selectedRole = 'Customer';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.gray(context),
        ),
        value: _selectedRole,
        items: const [
          DropdownMenuItem(value: 'Customer', child: Text('Customer')),
          DropdownMenuItem(value: 'Admin', child: Text('Admin')),
          DropdownMenuItem(
            value: 'ServiceProvider',
            child: Text('ServiceProvider'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _selectedRole = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );
  }
}
