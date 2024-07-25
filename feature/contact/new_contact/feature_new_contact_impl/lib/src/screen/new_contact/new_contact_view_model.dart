import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:contacts_manager_api/contacts_manager_api.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_presentation/core_presentation.dart';
import 'package:core_utils/core_utils.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_router.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:user_info/user_info.dart';

import 'args.dart';
import 'new_contact_state.dart';

@j.singleton
@j.disposable
class NewContactViewModel extends BaseViewModel {
  @j.inject
  NewContactViewModel({
    required Args args,
    required INewContactRouter router,
    required IStringsProvider stringsProvider,
    required IBlockInteractionManager blockInteractionManager,
    required UserInfoResolver userInfoResolver,
    required IErrorTransformer errorTransformer,
    required IContactsManager contactsManager,
  })  : _router = router,
        _args = args,
        _errorTransformer = errorTransformer,
        _contactsManager = contactsManager,
        _userInfoResolver = userInfoResolver,
        _stringsProvider = stringsProvider,
        _blockInteractionManager = blockInteractionManager {
    subscribe(
      _userInfoResolver.resolveAsStream(_args.userId),
      _onNewUserInfo,
    );
  }

  final Args _args;
  final INewContactRouter _router;
  final IBlockInteractionManager _blockInteractionManager;
  final UserInfoResolver _userInfoResolver;
  final IStringsProvider _stringsProvider;
  final IContactsManager _contactsManager;
  final IErrorTransformer _errorTransformer;

  UserInfo? _userInfo;

  final BehaviorSubject<NewContactState> _stateSubject =
      BehaviorSubject<NewContactState>.seeded(const NewContactState.loading());

  Stream<NewContactState> get state => _stateSubject;

  void onDoneTap({
    required String firstName,
    required String lastName,
    required bool shareMyNumber,
  }) {
    final UserInfo? info = _userInfo;
    if (firstName.isEmpty || info == null) {
      return;
    }
    _addContact(
      td.Contact(
        phoneNumber: info.user.phoneNumber,
        firstName: firstName,
        lastName: lastName,
        userId: _args.userId,
        vcard: '',
      ),
      shareMyNumber,
    );
  }

  @override
  void dispose() {
    _stateSubject.close();
    super.dispose();
  }

  void _onNewUserInfo(UserInfo info) {
    _userInfo = info;
    _stateSubject.add(
      NewContactState.data(
        userInformation: UserInformation(
          firstName: info.user.firstName,
          lastNameName: info.user.lastName,
          avatar: Avatar.simple(
            abbreviation: getAvatarAbbreviation(
              first: info.user.firstName,
              second: info.user.lastName,
            ),
            objectId: info.user.id,
            imageFileId: info.user.profilePhoto?.small.id,
          ),
          onlineStatus: info.statusHumanString,
          phoneNumber: info.user.phoneNumber.isNotEmpty
              ? info.user.phoneNumber
              : _stringsProvider.mobileHidden,
        ),
      ),
    );
  }

  void _addContact(td.Contact contact, bool sharePhoneNumber) {
    _blockInteractionManager.setState(active: true);
    final CancelableOperation<void> operation = _contactsManager
        .addContact(contact: contact, sharePhoneNumber: sharePhoneNumber)
        .toCancelableOperation()
        .onTerminate(() {
      _blockInteractionManager.setState(active: false);
    }).onError((Object error) {
      _router.toDialog(
        body: d.Body.text(
          text: _errorTransformer.transformToString(error),
        ),
        actions: <d.Action>[
          d.Action(text: _stringsProvider.oK),
        ],
      );
    }).onValue((void value) {
      _router.close();
    });
    attach(operation);
  }
}

class UserInformation {
  const UserInformation({
    required this.avatar,
    required this.phoneNumber,
    required this.onlineStatus,
    required this.firstName,
    required this.lastNameName,
  });

  final Avatar avatar;

  final String phoneNumber;
  final String onlineStatus;

  final String firstName;
  final String lastNameName;
}
