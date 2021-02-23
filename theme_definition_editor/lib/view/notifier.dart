import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/state/app/update.dart';
import 'package:theme_definition_editor/state/notifier.dart';

typedef ApplicationState InitialStateBuilder();

class ApplicationStateProvider extends StatelessWidget {
  const ApplicationStateProvider({
    Key key,
    @required this.initialState,
    @required this.child,
  }) : super(key: key);

  final InitialStateBuilder initialState;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationNotifier>(
      create: (context) => ApplicationNotifier(
        initialState(),
      ),
      builder: (context, _) => Provider.value(
        value: context.watch<ApplicationNotifier>().state,
        child: child,
      ),
    );
  }
}

extension ApplicationStateExtensions on BuildContext {
  void dispatch(ApplicationUpdate update) {
    read<ApplicationNotifier>().dispatch(update);
  }
}
