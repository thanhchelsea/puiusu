
import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
class FAQScreen extends StatelessWidget {
  // ignore: missing_return
  Widget itemFaq(BuildContext c,{String q, String a}) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Q: ",
                  //textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimens.SIZE_16,
                  ),
                ),
                Container(
                  child: Flexible(
                    child: Text(
                      q,
                         textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: AppDimens.SIZE_16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "A: ",
                     textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimens.SIZE_16,
                  ),
                ),
                Flexible(
                  child: Text(
                    a,
                       textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: AppDimens.SIZE_16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreenMethod(
        title: "home.faq",
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10, left: 10, top: 20),
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Các câu hỏi thường gặp",
                  style: TextStyle(
                    wordSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimens.SIZE_16,
                  ),
                ),
              ),
              itemFaq(context,
                q: "Earthquake app là gì?",
                a: "Earthquake app là ứng dụng đầu tiên trên thiết bị di động theo dõi động đất tại Việt Nam.",
              ),
              itemFaq(context,
                q: "Nó hoạt động như thế nào?",
                a: "Khi phát hiện ra các trận động đất, sự kiện sẽ được thông báo tới máy chủ cùng với vị trí địa lý. Máy chủ tính toán và thông báo tới tất cả người dùng theo thời gian thực.",
              ), itemFaq(context,
                q: "Tại sao nó hữu ích?",
                a: "Bạn sẽ nhận được thông báo về các trận động đất trên lãnh thổ Việt Nam, bạn có thể gửi tin nhắn khẩn cấp trong trường hợp bạn gặp nguy hiểm.",
              ),
              itemFaq(context,
                q: "Làm cách nào để sử dụng ứng dụng?",
                a: "Khởi động ứng dụng và sử dụng như bình thường. Ứng dụng này hoạt động ngay cả khi thiết bị đang sạc và màn hình tắt. Bạn không nhất thiết cần bật dịch vụ định vị nhưng để sử dụng được các tính năng cao hơn thì bạn cần cho phép ứng dụng trung cập vào vị trí của bạn.",
              ),
              itemFaq(context,
                q: "Ứng dụng có thể phát hiện những trận động đất nào?",
                a: "Tất cả các trận động đất trên lãnh thổ Việt Nam.",
              ), itemFaq(context,
                q: "Điều gì xảy ra nếu phát hiện một trận động đất",
                a: "Bạn sẽ nhận được thông báo theo thời gian thực. Thông báo có biểu tượng vòng tròn đỏ và bạn sẽ thấy vị trí của trận động đất trên bản đồ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
