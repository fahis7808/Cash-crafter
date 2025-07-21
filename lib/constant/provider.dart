import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../provider/home_provider.dart';

List<SingleChildWidget> provider = [
  ChangeNotifierProvider(create: (_) => HomeProvider()),
];
