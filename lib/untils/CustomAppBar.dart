// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'CustomText.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final List<Widget>? actions;
  final bool centerTitle;
  final Function()? onPressed;
  final bool showDrawerIcon;
  final bool showSearch;
  final Function(String)? onSearch;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.hasBackButton,
    required this.actions,
    required this.centerTitle,
    this.onPressed,
    this.showDrawerIcon = false,
    this.showSearch = false,
    this.onSearch,
  });

  @override
  CustomAppBarState createState() => CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarState extends State<CustomAppBar> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: buildLeading(),
      title: isSearching
          ? TextField(
              controller: searchController,
              style: style(22, color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: style(22, color: Colors.black),
                border: InputBorder.none,
              ),
              onChanged: (query) {
                if (widget.onSearch != null) {
                  widget.onSearch!(query);
                }
              },
            )
          : buildTitleRow(),
      centerTitle: widget.centerTitle,
      backgroundColor: const Color(0xFF1A73E8),
      automaticallyImplyLeading: false,
      actions: buildActions(),
    );
  }

  Widget? buildLeading() {
    if (widget.hasBackButton && widget.showDrawerIcon) {
      return Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                width: 100,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: widget.onPressed ?? () => Navigator.pop(context),
                  iconSize: 30,
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  iconSize: 30,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (widget.hasBackButton) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: widget.onPressed ?? () => Navigator.pop(context),
            iconSize: 30,
          ),
        ),
      );
    } else if (widget.showDrawerIcon) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
            iconSize: 30,
          ),
        ),
      );
    }
    return null;
  }

  Widget buildTitleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: style(22, color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildActions() {
    final List<Widget> actionWidgets = [];

    if (widget.showSearch) {
      actionWidgets.add(
        isSearching
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.black),
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    searchController.clear();
                    if (widget.onSearch != null) {
                      widget.onSearch!('');
                    }
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                },
              ),
      );
    }

    if (widget.actions != null) {
      actionWidgets.addAll(widget.actions!);
    }

    return actionWidgets;
  }
}
