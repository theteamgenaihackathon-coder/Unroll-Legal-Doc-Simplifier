import 'package:flutter/material.dart';

class AccountButton extends StatefulWidget {
  const AccountButton({super.key});

  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Transparent barrier to dismiss dropdown when tapping outside
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _toggleDropdown,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height,
            width: 220,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(-100, 0),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildMenuItem(Icons.account_circle_rounded, 'profile'),
                    _buildMenuItem(Icons.history, 'History'),
                    _buildMenuItem(Icons.bookmark, 'Saved'),
                    _buildMenuItem(Icons.settings, 'Settings'),
                    _buildMenuItem(Icons.logout, 'Logout'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink, size: 50),
      title: Text(label),
      onTap: () {
        print('$label tapped');
        _toggleDropdown(); // Close dropdown after selection
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: IconButton(
        icon: const Icon(
          Icons.account_circle_rounded,
          size: 50,
          color: Colors.pink,
        ),
        onPressed: _toggleDropdown,
      ),
    );
  }
}
