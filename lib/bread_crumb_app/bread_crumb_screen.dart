import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

//provider state management....

class BreadCrumb {
  final String uuid;
  bool isActive;
  final String name;

  BreadCrumb({required this.isActive, required this.name})
      : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) {
    return uuid == other.uuid;
  }

  @override
  int get hashCode => uuid.hashCode;

  String get title => name + (isActive ? ' > ' : '');
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items);

  void add(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.activate();
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
    print("reset done");
  }
}

class BreadCrumbWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> breadCrumbs;
  const BreadCrumbWidget({super.key, required this.breadCrumbs});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumbs.map(
        (breadCrumb) {
          return Text(
            breadCrumb.title,
            style: TextStyle(
                color: breadCrumb.isActive ? Colors.blue : Colors.black),
          );
        },
      ).toList(),
    );
  }
}

class BreadCrumbScreen extends StatelessWidget {
  const BreadCrumbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bread Crumb App"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<BreadCrumbProvider>(
            builder: (context, value, child) {
              return BreadCrumbWidget(
                breadCrumbs: value.items,
              );
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const NewBreadCrumbScreen();
                }));
              },
              child: const Text("New Bread Crumb App")),
          TextButton(
              onPressed: () {
                context.read<BreadCrumbProvider>().reset();
              },
              child: const Text("Reset")),
        ],
      ),
    );
  }
}

class NewBreadCrumbScreen extends StatefulWidget {
  const NewBreadCrumbScreen({super.key});

  @override
  State<NewBreadCrumbScreen> createState() => _NewBreadCrumbScreenState();
}

class _NewBreadCrumbScreenState extends State<NewBreadCrumbScreen> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Bread Crumb"),
      ),
      body: Column(children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: "Add New Bread Crumb here...",
          ),
        ),
        TextButton(
          onPressed: () {
            final text = _controller.text;
            if (text.isNotEmpty) {
              final breadCrumb = BreadCrumb(isActive: false, name: text);
              context.read<BreadCrumbProvider>().add(breadCrumb);
              Navigator.pop(context);
            }
          },
          child: const Text("Add"),
        )
      ]),
    );
  }
}
