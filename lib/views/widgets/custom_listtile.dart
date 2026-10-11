import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';

class CustomListTileData {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final String? trailingText;
  final Color? trailingColor;

  CustomListTileData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.trailingText,
    this.trailingColor,
  });
}

class CustomListTile extends StatelessWidget {
  final CustomListTileData data;

  const CustomListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: data.iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(data.icon, color: data.iconColor, size: 20),
      ),
      title: Text(
        data.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        data.subtitle,
        style: TextStyle(color: ColorConstants.onSecondaryColor, fontSize: 12),
      ),
      trailing:
          data.trailing ?? (data.trailingText != null ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.trailingText!,
                      style: TextStyle(
                        color: data.trailingColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right,
                      color: ColorConstants.onSecondaryColor,
                    ),
                  ],
                ) : Icon(
                  Icons.chevron_right,
                  color: ColorConstants.onSecondaryColor,
                )) ,
    );
  }
}
