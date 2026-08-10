import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_images.dart';
import '../../core/localization/translation_provider.dart';
import '../../core/utils/token_storage.dart';
import '../routes/app_routes.dart';


class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final results = await Future.wait([
      TokenStorage.getToken(),
      Future.delayed(const Duration(milliseconds: 1400)),
    ]);

    final token = results[0] as String?;
    if (!mounted) return;


    if (token != null && token.isNotEmpty) {
      context.go(AppRoutes.user);
    } else {
      context.go(AppRoutes.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Image.asset(
                AppImages.logo,
                width: 120.w,
                height: 120.w,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.directions_car_filled_rounded,
                  size: 90.w,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              ref.tr('app_name'),
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: 28.w,
              height: 28.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
