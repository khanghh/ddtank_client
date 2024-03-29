package email.view
{
   import baglocked.BaglockedManager;
   import baglocked.SetPassEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.email.EmailInfo;
   import ddt.data.email.EmailInfoOfSended;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.IMManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.common.LevelIcon;
   import ddtBuried.BuriedManager;
   import email.MailManager;
   import email.manager.MailControl;
   import feedback.FeedbackManager;
   import feedback.data.FeedbackInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import giftSystem.GiftManager;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   import socialContact.friendBirthday.FriendBirthdayManager;
   
   public class ReadingView extends Frame
   {
       
      
      private var _info:EmailInfo;
      
      private var _readOnly:Boolean;
      
      private var _isCanReply:Boolean;
      
      private var _readBG:MutipleImage;
      
      private var _readViewBg:MovieClip;
      
      private var _prompt:FilterFrameText;
      
      private var _senderTip:FilterFrameText;
      
      private var _topicTip:FilterFrameText;
      
      private var _sender:FilterFrameText;
      
      private var _topic:FilterFrameText;
      
      private var _content:TextArea;
      
      private var _personalImgBg:MovieImage;
      
      private var _leftTopBtnGroup:SelectedButtonGroup;
      
      private var _emailListButton:SelectedTextButton;
      
      private var _noReadButton:SelectedTextButton;
      
      private var _sendedButton:SelectedTextButton;
      
      private var _leftPageBtn:BaseButton;
      
      private var _rightPageBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _dianquanTxt:FilterFrameText;
      
      private var _selectAllBtn:TextButton;
      
      private var _deleteBtn:TextButton;
      
      private var _reciveMailBtn:TextButton;
      
      private var _reply_btn:TextButton;
      
      private var _close_btn:TextButton;
      
      private var _write_btn:TextButton;
      
      private var _help_btn:BaseButton;
      
      private var _diamonds:Array;
      
      private var _list:EmailListView;
      
      private var _diamondHBox:HBox;
      
      private var _addFriend:TextButton;
      
      private var _rebackGiftBtn:TextButton;
      
      private var _presentGiftBtn:TextButton;
      
      private var _playerview:RoomCharacter;
      
      private var _levelIcon:LevelIcon;
      
      private var _tempInfo:PlayerInfo;
      
      private const _PRESENTGIFT:int = 16;
      
      private var _complainBtn:TextButton;
      
      private var _complainAlert:BaseAlerFrame;
      
      private var _alertFrame:BaseAlerFrame;
      
      private var _sendBtn:TextButton;
      
      public function ReadingView(){super();}
      
      private function initView() : void{}
      
      private function addLeftTopBtnGroup() : void{}
      
      private function addEvent() : void{}
      
      private function __contentLinkHandler(param1:TextEvent) : void{}
      
      private function __contentRollOverHandler(param1:MouseEvent) : void{}
      
      private function payforfriendHander(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __complainhandler(param1:MouseEvent) : void{}
      
      protected function __frameResponse(param1:FrameEvent) : void{}
      
      public function set info(param1:EmailInfo) : void{}
      
      private function updateSended() : void{}
      
      private function setContentText(param1:*) : void{}
      
      private function update() : void{}
      
      private function upRebackGift() : void{}
      
      private function _upPresentGift() : void{}
      
      private function clearPersonalImage() : void{}
      
      private function prepareShow() : void{}
      
      private function showPersonal(param1:PlayerPropertyEvent) : void{}
      
      private function showBegain() : void{}
      
      private function showComplete() : void{}
      
      public function setListView(param1:Array, param2:int, param3:int, param4:Boolean = false) : void{}
      
      public function switchBtnsVisible(param1:Boolean) : void{}
      
      private function btnSound() : void{}
      
      public function set readOnly(param1:Boolean) : void{}
      
      function set isCanReply(param1:Boolean) : void{}
      
      private function closeWin() : void{}
      
      public function personalHide() : void{}
      
      override public function dispose() : void{}
      
      private function __selectMailTypeListener(param1:MouseEvent) : void{}
      
      private function __lastPage(param1:MouseEvent) : void{}
      
      private function __nextPage(param1:MouseEvent) : void{}
      
      private function __selectAllListener(param1:MouseEvent) : void{}
      
      private function __deleteSelectListener(param1:MouseEvent) : void{}
      
      private function hightGoods(param1:Array) : Boolean{return false;}
      
      private function __cancelBtn(param1:SetPassEvent) : void{}
      
      private function showAlert() : void{}
      
      private function disposeAlert() : void{}
      
      private function __simpleAlertResponse(param1:FrameEvent) : void{}
      
      private function cancel() : void{}
      
      private function ok() : void{}
      
      private function __receiveExListener(param1:MouseEvent) : void{}
      
      private function __reply(param1:MouseEvent) : void{}
      
      private function __close(param1:MouseEvent) : void{}
      
      private function __write(param1:MouseEvent) : void{}
      
      private function __addFriend(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      protected function __rebackGift(param1:MouseEvent) : void{}
      
      private function _clickPresent(param1:MouseEvent) : void{}
   }
}
