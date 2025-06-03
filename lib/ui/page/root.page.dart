import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter_guiritter/common/_import.dart' show MIMEType;
import 'package:flutter_guiritter/model/_import.dart' show InitModel;
import 'package:flutter_guiritter/ui/page/_import.dart' show SplashPage;
import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:poker_calculator/common/_import.dart' show AppLocalizations;
import 'package:poker_calculator/theme/_import.dart'
    show circularProgressIndicatorColor;
import 'package:poker_calculator/ui/page/_import.dart' show TabsPage;

final _log = logger('RootPage');

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      StoreConnector<Map<String, dynamic>, InitModel<AppLocalizations>>(
        distinct: true,
        converter: InitModel.select,
        builder: connectorBuilder,
      );

  Widget connectorBuilder(
    BuildContext context,
    InitModel<AppLocalizations> initModel,
  ) {
    _log('connectorBuilder').map('initModel', initModel).print();

    return initModel.isL10nLoaded
        ? TabsPage()
        : SplashPage(
            backgroundMimeType: MIMEType.imagePng,
            backgroundAssetName: 'asset/Felt_of_wool_and_rayon_flax.png',
            backgroundSemanticsLabel:
                'logo background: photo of a piece of yellow felt',
            logoMimeType: MIMEType.imageSvgXml,
            logoAssetName: 'asset/logo.svg',
            logoSemanticsLabel:
                'logo representing a calculator where the buttons are card suits, a chip and a gold bar and the display shows "All-in"',
            circularProgressIndicatorColor: circularProgressIndicatorColor,
          );
  }
}
