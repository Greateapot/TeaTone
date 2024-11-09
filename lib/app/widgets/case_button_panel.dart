import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// features
import 'package:teatone/src/features/battery_level_sensor/battery_level_sensor.dart';
import 'package:teatone/src/features/deletor/deletor.dart';
import 'package:teatone/src/features/display/display.dart';
import 'package:teatone/src/features/parameter_selector/parameter_selector.dart';
import 'package:teatone/src/features/parameters/parameters.dart';
import 'package:teatone/src/features/player/player.dart';
import 'package:teatone/src/features/record_selector/record_selector.dart';
import 'package:teatone/src/features/recorder/recorder.dart';
import 'package:teatone/src/features/sort_method_selector/sort_method_selector.dart';
import 'package:teatone/src/features/storage/storage.dart';
import 'package:teatone/src/features/storage_type_selector/storage_type_selector.dart';

import 'case_button.dart';
import 'case_buttons_row.dart';

class CaseButtonPanel extends StatelessWidget {
  const CaseButtonPanel({super.key});

  void _onConfirmPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayDeletor():
        context.read<DeletorBloc>().add(DeletorConfirmed(
              onSuccess: () => _onSuccess(context),
              onFailure: () => _onFailure(context),
            ));
        break;
      case DisplayRecordSelector():
        context.read<RecordSelectorBloc>().add(RecordSelectorSelectingCompleted(
              displayState.type == RecordSelectingInitiatorType.player
                  ? (record) => _onPlayerRecordSelected(context, record)
                  : (record) => _onDeletorRecordSelected(context, record),
            ));
        break;
      case DisplayParameterSelector():
        context
            .read<ParameterSelectorBloc>()
            .add(ParameterSelectorSelectingCompleted(
              (parameter) => _onParameterSelected(context, parameter),
            ));
        break;
      case DisplaySortMethodSelector():
        context
            .read<SortMethodSelectorBloc>()
            .add(SortMethodSelectorSelectingCompleted(
              (sortMethod) => _onSortMethodSelected(context, sortMethod),
            ));
        break;
      case DisplayStorageTypeSelector():
        context
            .read<StorageTypeSelectorBloc>()
            .add(StorageTypeSelectorSelectingCompleted(
              (storageType) => _onStorageTypeSelected(context, storageType),
            ));
        break;
      default: // skip
    }
  }

  void _onCancelPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    context.read<DisplayBloc>().add(const DisplayCanceledDisplayed());

    switch (displayState) {
      case DisplayDeletor():
        context.read<DeletorBloc>().add(const DeletorCanceled());
        break;
      case DisplayRecordSelector():
        context
            .read<RecordSelectorBloc>()
            .add(const RecordSelectorSelectingCanceled());
        break;
      case DisplayParameterSelector():
        context
            .read<ParameterSelectorBloc>()
            .add(const ParameterSelectorSelectingCanceled());
        break;
      case DisplaySortMethodSelector():
        context
            .read<SortMethodSelectorBloc>()
            .add(const SortMethodSelectorSelectingCanceled());
        break;
      case DisplayStorageTypeSelector():
        context
            .read<StorageTypeSelectorBloc>()
            .add(const StorageTypeSelectorSelectingCanceled());
        break;
      default: // skip
    }
  }

  void _onUpPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayRecordSelector():
        context
            .read<RecordSelectorBloc>()
            .add(const RecordSelectorPreviousSelected());
        break;
      case DisplayParameterSelector():
        context
            .read<ParameterSelectorBloc>()
            .add(const ParameterSelectorPreviousSelected());
        break;
      case DisplaySortMethodSelector():
        context
            .read<SortMethodSelectorBloc>()
            .add(const SortMethodSelectorPreviousSelected());
        break;
      case DisplayStorageTypeSelector():
        context
            .read<StorageTypeSelectorBloc>()
            .add(const StorageTypeSelectorPreviousSelected());
        break;
      default: // skip
    }
  }

  void _onDownPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayRecordSelector():
        context
            .read<RecordSelectorBloc>()
            .add(const RecordSelectorNextSelected());
        break;
      case DisplayParameterSelector():
        context
            .read<ParameterSelectorBloc>()
            .add(const ParameterSelectorNextSelected());
        break;
      case DisplaySortMethodSelector():
        context
            .read<SortMethodSelectorBloc>()
            .add(const SortMethodSelectorNextSelected());
        break;
      case DisplayStorageTypeSelector():
        context
            .read<StorageTypeSelectorBloc>()
            .add(const StorageTypeSelectorNextSelected());
        break;
      default: // skip
    }
  }

  void _onLeftPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayPlayer():
        context.read<PlayerBloc>().add(const PlayerPreviousPosition());
        break;
      default: // skip
    }
  }

  void _onRightPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayPlayer():
        context.read<PlayerBloc>().add(const PlayerNextPosition());
        break;
      default: // skip
    }
  }

  void _onRecordPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayHome():
        final parameters = context.read<ParametersBloc>().state.parameters ??
            Parameters.defaults();

        context.read<DisplayBloc>().add(const DisplayRecorderDisplayed());
        context
            .read<RecorderBloc>()
            .add(RecorderStarted(parameters.storageType));
        break;
      default: // skip
    }
  }

  void _onPlayPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayHome():
        final parameters = context.read<ParametersBloc>().state.parameters ??
            Parameters.defaults();

        context.read<DisplayBloc>().add(const DisplayRecordSelectorDisplayed(
            RecordSelectingInitiatorType.player));
        context
            .read<RecordSelectorBloc>()
            .add(RecordSelectorSelectingStarted(parameters));
        break;
      default: // skip
    }
  }

  void _onPausePressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayPlayer():
        context.read<PlayerBloc>().add(const PlayerPaused());
        break;
      case DisplayRecorder():
        context.read<RecorderBloc>().add(const RecorderPaused());
        break;
      default: // skip
    }
  }

  void _onStopPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayPlayer():
        context.read<DisplayBloc>().add(const DisplayHomeDisplayed());
        context.read<PlayerBloc>().add(const PlayerStopped());
        break;
      case DisplayRecorder():
        context.read<DisplayBloc>().add(const DisplayHomeDisplayed());
        context.read<RecorderBloc>().add(const RecorderStopped());
        break;
      default: // skip
    }
  }

  void _onDeletePressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayHome():
        final parameters = context.read<ParametersBloc>().state.parameters ??
            Parameters.defaults();

        context.read<DisplayBloc>().add(const DisplayRecordSelectorDisplayed(
            RecordSelectingInitiatorType.deletor));
        context
            .read<RecordSelectorBloc>()
            .add(RecordSelectorSelectingStarted(parameters));
        break;
      default: // skip
    }
  }

  void _onParametersPressed(BuildContext context) {
    final displayState = context.read<DisplayBloc>().state;

    if (displayState.isDisplayOff) return;

    switch (displayState) {
      case DisplayHome():
        context
            .read<DisplayBloc>()
            .add(const DisplayParameterSelectorDisplayed());
        context
            .read<ParameterSelectorBloc>()
            .add(const ParameterSelectorSelectingStarted());
        break;
      default: // skip
    }
  }

  void _onRecordLongPress(BuildContext context) {
    final batteryLevelSensorBloc = context.read<BatteryLevelSensorBloc>();

    if (batteryLevelSensorBloc.state.batteryChargePercentage <=
        batteryLevelSensorBloc
            .batteryLevelSensorConfig.lowBatteryChargePercentage) return;

    context.read<DisplayBloc>().add(const DisplayStateChanged());
    batteryLevelSensorBloc.add(const BatteryLevelSensorDisplayStateChanged());
  }

  void _onPlayerRecordSelected(BuildContext context, Record record) {
    context.read<DisplayBloc>().add(const DisplayPlayerDisplayed());
    context
        .read<PlayerBloc>()
        .add(PlayerStarted(record, () => _onPlayerStopped(context)));
  }

  void _onDeletorRecordSelected(BuildContext context, Record record) {
    context.read<DisplayBloc>().add(const DisplayDeletorDisplayed());
    context.read<DeletorBloc>().add(DeletorStarted(record));
  }

  void _onParameterSelected(BuildContext context, Parameter parameter) {
    switch (parameter) {
      case Parameter.sortMethod:
        final parameters = context.read<ParametersBloc>().state.parameters ??
            Parameters.defaults();

        context
            .read<DisplayBloc>()
            .add(const DisplaySortMethodSelectorDisplayed());
        context
            .read<SortMethodSelectorBloc>()
            .add(SortMethodSelectorSelectingStarted(parameters.sortMethod));

        break;
      case Parameter.storageType:
        final parameters = context.read<ParametersBloc>().state.parameters ??
            Parameters.defaults();

        context
            .read<DisplayBloc>()
            .add(const DisplayStorageTypeSelectorDisplayed());
        context
            .read<StorageTypeSelectorBloc>()
            .add(StorageTypeSelectorSelectingStarted(parameters.storageType));

        break;
      default: // skip
    }
  }

  void _onSortMethodSelected(BuildContext context, SortMethod sortMethod) {
    context.read<ParametersBloc>().add(ParametersUpdated(
          sortMethod: sortMethod,
          onSuccess: () => _onSuccess(context),
          onFailure: () => _onFailure(context),
        ));
  }

  void _onStorageTypeSelected(BuildContext context, StorageType storageType) {
    context.read<ParametersBloc>().add(ParametersUpdated(
          storageType: storageType,
          onSuccess: () => _onSuccess(context),
          onFailure: () => _onFailure(context),
        ));
  }

  void _onSuccess(BuildContext context) {
    context.read<DisplayBloc>().add(const DisplayDoneDisplayed());
  }

  void _onFailure(BuildContext context) {
    context.read<DisplayBloc>().add(const DisplayFailedDisplayed());
  }

  void _onPlayerStopped(BuildContext context) {
    context.read<DisplayBloc>().add(const DisplayHomeDisplayed());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        CaseButtonsRow(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 16.0,
          ),
          caseButtonsData: [
            CaseButtonData(
              onPressed: () => _onConfirmPressed(context),
              icon: Icons.check_outlined,
              color: colorScheme.onPrimary,
              backgroundColor: Colors.green,
            ),
            CaseButtonData(
              onPressed: () => _onUpPressed(context),
              icon: Icons.keyboard_arrow_up_outlined,
              color: colorScheme.onSecondary,
              backgroundColor: colorScheme.secondary,
            ),
            CaseButtonData(
              onPressed: () => _onCancelPressed(context),
              icon: Icons.close_outlined,
              color: colorScheme.onPrimary,
              backgroundColor: Colors.red,
            ),
          ],
        ),
        CaseButtonsRow(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 16.0,
          ),
          caseButtonsData: [
            CaseButtonData(
              onPressed: () => _onLeftPressed(context),
              icon: Icons.keyboard_arrow_left_outlined,
              color: colorScheme.onSecondary,
              backgroundColor: colorScheme.secondary,
            ),
            CaseButtonData(
              onPressed: () => _onRecordPressed(context),
              onLongPress: () => _onRecordLongPress(context),
              icon: Icons.mic_outlined,
            ),
            CaseButtonData(
              onPressed: () => _onRightPressed(context),
              icon: Icons.keyboard_arrow_right_outlined,
              color: colorScheme.onSecondary,
              backgroundColor: colorScheme.secondary,
            ),
          ],
        ),
        CaseButtonsRow(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 16.0,
          ),
          caseButtonsData: [
            CaseButtonData(
              onPressed: () => _onPlayPressed(context),
              icon: Icons.play_arrow_outlined,
            ),
            CaseButtonData(
              onPressed: () => _onDownPressed(context),
              icon: Icons.keyboard_arrow_down_outlined,
              color: colorScheme.onSecondary,
              backgroundColor: colorScheme.secondary,
            ),
            CaseButtonData(
              onPressed: () => _onPausePressed(context),
              icon: Icons.pause_outlined,
            ),
          ],
        ),
        CaseButtonsRow(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 24.0,
          ),
          caseButtonsData: [
            CaseButtonData(
              onPressed: () => _onDeletePressed(context),
              icon: Icons.delete_outlined,
              color: colorScheme.onTertiary,
              backgroundColor: colorScheme.tertiary,
            ),
            CaseButtonData(
              onPressed: () => _onStopPressed(context),
              icon: Icons.stop_outlined,
            ),
            CaseButtonData(
              onPressed: () => _onParametersPressed(context),
              icon: Icons.settings_outlined,
              color: colorScheme.onTertiary,
              backgroundColor: colorScheme.tertiary,
            ),
          ],
        ),
      ],
    );
  }
}
