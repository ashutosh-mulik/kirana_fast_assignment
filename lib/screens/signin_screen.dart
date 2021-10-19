import 'package:assignment/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1.5.w,
                      ),
                    ),
                    height: 70.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 70.w),
                                height: 10.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 30.w),
                                height: 12.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                          child: index == 2 ? _buildOverlappedAvatars(1) : _buildOverlappedAvatars(2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SignInButton(
                    Buttons.GoogleDark,
                    onPressed: () async {
                      authProvider.signInWithGoogle(context: context).then(
                        (user) {
                          if (user != null) {
                            Navigator.pushNamed(context, '/home');
                          } else {
                            /// Handle error
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildOverlappedAvatars(count) => ListView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: count,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Align(
            widthFactor: 0.6,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22.r,
              child: CircleAvatar(
                radius: 20.r,
                backgroundImage: const NetworkImage('https://picsum.photos/200/300'),
              ),
            ),
          );
        },
      );
}
