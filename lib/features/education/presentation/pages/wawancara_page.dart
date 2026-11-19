import 'package:flutter/material.dart';

import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';

import '../../domain/entities/education_activity.dart';
import '../viewmodels/education_activity_view_model.dart';
import '../widgets/education_detail_layout.dart';

/// Halaman detail aktivitas "Wawancara Petani".
class WawancaraPage extends StatefulWidget {
  const WawancaraPage({super.key});

  @override
  State<WawancaraPage> createState() => _WawancaraPageState();
}

class _WawancaraPageState extends State<WawancaraPage> {
  late final EducationActivityViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createEducationActivityViewModel(
      EducationActivityType.wawancara,
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
        return EducationDetailLayout(
          data: activity,
          priceFormatted: _viewModel.hargaFormatted,
          activitySectionTitle: 'Aktivitas',
        );
      },
    );
  }
}
