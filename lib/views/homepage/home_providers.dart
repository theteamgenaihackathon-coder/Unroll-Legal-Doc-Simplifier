import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 0);
final isChatOpenProvider = StateProvider<bool>((ref) => false);
