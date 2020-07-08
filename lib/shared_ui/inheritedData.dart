import 'package:betterlife/models/User.dart';
import 'package:betterlife/models/mole.dart';
import 'package:flutter/cupertino.dart';

class InheritData extends InheritedWidget {
  User user;
  List<Mole> moles;
  Map statistics;

  InheritData(Widget child) : super(child: child) {
    this.user = User();
    this.moles = [];
    this.statistics = Map();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  void loadData(userToken) async {
    this.user = await User.getUserByToken(userToken);
    this.statistics = await user.getStatistics();
    // this.moles = await user.getMoles();
  }

  static InheritData of(BuildContext context) => context.inheritFromWidgetOfExactType(InheritData);
}