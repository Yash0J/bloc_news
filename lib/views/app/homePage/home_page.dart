import 'package:intl/intl.dart';
import 'package:bloc_news/bloc/news_states.dart';
import 'package:bloc_news/bloc/news_events.dart';
import 'package:bloc_news/bloc/news_bloc.dart';
import 'package:bloc_news/modals/article_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String _currentDate = "";

  @override
  void initState() {
    super.initState();
    // _currentDate = DateFormat.yMMMd().format(DateTime.now()); // Get Mmm DD, YYYY
    context.read<NewsBloc>().add(StartEvent()); // Trigger news fetching
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20.w,
        leading: Center(
          child: Text(DateFormat.yMMMd().format(DateTime.now()),
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400)),
        ),
        title: Text("bloc news".toUpperCase(),
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        toolbarHeight: 6.h,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.refresh_thin),
            color: Colors.white,
            iconSize: 24,
            onPressed: () {
              context.read<NewsBloc>().add(StartEvent()); // Refresh news
            },
          ),
        ],
      ),
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
                    color: Colors.black,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white10,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 38.w,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(13)),
                          image: DecorationImage(
                            image: NetworkImage(
                                "${articleList[index].urlToImage ?? const Center(
                                      child: Text(
                                        "Error getting image",
                                        overflow: TextOverflow.visible,
                                        maxLines: 4,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 50.w,
                          child: Text(
                            "${articleList[index].title}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is NewsErrorState) {
            String error = state.errorMessage;
            return Center(
              child: Text(
                "Error: \n$error",
                overflow: TextOverflow.visible,
              ),
            );
          } else {
            return const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("\n\nAn unexpected error")
              ],
            ));
          }
        },
      ),
    );
  }
}
