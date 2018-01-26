package ddt.view.tips
{
   import academy.AcademyManager;
   import bagAndInfo.info.PlayerInfoViewControl;
   import baglocked.BaglockedManager;
   import church.ChurchManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.GridBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.ChatManager;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.PlayerPortraitView;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.im.IMFriendPhotoCell;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.system.System;
   import flash.utils.Timer;
   import giftSystem.GiftManager;
   import im.MarkFrame;
   import room.RoomManager;
   import vip.VipController;
   
   public class PlayerTip extends Sprite implements Disposeable
   {
      
      public static const CHALLENGE:String = "challenge";
      
      public static const X_MARGINAL:int = 10;
      
      public static const Y_MARGINAL:int = 20;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var btnChallenge:IconButton;
      
      private var _chanllageEnable:Boolean = false;
      
      private var _currentData:Object;
      
      private var _info:BasePlayer;
      
      private var _btnAddFriend:IconButton;
      
      private var _btnCopyName:IconButton;
      
      private var _btnDemote:TextButton;
      
      private var _btnExpel:TextButton;
      
      private var _btnInvite:TextButton;
      
      private var _btnPromote:TextButton;
      
      private var _btnPresentGift:IconButton;
      
      private var _btnPrivateChat:IconButton;
      
      private var _btnMark:IconButton;
      
      private var _btnPropose:BaseButton;
      
      private var _btnViewInfo:IconButton;
      
      private var _btnAcademy:IconButton;
      
      private var _One_one_chat:IconButton;
      
      private var _transferFriend:IconButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _clubTxt:FilterFrameText;
      
      private var _iconBtnsContainer:GridBox;
      
      private var _headPhoto:PlayerPortraitView;
      
      private var _bottomBtnsContainer:Sprite;
      
      private var _bottomBg:Bitmap;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _photo:IMFriendPhotoCell;
      
      private var _friendGroup:FriendGroupTip;
      
      private var _timer:Timer;
      
      private var _friendOver:Boolean = false;
      
      public function PlayerTip(){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      protected function __groupAddToStage(param1:Event) : void{}
      
      protected function __friendClickHandler(param1:MouseEvent) : void{}
      
      protected function __friendOverHandler(param1:MouseEvent) : void{}
      
      protected function __friendOutHandler(param1:MouseEvent) : void{}
      
      protected function __timerHandler(param1:TimerEvent) : void{}
      
      protected function __overHandler(param1:MouseEvent) : void{}
      
      protected function __outHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
      
      public function hide() : void{}
      
      public function get info() : BasePlayer{return null;}
      
      public function set playerInfo(param1:BasePlayer) : void{}
      
      public function proposeEnable(param1:Boolean) : void{}
      
      public function setSelfDisable(param1:Boolean) : void{}
      
      private function checkShowPresent() : Boolean{return false;}
      
      public function show(param1:int) : void{}
      
      public function update() : void{}
      
      private function __buttonsClick(param1:MouseEvent) : void{}
      
      private function requestApprentice() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __mouseClick(param1:Event) : void{}
      
      private function __onPropChange(param1:PlayerPropertyEvent) : void{}
      
      private function __sendBandChat(param1:MouseEvent) : void{}
      
      private function __sendNoBandChat(param1:MouseEvent) : void{}
      
      private function ok() : void{}
   }
}
