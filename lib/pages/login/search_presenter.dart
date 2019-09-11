import '../../data/rest_data.dart';
import '../../model/user.dart';

abstract class SearchPageContract {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class SearchPagePresenter {
  SearchPageContract _view;
  RestData api = new RestData();
  SearchPagePresenter(this._view);

  doLogin(String name, String username) {
    api
      .search(name,username)
      .then((user) => _view.onLoginSuccess(user))
      .catchError((onError) => _view.onLoginError(onError));
  }
  
}
