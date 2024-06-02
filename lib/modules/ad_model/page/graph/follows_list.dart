import 'package:flutter/material.dart';

import 'model/graph_model.dart';
import 'widget.dart';

class ViewAll extends StatelessWidget {
  final String name;
  final List<IsLikeUserList> isFollowUserData;
  const ViewAll(
      {super.key, required this.isFollowUserData, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: isFollowUserData.isEmpty
          ? const Center(child: Text("No Data is Available"))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: list(isFollowUserData)),
    );
  }
}
