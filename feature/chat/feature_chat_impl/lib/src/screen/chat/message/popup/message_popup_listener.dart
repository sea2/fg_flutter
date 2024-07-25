import 'message_popup_menu.dart';

abstract class IMessagePopupMenuListener {
  void onWillShowPopupMenu(int messageId, IMessagePopupMenu popupMenu);
  void onItemSelected(int messageId, ItemAction item);
}
