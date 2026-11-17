import 'package:flutter/material.dart';

import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';

import '../../domain/entities/education_activity.dart';
import '../viewmodels/education_activity_view_model.dart';
import '../widgets/detail_aktivitas_template.dart';

/// Halaman detail aktivitas "Penelitian Lapangan".
class PenelitianPage extends StatefulWidget {
  const PenelitianPage({super.key});

  @override
  State<PenelitianPage> createState() => _PenelitianPageState();
}

class _PenelitianPageState extends State<PenelitianPage> {
  late final EducationActivityViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createEducationActivityViewModel(
      EducationActivityType.penelitian,
    )..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        final activity = _viewModel.activity;
        if (activity == null) {
          return const Scaffold(
            backgroundColor: kBgColor,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return DetailAktivitasTemplate(data: activity);
      },
    );
  }
}
