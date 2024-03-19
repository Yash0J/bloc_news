import 'package:bloc_news/bloc/news_states.dart';
import 'package:bloc_news/bloc/news_bloc.dart';
import 'package:bloc_news/modals/article_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("bloc news".toUpperCase()),
        centerTitle: true,
        toolbarHeight: 6.h,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<NewsBloc, NewsStates>(
        builder: (BuildContext context, NewsStates state) {
          if (state is NewsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoadedState) {
            List<ArticleModal> articleList = state.articleList;
            return ListView.builder(
              itemCount: articleList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // padding: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 16.h,
                  margin: EdgeInsets.all(2.w),
                  // width: 95.w,
                  // margin: EdgeInsets.only(bottom: 3.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 2),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(13)),
                          image: DecorationImage(
                            image: NetworkImage(
                                "${articleList[index].urlToImage ?? const Text(
                                      "Error getting image",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 10),
                                    )}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "${articleList[index].title}",
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is NewsErrorState) {
            String error = state.errorMEssage;
            return Center(
              child: Text(
                error,
                overflow: TextOverflow.visible,
              ),
            );
          } else {
            return const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("\n\ninfinite loading error")
              ],
            ));
          }
        },
      ),
    );
  }
}
