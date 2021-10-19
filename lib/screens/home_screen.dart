import 'dart:math';

import 'package:assignment/providers/count_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountProvider()),
        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.greenAccent,
          title: Consumer<User?>(
            builder: (context, user, child) {
              return Text(
                'Hi ${user?.email ?? ''}',
                style: TextStyle(fontSize: 10.sp),
              );
            },
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 10.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: BottomNavigationBar(
              currentIndex: 0,
              iconSize: 28,
              selectedItemColor: Colors.amber[800],
              onTap: (index) {},
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  label: 'Add',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.grey,
                  ),
                  label: 'Bookmarks',
                ),
                BottomNavigationBarItem(
                  icon: Consumer<User?>(
                    builder: (context, user, child) => CircleAvatar(
                      backgroundImage: NetworkImage(user?.photoURL ?? 'picsum.photos/id/1027/2848/4272'),
                    ),
                  ),
                  label: 'Home',
                ),
              ],
            ),
          ),
        ),
        body: Consumer<CountProvider>(
          builder: (context, countProvider, child) => Column(
            children: [
              Slider(
                min: 1.0,
                max: 5.0,
                value: countProvider.count,
                divisions: 4,
                onChanged: (value) => countProvider.changeCount(value),
              ),
              Expanded(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: countProvider.count.toInt(),
                  shrinkWrap: true,
                  itemCount: 100,
                  primary: false,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  key: ObjectKey(countProvider.count.toInt()),
                  addAutomaticKeepAlives: false,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,

                      /// Get Random height
                      image: 'https://picsum.photos/500/${(Random().nextInt(10) + 3) * 100}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
