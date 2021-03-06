import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recorder/Controllers/HomeController.dart';
import 'package:recorder/Controllers/GeneralController.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/Pages/Home/widgets/AudioPreviewWidget.dart';
import 'package:recorder/UI/Pages/Home/widgets/CollectionsWidget.dart';
import 'package:recorder/UI/widgets/Appbar.dart';
import 'package:provider/provider.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    context.read<GeneralController>().homeController.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.sync(context.read<GeneralController>().onWillPop),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: cBackground.withOpacity(0.0),
          appBar: MyAppBar(
            buttonMore: false,
            buttonBack: false,
            buttonMenu: true,
            padding: 10,
            top: 25,
            height: 90,
            tapLeftButton: () {
              context.read<GeneralController>().setMenu(true);
            },
            childRight: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconButton(
                onPressed: () {
                  context.read<GeneralController>().setPage(5, restore: true);
                },
                icon: iconSvg(IconsSvg.search, color: cBackground),
              ),
            ),
          ),
          body: StreamBuilder<HomeState>(
              stream: context.read<GeneralController>().homeController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                log("${snapshot.data.collections}", name: "collections");
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Collections(
                        onAddCollection: () {
                          context.read<GeneralController>().setPage(1);
                          context
                              .read<GeneralController>()
                              .collectionsController
                              .addCollection();
                        },
                        onTapCollection: (item) {
                          context.read<GeneralController>().setPage(1);
                          context
                              .read<GeneralController>()
                              .collectionsController
                              .view(item);
                        },
                        loading: (snapshot.data == null
                            ? true
                            : snapshot.data.loading ?? false),
                        items: (snapshot.data == null
                            ? []
                            : snapshot.data.collections),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 40, 4, 0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: AudioPreview(
                            loading: (snapshot.data == null
                                ? true
                                : snapshot.data.loading ?? false),
                            items: (snapshot.data.audios ?? []),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
