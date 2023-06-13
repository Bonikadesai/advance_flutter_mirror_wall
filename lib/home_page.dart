import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/provider/connect_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  InAppWebViewController? inAppWebViewController;
  int moreserch = 1;
  List bookmark = [];
  List bookmarkurl = [];
  late PullToRefreshController pullToRefreshController;
  String url = "https://www.google.com/";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.red,
        ),
        onRefresh: () async {
          await inAppWebViewController?.reload();
        });
    Provider.of<ConnectProvider>(context, listen: false).checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Browser"),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.bookmark_add_outlined,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "All BookMark",
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.image_search,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Serch Engine",
                    ),
                  ],
                ),
              ),
            ],
            elevation: 1,
            onSelected: (moreserch) {
              setState(() {
                moreserch = moreserch;
              });
              if (moreserch == 1) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: 750,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.close,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Dismiss",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueAccent),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              child: (bookmark.isNotEmpty)
                                  ? ListView.builder(
                                      itemCount: bookmark.length,
                                      itemBuilder: (context, i) => ListTile(
                                        onTap: () {
                                          setState(() {
                                            inAppWebViewController?.loadUrl(
                                              urlRequest:
                                                  URLRequest(url: bookmark[i]),
                                            );
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        title: Text("${bookmarkurl[i]}"),
                                        subtitle: Text("${bookmark[i]}"),
                                        trailing: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              bookmark.remove(bookmark[i]);
                                              bookmarkurl
                                                  .remove(bookmarkurl[i]);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text("No any bookmark yet..."),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (moreserch == 2) {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Search Engine"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile(
                            title: Text("Google"),
                            value: "https://www.google.com/",
                            groupValue: url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Yahoo"),
                            value: "https://in.search.yahoo.com/",
                            groupValue: url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Bing"),
                            value: "https://www.bing.com/",
                            groupValue: url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Duck Duck Go"),
                            value: "https://duckduckgo.com/",
                            groupValue: url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }
            },
          ),
        ],
      ),
      body: (Provider.of<ConnectProvider>(context).connectModel.connectStatus ==
              "Waiting")
          ? Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "lib/assets/dog.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  flex: 9,
                  child: InAppWebView(
                    pullToRefreshController: pullToRefreshController,
                    initialUrlRequest: URLRequest(
                      url: Uri.parse("https://www.google.com/"),
                    ),
                    onLoadStart: (controller, uri) {
                      setState(() {
                        inAppWebViewController = controller;
                      });
                    },
                    onLoadStop: (controller, uri) async {
                      await pullToRefreshController.endRefreshing();
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            String texfieldserch = searchController.text;
                            inAppWebViewController?.loadUrl(
                              urlRequest: URLRequest(
                                url: Uri.parse(
                                    "${url}search?q=${texfieldserch}"),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.search,
                          ),
                        ),
                        hintText: "Serch or type web address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await inAppWebViewController?.loadUrl(
                            urlRequest: URLRequest(
                              url: Uri.parse(url),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.home,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          bookmarkurl.add(
                            await inAppWebViewController?.getTitle(),
                          );
                        },
                        icon: Icon(
                          Icons.bookmark_add_outlined,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (await inAppWebViewController!.canGoBack()) {
                            await inAppWebViewController?.goBack();
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.refresh,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (await inAppWebViewController!.canGoForward()) {
                            await inAppWebViewController?.goForward();
                          }
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      // body: StreamBuilder(
      //   stream: Connectivity().onConnectivityChanged,
      //   builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) =>
      //       (snapshot.data == ConnectivityResult.mobile ||
      //               snapshot.data == ConnectivityResult.wifi)
      //           ? Center(
      //               child: Container(
      //                 child: Text("Mobile and Wifi both are Connected"),
      //               ),
      //             )
      //           : Center(
      //               child: CircularProgressIndicator(),
      //             ),
      // ),
    );
  }
}
