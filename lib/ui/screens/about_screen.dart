
import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
class AboutScreen extends StatelessWidget {
  Widget item(String s){
   return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
       s,
        textAlign: TextAlign.justify,
        style: TextStyle(
          wordSpacing: 2,
          fontWeight: FontWeight.w300,
          fontSize: AppDimens.SIZE_16,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreenMethod(
        title: "home.about",
        body:SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(right: 10, left: 10, top: 10),
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10, left: 10, top: 10,bottom: 10),
                  child: Text(
                    "Earthquake app", // textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimens.SIZE_18,
                    ),
                  ),
                ),
                item("Dự án thông báo động đất thời gian thực trên điện thoại thông minh là một dự án của viện Vật Lý Địa Cầu, giúp người dùng theo dỗi các trận động đất trên lãnh thổ Việt Nam và nhận thông báo thời gian thực khi có động đất xảy ra."),
                Image(image: AssetImage("assets/images/vatlydiacau.jpg"),),
                Text("\nCác chức năng chính của ứng dụng:\n", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                item("- Hiển thị chi tiết  một trận động đất trên bản đồ và số liệu của trận động đất đó. \n\n-Nhận đánh giá trận động đất từ người dùng. \n\n-Thông báp cho người dùng khi có trận động đất mới xảy ra. \n\n- Gửi tin nhắn cứu trợ khi gặp nạn.  "),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
