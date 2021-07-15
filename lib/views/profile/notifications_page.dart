import 'package:flutter/material.dart';
import 'package:kushmarkets/bloc/notification.bloc.dart';
import 'package:kushmarkets/constants/app_color.dart';
import 'package:kushmarkets/constants/app_paddings.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/profile/notification.strings.dart';
import 'package:kushmarkets/data/models/notification_model.dart';
import 'package:kushmarkets/utils/custom_dialog.dart';
import 'package:kushmarkets/utils/ui_spacer.dart';
import 'package:kushmarkets/widgets/appbar/leading_app_bar.dart';
import 'package:kushmarkets/widgets/empty/empty_notifications.dart';
import 'package:kushmarkets/widgets/notification/notification_details.dart';
import 'package:kushmarkets/widgets/notification/notification_list_view_item.dart';
import 'package:kushmarkets/widgets/shimmers/general_shimmer_list_view_item.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  //notifications bloc
  NotificationsBloc _notificationsBloc = NotificationsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground(context),
      appBar: AppBar(
        backgroundColor: AppColor.appBackground(context),
        brightness: MediaQuery.of(context).platformBrightness,
        elevation: 0,
        leading: LeadingAppBar(),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          AppPaddings.contentPaddingSize,
          0,
          AppPaddings.contentPaddingSize,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
            //header
            Text(
              NotificationStrings.title,
              style: AppTextStyle.h1TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              
            ),
            UiSpacer.verticalSpace(),

            //select delivery address info
            Expanded(
              child: StreamBuilder<List<NotificationModel>>(
                stream: _notificationsBloc.notifications,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return EmptyNotification();
                  } else if (!snapshot.hasData) {
                    return GeneralShimmerListViewItem();
                  } else if (snapshot.data.length >= 0) {
                    return EmptyNotification();
                  }

                  return ListView.separated(
                    padding: EdgeInsets.only(
                      bottom: AppPaddings.contentPaddingSize * 5,
                    ),
                    separatorBuilder: (context, index) =>
                        UiSpacer.verticalSpace(),
                    itemBuilder: (context, index) {
                      return NotificationListViewItem(
                        notification: snapshot.data[index],
                        onPressed: () {
                          _showNotificationDetails(snapshot.data[index]);
                        },
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //show a bottomsheet of more info
  void _showNotificationDetails(NotificationModel notificationModel) {
    //update the read status of the notification
    notificationModel.read = 1;
    _notificationsBloc.appDatabase.notificationDao.updateItem(
      notificationModel,
    );

    //show the notifcation details
    CustomDialog.showCustomBottomSheet(
      context,
      content: NotificationDetails(
        notification: notificationModel,
      ),
    );
  }
}
