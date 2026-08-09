import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/user_provider.dart';
import '../widgets/language_bottom_sheet.dart';

/// Was `GetView<UserController>` + `Obx`; now a `ConsumerWidget` watching
/// `userProvider`. Spacing uses flutter_screenutil (`.w/.h/.sp`) instead of
/// manual `SizedBox`.
class UserView extends ConsumerWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => showLanguagePicker(context, ref),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (userState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = userState.user;
          if (user == null) {
            return Center(
              child: Text(
                "No user data",
                style: TextStyle(fontSize: 16.sp),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${user.name}", style: TextStyle(fontSize: 18.sp)),
                SizedBox(height: 8.h),
                Text("Email: ${user.email}", style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(userProvider.notifier).fetchProfile(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
