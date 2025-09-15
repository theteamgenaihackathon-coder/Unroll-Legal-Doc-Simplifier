import 'package:flutter/material.dart';

const Color ourRed = Color(0xFFC10547);

// IconButton accountButton() {
//   // return IconButton(
//   //   onPressed: () {},
//   //   icon: Icon(Icons.account_circle_rounded, color: ourRed, size: 50),
//   // );

//   return IconButton(
//     onPressed: () {},
//     icon: Icon(Icons.account_circle_rounded, color: ourRed, size: 50),
//     visualDensity: VisualDensity(vertical: -2),
//     highlightColor: Colors.transparent,
//   );
// }

// PopupMenuButton accountButton() {
//   return PopupMenuButton(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     offset: Offset(0, 60),
//     padding: EdgeInsets.only(bottom: 10, right: 20),
//     icon: Icon(Icons.account_circle_rounded, color: ourRed, size: 50),
//     itemBuilder: (BuildContext context) => [
//       PopupMenuItem(
//         value: 'history',
//         child: Center(child: Text('History')),
//       ),
//       PopupMenuDivider(),
//       PopupMenuItem(
//         value: 'saved',
//         child: Center(child: Text('Saved')),
//       ),
//       PopupMenuDivider(),
//       PopupMenuItem(
//         value: 'settings',
//         child: Center(child: Text('Settings')),
//         onTap: () {},
//       ),
//       PopupMenuDivider(),
//       PopupMenuItem(
//         value: 'logout',
//         child: Center(child: Text('Logout')),
//       ),
//     ],
//   );
// }

IconButton uploadButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.arrow_circle_up_rounded, size: 80, color: ourRed),
  );
}

IconButton cameraButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.camera_alt_rounded, color: ourRed, size: 80),
  );
}
