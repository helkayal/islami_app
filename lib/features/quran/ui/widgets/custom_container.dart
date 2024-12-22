import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';
import '../../data/models/quran_model.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.quranModel,
    required this.isSelected,
  });

  final QuranModel quranModel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 10.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textColor),
        color: isSelected ? AppColors.textColor : const Color(0xffDDD9FB),
        borderRadius: BorderRadiusDirectional.horizontal(
          start: Radius.circular(20.r),
          end: Radius.circular(20.r),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '${quranModel.number}. ${quranModel.englishName}',
          style: TextStyle(
            fontSize: 15.sp,
            color: isSelected ? AppColors.whiteColor : AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/theming/colors.dart';
// import '../../data/models/quran_model.dart';

// class CustomContainer extends StatelessWidget {
//   const CustomContainer(
//       {super.key, required this.quranModel, required this.isSelected});
//   final QuranModel quranModel;
//   final bool isSelected;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 120.w,
//       height: 10.h,
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.textColor),
//         color: isSelected ? AppColors.textColor : const Color(0xffDDD9FB),
//         borderRadius: BorderRadiusDirectional.horizontal(
//           start: Radius.circular(20.r),
//           end: Radius.circular(20.r),
//         ),
//       ),
//       child: FittedBox(
//         fit: BoxFit.scaleDown,
//         child: Text(
//           '${quranModel.number}. ${quranModel.englishName}',
//           style: TextStyle(
//             fontSize: 15.sp,
//             color: isSelected ? AppColors.whiteColor : AppColors.textColor,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
