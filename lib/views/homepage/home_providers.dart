import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 0);
final doubtProvider = StateProvider<String>((ref) => '');
