import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/state/editor/state.dart';

import 'default_yaml.dart';

abstract class ApplicationUpdate {
  const ApplicationUpdate();
  Stream<ApplicationState> execute(
    ApplicationState state(),
    dispatch(ApplicationUpdate update),
  );
}

class RestoreState extends ApplicationUpdate {
  const RestoreState();

  @override
  Stream<ApplicationState> execute(ApplicationState Function() state,
      dispatch(ApplicationUpdate update)) async* {
    final currentState = state();
    final f = kIsWeb ? databaseFactoryWeb : databaseFactoryIo;
    var db = await f.openDatabase('state');
    var store = StoreRef.main();

    final yaml = await store.record('yaml').get(db) as String?;
    final mode = await store.record('mode').get(db) as int?;
    final nullSafety =
        await store.record('exportOptions.nullSafety').get(db) as bool?;

    final codeBrightness =
        await store.record('code_brightness').get(db) as int?;
    final previewBrightness =
        await store.record('preview_brightness').get(db) as int?;

    yield currentState.copyWith(
      editor: EditorState(
        yaml: yaml == null || yaml.trim().isEmpty ? defaultYaml.trim() : yaml,
        mode: EditorMode.values[mode ?? EditorMode.preview.index],
        exportOptions: ExportOptions(
          nullSafety: nullSafety ?? false,
        ),
        codeBrightness:
            BrightnessMode.values[codeBrightness ?? BrightnessMode.dark.index],
        previewBrightness: BrightnessMode
            .values[previewBrightness ?? BrightnessMode.light.index],
      ),
    );
    print('Retored state from storage');
  }
}

class SaveState extends ApplicationUpdate {
  const SaveState();

  @override
  Stream<ApplicationState> execute(ApplicationState Function() state,
      dispatch(ApplicationUpdate update)) async* {
    final currentState = state();

    final f = kIsWeb ? databaseFactoryWeb : databaseFactoryIo;
    var db = await f.openDatabase('state');
    var store = StoreRef.main();

    await store.record('yaml').put(db, currentState.editor.yaml);
    await store.record('mode').put(db, currentState.editor.mode.index);
    await store
        .record('code_brightness')
        .put(db, currentState.editor.codeBrightness.index);
    await store
        .record('preview_brightness')
        .put(db, currentState.editor.previewBrightness.index);
    await store
        .record('exportOptions.nullSafety')
        .put(db, currentState.editor.exportOptions.nullSafety);
    print('Saved state to storage');
  }
}
