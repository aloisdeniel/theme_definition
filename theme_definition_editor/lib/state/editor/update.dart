import 'package:flutter/services.dart';
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/state/app/update.dart';
import 'package:theme_definition_editor/state/editor/state.dart';

class EditYaml extends ApplicationUpdate {
  const EditYaml(this.newYaml);
  final String newYaml;
  @override
  Stream<ApplicationState> execute(ApplicationState Function() state,
      dispatch(ApplicationUpdate update)) async* {
    final currentState = state();
    yield currentState.copyWith(
      editor: currentState.editor.copyWith(yaml: newYaml),
    );
    dispatch(SaveState());
  }
}

class ChangeEditorMode extends ApplicationUpdate {
  const ChangeEditorMode(this.newMode);
  final EditorMode newMode;
  @override
  Stream<ApplicationState> execute(ApplicationState Function() state,
      dispatch(ApplicationUpdate update)) async* {
    final currentState = state();
    yield currentState.copyWith(
      editor: currentState.editor.copyWith(mode: newMode),
    );
    dispatch(SaveState());
  }
}

class ChangeExportOptions extends ApplicationUpdate {
  const ChangeExportOptions(this.newOptions);
  final ExportOptions newOptions;
  @override
  Stream<ApplicationState> execute(ApplicationState Function() state,
      dispatch(ApplicationUpdate update)) async* {
    final currentState = state();
    yield currentState.copyWith(
      editor: currentState.editor.copyWith(exportOptions: newOptions),
    );
    dispatch(SaveState());
  }
}

class CopyCodeToClipboard extends ApplicationUpdate {
  const CopyCodeToClipboard();
  @override
  Stream<ApplicationState> execute(ApplicationState Function() state,
      dispatch(ApplicationUpdate update)) async* {
    final currentState = state();
    await Clipboard.setData(
      ClipboardData(text: currentState.editor.exportedCode.dart),
    );
    yield currentState.copyWith(
      editor: currentState.editor.copyWith(
        exportedCode: currentState.editor.exportedCode.copyWith(
          copiedToCliboard: true,
        ),
      ),
    );
  }
}

class ChangePreviewBrightness extends ApplicationUpdate {
  const ChangePreviewBrightness(this.newBrightness);
  final BrightnessMode newBrightness;
  @override
  Stream<ApplicationState> execute(ApplicationState Function() state,
      dispatch(ApplicationUpdate update)) async* {
    final currentState = state();
    yield currentState.copyWith(
      editor: currentState.editor.copyWith(previewBrightness: newBrightness),
    );
    dispatch(SaveState());
  }
}
