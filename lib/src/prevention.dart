import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/constrant/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreventionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
              left: xMargin(5), right: xMargin(5), bottom: yMargin(5)),
          child: Column(
            children: <Widget>[
              headerTips("Cách thức lây nhiễm"),
              Text(
                  "• Bạn có thể bị nhiễm bệnh khi tiếp xúc gần với trong khoảng 2m. COVID-19 chủ yếu lây từ người này sang người khác. \n • Bạn có thể bị nhiễm bệnh từ các giọt nước khi người bị nhiễm bệnh ho, hắt hơi hoặc nói chuyện. \n • Bạn cũng có thể bị nhiễm bệnh khi chạm vào bề mặt hoặc vật có vi rút trên đó, và sau đó bằng cách chạm vào miệng, mũi hoặc mắt của bạn"),
              headerTips("Cách thức bảo vệ \n bản thân"),
              Text("• Cách tốt nhất để bảo vệ bản thân là tránh tiếp xúc với vi-rút" +
                  " gây ra COVID-19 \n • Ở nhà càng nhiều càng tốt và tránh tiếp xúc gần với người khác. \n • Đeo khẩu trang che mũi và miệng của bạn ở những nơi công cộng. \n • Làm sạch và khử trùng các bề mặt thường xuyên chạm vào. \n • Thường xuyên rửa tay bằng xà phòng và nước trong ít nhất 20 giây hoặc sử dụng chất khử trùng tay có cồn chứa ít nhất 60% cồn.\n • Nếu có dấu hiệu mắc bệnh cần nhanh chóng khai báo y tế ở bệnh viện hoặc trạm xá gần nhất"),
              headerTips("Tuân thủ các nghị\n định  về giản cách\n xã hội"),
              Text(
                  "• Hạn chế ra ngoài hết mức có thể \n • Nếu bạn phải trực tiếp ra ngoài, hãy đeo khẩu trang và cách xa người khác ít nhất 2m và khử trùng các vật dụng bạn phải chạm vào. \n • Hạn chế tiếp xúc trực tiếp càng nhiều càng tốt."),
              headerTips(
                "Nguy cơ nhiễm bệnh",
              ),
              Text(
                  "• Mọi người đều có nguy cơ bị nhiễm COVID-19. \n • Người lớn tuổi và những người ở mọi lứa tuổi mắc các tình trạng bệnh lý cơ bản nghiêm trọng có thể có nguy cơ dễ mắc bệnh nặng hơn."),
            ],
          ),
        ),
      ),
    );
  }

  Row headerTips(heading) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(yMargin(1)),
          child: Image.asset(
            "assets/icons/Cont2.png",
            height: yMargin(5),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(yMargin(3)),
          child: Text(
            heading,
            softWrap: true,
            style: headingStyle(),
          ),
        )
      ],
    );
  }

  TextStyle headingStyle() => TextStyle(
      fontSize: yMargin(3),
      color: Colors.red[400],
      fontWeight: FontWeight.bold);
}
