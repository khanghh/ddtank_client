package im
{
   import academy.AcademyManager;
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.Base64;
   import com.pickgliss.utils.MD5;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperBuyAlert;
   import ddt.view.PlayerPortraitView;
   import ddt.view.common.LevelIcon;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   import oldplayerintegralshop.IntegralShopController;
   import road7th.comm.PackageIn;
   import road7th.utils.StringHelper;
   import team.TeamManager;
   import team.event.TeamEvent;
   import vip.VipController;
   
   public class IMView extends Frame
   {
      
      private static const ALL_STATE:Array = [new PlayerState(1,1),new PlayerState(2,1),new PlayerState(3,1),new PlayerState(5,1),new PlayerState(4,1),new PlayerState(6,1)];
      
      public static const FRIEND_LIST:int = 0;
      
      public static const CMFRIEND_LIST:int = 2;
      
      public static const CONSORTIA_LIST:int = 1;
      
      public static const LIKEFRIEND_LIST:int = 3;
      
      public static const TEAM_LIST:int = 2;
       
      
      private var _IMSelectedBtn:SelectedTextButton;
      
      private var _likePersonSelectedBtn:SelectedTextButton;
      
      private var _addBlackFrame:AddBlackFrame;
      
      private var _addBleak:TextButton;
      
      private var _addFriend:TextButton;
      
      private var _myAcademyBtn:TextButton;
      
      private var _teamList:TeamListView;
      
      private var _inviteBtn:TextButton;
      
      private var _teamListBtn:SelectedTextButton;
      
      private var _addFriendFrame:AddFriendFrame;
      
      private var _bg:MutipleImage;
      
      private var _consortiaListBtn:SelectedTextButton;
      
      private var _levelIcon:LevelIcon;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _currentListType:int;
      
      private var _friendList:IMListView;
      
      private var _consortiaList:ConsortiaListView;
      
      private var _CMfriendList:CMFriendList;
      
      private var _likeFriendList:LikeFriendListView;
      
      private var _listContent:Sprite;
      
      private var _selfName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _playerPortrait:PlayerPortraitView;
      
      private var _imLookupView:IMLookupView;
      
      private var _stateSelectBtn:StateIconButton;
      
      private var _stateList:DropList;
      
      private var _replyInput:AutoReplyInput;
      
      private var _state:FilterFrameText;
      
      private var _uploadGirlHeadPhotoBtn:SimpleBitmapButton;
      
      private var _selectGirlHeadPhotoBtn:SimpleBitmapButton;
      
      private var _hBox:HBox;
      
      private var _integralShop:SimpleBitmapButton;
      
      public function IMView(){super();}
      
      private function initContent() : void{}
      
      private function canUploadGirlHeadPhoto() : Boolean{return false;}
      
      private function initEvent() : void{}
      
      private function __teamListBtnClick(param1:MouseEvent) : void{}
      
      private function showTeamIM(param1:TeamEvent) : void{}
      
      protected function onHeadSelectChange(param1:CEvent) : void{}
      
      protected function onChangeBtnClick(param1:MouseEvent) : void{}
      
      private function onUseNewPic() : void{}
      
      private function onUseGirlNewPhoto(param1:PkgEvent) : void{}
      
      private function onGirlHeadSelected(param1:Boolean) : void{}
      
      private function onGirlHeadClose() : void{}
      
      protected function onUploadBtnClick(param1:MouseEvent) : void{}
      
      private function openUploadSite() : void{}
      
      protected function __onIntegralShop(param1:MouseEvent) : void{}
      
      private function __CMBtnClick(param1:MouseEvent) : void{}
      
      private function __CMFriendLoadComplete(param1:Event) : void{}
      
      private function __IMBtnClick(param1:MouseEvent) : void{}
      
      private function __inviteBtnClick(param1:MouseEvent) : void{}
      
      private function __consortiaListBtnClick(param1:MouseEvent) : void{}
      
      private function __likeBtnClick(param1:MouseEvent) : void{}
      
      private function __addBleakBtnClick(param1:MouseEvent) : void{}
      
      private function __buttonGroupChange(param1:Event) : void{}
      
      private function __myAcademyClick(param1:MouseEvent) : void{}
      
      private function __addFriendBtnClick(param1:MouseEvent) : void{}
      
      private function showFigure() : void{}
      
      private function setListType() : void{}
      
      private function copyGirlHeadDataByList(param1:Array, param2:Array) : void{}
      
      private function __giftClick(param1:MouseEvent) : void{}
      
      private function __onStateChange(param1:PlayerPropertyEvent) : void{}
      
      private function __hideStateList(param1:MouseEvent) : void{}
      
      private function __stateSelectClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
