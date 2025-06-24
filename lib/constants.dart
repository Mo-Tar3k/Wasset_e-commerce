import 'package:flutter/material.dart';

const KHorizontalPadding = 16.0;
const KTopPadding = 16.0;
const kIsOnBoardingViewSeen = 'isOnBoardingViewSeen';
const kUserData = 'userData';
const kSupabaseUrl = 'https://wszqzhjvldbcxcfebphs.supabase.co';
const kSupabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndzenF6aGp2bGRiY3hjZmVicGhzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MzY3MDE4NCwiZXhwIjoyMDU5MjQ2MTg0fQ.bYqUFNc8euz5XJ-Sk608VplRn2U0mt3OO1fZlDs_a38';
const kSupabaseBucket = 'wasset_images';
const kBaseUrl =
    'http://waseet.runasp.net/api/'; // Replace with your actual base URL
const kStripe =
    'pk_test_51RFk3eLZYn6WqnTpq6DDHzTASPcudgYCIFU3Xljm1Q8sjTCvBeavPM7nBjMBmLktqD6fHavN4oCqiYggBzLqmrXd00EoBUIYVH';
bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}
