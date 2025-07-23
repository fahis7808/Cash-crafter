import 'package:cash_crafter/provider/dept_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../provider/balance_provider.dart';
import '../provider/home_provider.dart';

List<SingleChildWidget> provider = [
  ChangeNotifierProvider(create: (_) => HomeProvider()),
  ChangeNotifierProvider(create: (_) => BalanceProvider()),
  ChangeNotifierProvider(create: (_) => DebtProvider()),
];
