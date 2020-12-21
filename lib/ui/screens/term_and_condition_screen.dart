import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermAndConditionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreenMethod(
        title: "home.terms_and_conditions",
        body: Container(
        //  color: Colors.grey.withOpacity(0.2),
          margin: EdgeInsets.only(right: 10, left: 10,top: 10),
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                   "Chào mừng bạn đến với \n Earthquake Network!", // textAlign: TextAlign.justify,
                    style: TextStyle(
                      wordSpacing: 2,
                      fontWeight: FontWeight.w300,
                      fontSize: AppDimens.SIZE_16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Bằng cách tải xuống hoặc sử dụng ứng dụng, các điều khoản này sẽ tự động áp dụng cho bạn. Do đó bạn nên đảm bảo rằng bạn đã đọc chúng cẩn thận trước khi sử dụng ứng dụng. Bạn không được phép sao chép hoặc sửa đổi ứng dụng, bất kỳ phần nào của ứng dụng hoặc nhãn hiệu của chúng tôi theo bất kỳ cách nào. Bạn không được phép cố gắng trích xuất mã nguồn của ứng dụng và bạn cũng không nên cố dịch ứng dụng sang các ngôn ngữ khác hoặc tạo các phiên bản phát sinh. Bản thấn ứng dụng vàtất cả các nhãn hiệu thương mại, bản quyền, quyền cơ sở dữ liệu và các quyền sở hữu trí tuệ khác liên quan đến nó.",
                   textAlign: TextAlign.justify,
                    style: TextStyle(
                     wordSpacing: 2,
                      fontWeight: FontWeight.w300,
                      fontSize: AppDimens.SIZE_16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Ứng dụng là một phần dự án của Viện Vật Lý địa cầu. Dự án đang trong giao đoạn thử nghiệm nên không chịu trách nhiệm về việc bổ sót các phát hiện động đất, hoặc báo động sai. Ngoài ra không đảm bảo tính chính xác tuyệt đối thông tin do mạng lưới địa chân quốc gia công bố và không chịu trách nhiệm người dùng sử dụng sai thông tin đó.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: AppDimens.SIZE_16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                   "Ứng dụng sử dụng dữ liệu cá nhân mà bạn đã cung cấp cho chúng tôi. Để cung cấp dịch vụ và cho các hoạt động nghiên cứu không liên quan trực tiếp tới động đất. Bạn có trách nhiệm bảo mật điện thoại và quyền truy cập vào ứng dụng. Do đó chúng tôi khuyên bạn không nên bẻ khóa hoặc root điện thoại, đây là quá trình loại bỏ hạn chế và giới hạn phần mềm do hệ điều hành chính thức thiết bị của bạn áp đặt. Điều này có thể khiến điện thoại của bạn dễ bị tấn công bởi phần mềm độc hại/ virut/ chương trình độc hại, xâm phạm các tính năng bảo mật của điện thoại và có thể khiến ứng dụng hoạt động không bình thường hoặc hoàn toàn không hoạt động.",
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
        ),
      ),
    );
  }
}
