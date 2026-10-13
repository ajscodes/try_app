import 'package:expense_tracker_app/utils/color_constants.dart';
import 'package:expense_tracker_app/views/widgets/custom_card.dart';
import 'package:expense_tracker_app/views/widgets/custom_listtile.dart';
import 'package:expense_tracker_app/views/widgets/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/expense_provider.dart';
import '../../utils/string_constants.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: ColorConstants.secondaryColor,
          appBar: AppBar(
            title: Text(
              SettingConstants.settingScreenAppBarTitle,
              style: TextStyle(
                color: ColorConstants.onPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: ColorConstants.surfaceColor,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(SettingConstants.settingScreenAppearance),
                CustomCard(
                  data: CustomCardData(
                    items: [
                      CustomListTile(
                        data: CustomListTileData(
                          icon: Icons.light_mode,
                          iconColor: ColorConstants.primaryColor,
                          title: SettingConstants.settingScreenDarkMode,
                          subtitle:
                              SettingConstants.settingScreenDarkModeSubText,
                          trailing: Switch(
                            inactiveThumbColor: ColorConstants.onSecondaryColor,
                            value: provider.lightTheme,
                            onChanged: (bool newValue) {
                              provider.switchTheme(newValue);
                            },
                            activeThumbColor: ColorConstants.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12),
                _buildSectionHeader(SettingConstants.settingScreenGeneral),
                CustomCard(
                  data: CustomCardData(
                    items: [
                      CustomListTile(
                        data: CustomListTileData(
                          icon: Icons.attach_money,
                          iconColor: ColorConstants.settingScreenCurrencyIcon,
                          title: SettingConstants.settingScreenCurrency,
                          subtitle:
                              SettingConstants.settingScreenCurrencySubText,
                          trailingText:
                              SettingConstants.settingScreenCurrencyOption,
                          trailingColor: ColorConstants.primaryColor,
                        ),
                      ),
                      const Divider(height: 1),
                      CustomListTile(
                        data: CustomListTileData(
                          icon: Icons.calendar_today,
                          iconColor: ColorConstants.linkColor,
                          title: SettingConstants.settingScreenFirstDayOfWeek,
                          subtitle: SettingConstants
                              .settingScreenFirstDayOfWeekSubText,
                          trailingText: SettingConstants.settingScreenDay,
                          trailingColor: ColorConstants.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                _buildSectionHeader(SettingConstants.settingScreenData),
                CustomCard(
                  data: CustomCardData(
                    items: [
                      CustomListTile(
                        data: CustomListTileData(
                          icon: Icons.delete_outline,
                          iconColor: ColorConstants.settingScreenOrangeIcon,
                          title: SettingConstants.settingScreenClearTransaction,
                          subtitle: SettingConstants
                              .settingScreenClearTransactionSubText,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: provider.transactions.isEmpty
                                    ? null
                                    : () => _showClearAllDialog(context),
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: provider.transactions.isEmpty ? ColorConstants.greyDisable    : ColorConstants
                                      .settingScreenClearAllButton,
                                ),
                                label: Text(
                                  SettingConstants
                                      .settingScreenClearTransaction,
                                  style: TextStyle(
                                    color: provider.transactions.isEmpty ? ColorConstants.greyDisable : ColorConstants
                                        .settingScreenClearAllButton,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  disabledBackgroundColor: Colors.grey.shade200,
                                  side: BorderSide(
                                    color: provider.transactions.isEmpty ? ColorConstants.greyDisable : ColorConstants
                                        .settingScreenClearAllButtonBorder,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color:
                                    ColorConstants.settingScreenClearAllWarning,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: ColorConstants
                                        .settingScreenClearAllButton,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          SettingConstants
                                              .settingScreenClearTransactionWarningTitle,
                                          style: TextStyle(
                                            color: ColorConstants
                                                .settingScreenClearAllButton,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          SettingConstants
                                              .settingScreenClearTransactionWarningSubText,
                                          style: TextStyle(
                                            color: ColorConstants
                                                .settingScreenClearAllSubText,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                _buildSectionHeader(SettingConstants.settingScreenAbout),
                CustomCard(
                  data: CustomCardData(
                    items: [
                      CustomListTile(
                        data: CustomListTileData(
                          icon: Icons.info_outline,
                          iconColor: ColorConstants.primaryColor,
                          title: SettingConstants.settingScreenCardTitle1,
                          subtitle: SettingConstants.settingScreenCardSubTitle1,
                        ),
                      ),
                      const Divider(height: 1),
                      CustomListTile(
                        data: CustomListTileData(
                          icon: Icons.star_border,
                          iconColor: ColorConstants.settingScreenOrangeIcon,
                          title: SettingConstants.settingScreenCardTitle2,
                          subtitle: SettingConstants.settingScreenCardSubTitle2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: ColorConstants.onSecondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(
        title: SettingConstants.settingScreenClearTransaction,
        content: SettingConstants.settingScreenClearTransactionWarningSubText,
        onConfirm: () {
          Provider.of<ExpenseProvider>(
            context,
            listen: false,
          ).clearAllTransaction();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AlertDialogue.deleteTransaction)),
          );
        },
      ),
    );
  }
}
