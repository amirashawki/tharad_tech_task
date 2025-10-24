import 'package:evolvify/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CustOmSearch extends StatefulWidget {
  CustOmSearch({
    super.key,
    this.onSubmitted,
    this.onTap,
    this.hint,
    this.controller,
  });

  Function(String)? onSubmitted;
  void Function()? onTap;
  String? hint;
  @override
  TextEditingController? controller;
  State<CustOmSearch> createState() => _CustOmSearchState();
}

class _CustOmSearchState extends State<CustOmSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffEAF4FF),
      ),

      child: TextField(
        controller: widget.controller,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          hintText: widget.hint ?? 'What skill do you want to learn?',
          hintStyle: AppStyle.styleRegularGrey14(
            context,
          ).copyWith(color: Color(0xff888C94)),
          suffixIcon: GestureDetector(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SvgPicture.asset('assets/images/search-normal.svg'),
            ),
          ),
          enabledBorder: outlineBorder(),
          focusedBorder: outlineBorder(),

          contentPadding: EdgeInsets.only(top: 16, bottom: 18, left: 16),
        ),
      ),
    );
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(borderSide: BorderSide(color: Color(0xffEAF4FF)));
  }
}

// Container(
//   height: (37 / 932) * ScreenUtils.screenHeight(context),
//   width: (398 / 414) * ScreenUtils.screenWidth(context),
//   decoration: BoxDecoration(
//     border: Border.all(
//       color: kGrey,
//     ),
//     borderRadius: BorderRadius.circular(10),
//     color: Colors.white,
//   ),
//   child: Row(
//     children: [
//       Padding(
//         padding: EdgeInsets.only(
//             left: (16 / 414) * ScreenUtils.screenWidth(context)),
//         child:IconButton(onPressed: (){}, icon: Icon(Icons.search,color: kGrey,size: 21,))
//       ),

//       Text(
//         'Search',
//         style: TextStyle(
//           color: kGrey,
//           fontSize:   (16 / 932) * ScreenUtils.screenHeight(context),
//         ),
//       ),
//     ],
//   ),
// );
