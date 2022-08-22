import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tim_ui_kit/base_widgets/tim_ui_kit_statelesswidget.dart';
import 'package:tim_ui_kit/ui/constants/emoji.dart';
import 'package:tencent_im_base/tencent_im_base.dart';
import 'package:tim_ui_kit/ui/widgets/emoji.dart';

import 'package:tim_ui_kit/base_widgets/tim_ui_kit_base.dart';

class EmojiPanel extends TIMUIKitStatelessWidget {
  final void Function(int unicode) onTapEmoji;
  final void Function() onSubmitted;
  final void Function() delete;
  final bool showBottomContainer;

  EmojiPanel({
    Key? key,
    required this.onTapEmoji,
    required this.onSubmitted,
    required this.delete,
    this.showBottomContainer = true, // 可选参数，是否展示下方的底部导航栏
  }) : super(key: key);

  @override
  Widget tuiBuild(BuildContext context, TUIKitBuildValue value) {
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // height: showBottomContainer ? 190 : 248,
            height: 203,
            // color: theme.weakBackgroundColor,
            color: const Color(0xFF21233D),
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                childAspectRatio: 1,
              ),
              children: [
                ...emojiData.map(
                      (e) {
                    var item = Emoji.fromJson(e);
                    return InkWell(
                      onTap: () {
                        onTapEmoji(item.unicode);
                      },
                      child: EmojiItem(
                        name: item.name,
                        unicode: item.unicode,
                      ),
                    );
                  },
                ).toList(),
              ],
            )),
        Container(
          height: 50,
          margin: const EdgeInsets.only(left: 16),
          child: EmojiItem(name: "item.name", unicode: 128513),
        )
        // showBottomContainer
        //     ? Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           SingleChildScrollView(
        //             child: Container(
        //                 // color: Colors.white,
        //                 margin: const EdgeInsets.only(right: 25),
        //                 // height: MediaQuery.of(context).padding.bottom,
        //                 child: ElevatedButton(
        //                     child: Text(TIM_t("发送")),
        //                     style: ElevatedButton.styleFrom(),
        //                     onPressed: () {
        //                       onSubmitted();
        //                     })),
        //           ),
        //         ],
        //       )
        //     : Container()
      ],
    ),);
  }
}

class EmojiItem extends TIMUIKitStatelessWidget {
  EmojiItem({Key? key, required this.name, required this.unicode})
      : super(key: key);
  final String name;
  final int unicode;

  // final String toUser;
  // final int type;
  // final Function close;
  @override
  Widget tuiBuild(BuildContext context, TUIKitBuildValue value) {
    return Text(
      String.fromCharCode(unicode),
      style: TextStyle(
        fontSize: Platform.isAndroid ? 20 : 26,
      ),
    );
  }
}

