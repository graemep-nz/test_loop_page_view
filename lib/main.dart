import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter loop pave view demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Loop page view demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            PageHandlerWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PageManager.nextPage();
          _incrementCounter();
        },
        tooltip: 'Increment page',
        child: const Icon(Icons.add),
      ),
    );
  }
}

final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  textStyle: const TextStyle(fontSize: 14),
  minimumSize: const Size(70, 44),
  padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
);


class ShowPage1 extends StatefulWidget{
  ShowPage1({super.key});
  @override
  _ShowPage1 createState() => _ShowPage1();
}

class _ShowPage1 extends State<ShowPage1>  with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("page 1 initState");
  }
  @override
  void didUpdateWidget(covariant ShowPage1 oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return page1();
  }
}

class ShowPage2 extends StatefulWidget{
  ShowPage2({super.key});
  @override
  _ShowPage2 createState() => _ShowPage2();
}

class _ShowPage2 extends State<ShowPage2>  with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("page 2 initState");
  }
  @override
  void didUpdateWidget(covariant ShowPage2 oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return page2();
  }
}

class ShowPage3 extends StatefulWidget{
  ShowPage3({super.key});
  @override
  _ShowPage3 createState() => _ShowPage3();
}

class _ShowPage3 extends State<ShowPage3>  with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print("page 3 initState");
    super.initState();
  }
  @override
  void didUpdateWidget(covariant ShowPage3 oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return page3();
  }
}

class ShowPage4 extends StatefulWidget{
  ShowPage4({super.key});
  @override
  _ShowPage4 createState() => _ShowPage4();
}

class _ShowPage4 extends State<ShowPage4>  with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("page 4 initState");
  }
  @override
  void didUpdateWidget(covariant ShowPage4 oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return page4();
  }
}





PageHandlerWidget thePageHandler = PageHandlerWidget();

class PageManager {
  static int numberOfPages = 3;
  static var myPageController = LoopPageController();
  static bool requestDoJump = false;
  static Widget? alternatePageWidget = null;

  static int currentPage = 0;
  static int page1 = 0;
  static int page2 = 1;
  static int page3 = 2;
  static int page4 = 3;

  static bool isAltPageActive() {
    return alternatePageWidget != null;
  }

  static void jumpToCurrentPage() {
    if (myPageController.hasClients) {
      currentPage = myPageController.page.toInt();
      jumpToPage(currentPage);
    }
  }

  static void jumpToPage(int pageNum) {
    if (myPageController.hasClients) {
      currentPage = pageNum;
      myPageController.jumpToPage(pageNum);
    }
  }

  static void nextPage() {
    //clubPageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    if (myPageController.hasClients) {
      currentPage = myPageController.page.toInt();
      if (++currentPage >= numberOfPages) currentPage = 0;
      jumpToPage(currentPage);
    }
  }

  static void includeAlternatePage(Widget altPageWidget) {
    alternatePageWidget = altPageWidget;
    numberOfPages = 4;
    jumpToPage(page4);
    thePageHandler.rebuild();
    requestDoJump = true;
  }

  static void removeAlternatePage() {
    if (alternatePageWidget != null) {
      numberOfPages = 3;
      alternatePageWidget = null;
      thePageHandler.rebuild();
      requestDoJump = true;
    }
  }
}

Widget page1() {
  return Center(
    child: Container(
      constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
      color: Colors.red,
      child: Column(
        children: [
          Text("page 1"),
          Row(
            children: [
              Text("Enter text:"),
              Expanded(child: TextField()),
            ],
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              if (PageManager.numberOfPages == 4) {
                PageManager.jumpToPage(3);
              } else {
                PageManager.jumpToPage(2);
              }
            },
            child: const Text('go to page 3 or 4'),
          ),

        ],
      ),
    ),
  );
}

Widget page2() {
  return SizedBox(
    width:200, height: 200,
    child: Container(
      color: Colors.green,
      child: Column(
        children: [
          Text("page 2"),
          Row(
            children: [
              Text("Enter text:"),
              Expanded(child: TextField()),
            ],
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              PageManager.jumpToPage(0);
            },
            child: const Text('go to page 1'),
          ),
        ],
      ),
    ),
  );
}

Widget page3() {
  return SizedBox(
    width:200, height: 200,
    child: Container(
      color: Colors.blue,
      child: Column(
        children: [
          Text("page 3"),
          Row(
            children: [
              Text("Enter text:"),
              Expanded(child: TextField()),
            ],
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              PageManager.includeAlternatePage(page4());
            },
            child: const Text('add page 4'),
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              PageManager.jumpToPage(1);
            },
            child: const Text('go to page 2'),
          ),

        ],
      ),
    ),
  );
}

Widget page4() {
  return Center(
    child: Container(
      constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
      color: Colors.orange,
      child: Column(
        children: [
          Text("page 4"),
          Row(
            children: [
              Text("Enter text:"),
              Expanded(child: TextField()),
            ],
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              PageManager.removeAlternatePage();
              PageManager.jumpToPage(0);
            },
            child: const Text('remove page 4'),
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              PageManager.jumpToPage(2);
            },
            child: const Text('go to page 3'),
          ),
        ],
      ),
    ),
  );
}


_PageHandlerWidget?  myPage;

class PageHandlerWidget extends StatefulWidget{
  PageHandlerWidget({super.key});

  @override
  _PageHandlerWidget createState() => myPage = _PageHandlerWidget();
  void rebuild() {
    myPage!.doSetState();
  }
}


class _PageHandlerWidget extends State<PageHandlerWidget>{

  void doSetState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PageHandlerWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _runsAfterBuild() async {
    PageManager.jumpToCurrentPage();
  }

  @override
  Widget build(BuildContext context) {

    if (PageManager.requestDoJump) {
      PageManager.requestDoJump = false;
      Future(_runsAfterBuild);
    }

    return SizedBox(
      width: 600, height:600,
      child: LoopPageView.builder(
        //key : ValueKey(88449263),
        itemCount: PageManager.numberOfPages,
        controller: PageManager.myPageController,
        //physics: (PageManager.currentPage ==
          //          PageManager.theAltPage) ? NeverScrollableScrollPhysics() : null,
        itemBuilder: (context, index) {

          int k = index % PageManager.numberOfPages;
          if (k == PageManager.page1) return ShowPage1(key: ValueKey(111),);
          if (k == PageManager.page2) return ShowPage2(key: ValueKey(222),);
          if (k == PageManager.page3) return ShowPage3(key: ValueKey(333),);
          /*if (k == PageManager.page4)*/ return ShowPage4(key: ValueKey(444),);
        }
      )
    );
  }

}

