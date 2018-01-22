package horseRace.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import hall.player.vo.PlayerPetsInfo;
   import hall.player.vo.PlayerVO;
   import horseRace.controller.HorseRaceManager;
   import invite.InviteManager;
   
   public class HorseRaceMatchView extends Frame
   {
      
      public static var petsDisInfo:PlayerPetsInfo;
       
      
      private var _bg:Bitmap;
      
      private var _helpTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _startBnt:SimpleBitmapButton;
      
      private var _countDown:int = 0;
      
      private var _timer:Timer;
      
      private var _matchTxt:Bitmap;
      
      private var walkingPlayer:HorseRaceWalkPlayer;
      
      private var _buyCountTxt:FilterFrameText;
      
      private var _buyCount:int = 5;
      
      private var _buyBnt:BaseButton;
      
      private var rewardBox:HBox;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var alert:BaseAlerFrame;
      
      public function HorseRaceMatchView(){super();}
      
      private function initView() : void{}
      
      private function setRewardToList() : void{}
      
      public function reflushHorseRaceTime() : void{}
      
      private function callBack(param1:HorseRaceWalkPlayer, param2:Boolean, param3:int) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function _onBuyCountClick(param1:MouseEvent) : void{}
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void{}
      
      private function __onRecoverResponse(param1:FrameEvent) : void{}
      
      private function _startClick(param1:MouseEvent) : void{}
      
      private function _onCancel(param1:MouseEvent) : void{}
      
      private function cancelMatchHandler(param1:FrameEvent) : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      public function dispose2() : void{}
      
      override public function dispose() : void{}
   }
}
