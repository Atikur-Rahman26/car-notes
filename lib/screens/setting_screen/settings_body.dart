import 'package:flutter/material.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool _isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.black54,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.white70,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Purchase",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Full Version",
                        style:
                            TextStyle(fontSize: 22, color: Colors.purple[100]),
                      ),
                      const Text(
                        "Buy full version to switch off ads and get more features",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.oil_barrel,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Fuel",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Track fuel costs",
                            style: TextStyle(
                                fontSize: 22, color: Colors.purple[100]),
                          ),
                          Switch(
                            value: _isSwitched,
                            onChanged: (value) {
                              setState(() {
                                _isSwitched = value;
                                print(_isSwitched);
                              });
                            },
                            activeTrackColor: Colors.lightGreen,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.account_box,
                  color: Colors.white70,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Backup",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Google account",
                        style:
                            TextStyle(fontSize: 22, color: Colors.purple[100]),
                      ),
                      const Text(
                        "Select Google account for backup and grant permissions",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.cloud_upload_outlined,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Save",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "Upload data to Google Drive",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.cloud_download_outlined,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Restore",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "Download data from Google Drive",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Remove backup",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "Remove all backup data from Google Drive",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.access_time_rounded,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Automation backup",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "off",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.logout_sharp,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Sign out",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "Sign out Google account and revoke permissions",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.cloud_download,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Export and import data",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Export to Excel file",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "All .xlsx generated files are in folder './storage/emulated/0/Documents/Car Notes'.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.download_for_offline_outlined,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Export to ZIP file",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "All .zip file with all data and images generated in "
                        "folder './storage/emulated/0/Documents/Car Notes'.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.download_for_offline_outlined,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Export to Excel file",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "All .xlsx generated files are in folder './storage/emulated/0/Documents/Car Notes'.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.upload_file_outlined,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Import from ZIP file",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "Import all data from .zip file generated by export. "
                        "All data in the app will be removed and overwritten"
                        " by zip contents.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.format_color_fill_outlined,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Application Theme",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Theme selected",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "Light",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.directions,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Units",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Distance unit",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "kilometer",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.water_drop_outlined,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Volume unit",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "liter",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.currency_exchange_outlined,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Currency",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "British pound",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.directions,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Reminders",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Notification settings",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "Settings sound and vibration for notifications",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Icon(
                  Icons.question_mark_rounded,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Feedback",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Send feedback",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "Write a letter to support",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
