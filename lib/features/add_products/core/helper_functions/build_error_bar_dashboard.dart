import 'package:flutter/material.dart';

void buildBarDashboard(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
