import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class DataSettingsPage extends StatelessWidget {
  const DataSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Provider.of<tg.ConnectionStateWidgetFactory>(context).create(
          context,
          (_) => Text(localizationManager.getString('DataSettings')),
        ),
      ),
      body: Center(
        child: Text(localizationManager.getString('DataSettings')),
      ),
    );
  }
}
