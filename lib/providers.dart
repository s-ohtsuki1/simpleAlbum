import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'viewmodel/add_or_edit/add_or_edit_model.dart';
import 'viewmodel/album_detail/album_detail_model.dart';
import 'viewmodel/album_list/album_list_model.dart';
import 'viewmodel/forgot_password/forgot_password_model.dart';
import 'viewmodel/sign_in/sign_in_model.dart';
import 'viewmodel/sign_up/sign_up_model.dart';

class Providers {
  List<SingleChildWidget> get useProviders {
    return [
      ChangeNotifierProvider<SignInModel>(
        create: (_) => SignInModel(),
      ),
      ChangeNotifierProvider<SignUpModel>(
        create: (_) => SignUpModel(),
      ),
      ChangeNotifierProvider<AlbumListModel>(
        create: (_) => AlbumListModel(),
      ),
      ChangeNotifierProvider<AlbumDetailModel>(
        create: (_) => AlbumDetailModel(),
      ),
      ChangeNotifierProvider<AddOrEditModel>(
        create: (_) => AddOrEditModel(),
      ),
      ChangeNotifierProvider<ForgotPasswordModel>(
        create: (_) => ForgotPasswordModel(),
      ),
    ];
  }
}
