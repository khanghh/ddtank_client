package catchbeast.view
{
   import baglocked.BaglockedManager;
   import catchbeast.CatchBeastControl;
   import catchbeast.CatchBeastManager;
   import catchbeast.date.CatchBeastInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import road7th.comm.PackageIn;
   import store.HelpFrame;
   
   public class CatchBeastView extends Frame
   {
      
      private static var AWARD_NUM:int = 5;
       
      
      private var _progressInfo:Array;
      
      private var _bg:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private var _challengeBtn:BaseButton;
      
      private var _challengeNumText:FilterFrameText;
      
      private var _buyBuffBtn:BaseButton;
      
      private var _buyBuffNumText:FilterFrameText;
      
      private var _beastMovie:MovieImage;
      
      private var _progress:ScaleFrameImage;
      
      private var _progressSense:Sprite;
      
      private var _progressTips:OneLineTip;
      
      private var _damageInfo:FilterFrameText;
      
      private var _progressMask:Sprite;
      
      private var _careInfo:FilterFrameText;
      
      private var _getAwardVec:Vector.<MovieImage>;
      
      private var _info:CatchBeastInfo;
      
      public function CatchBeastView(){super();}
      
      private function initView() : void{}
      
      private function createProgressSense() : void{}
      
      private function createProgressMask() : void{}
      
      private function setProgressLength(param1:int) : void{}
      
      private function initEvent() : void{}
      
      protected function __onHelpClick(param1:MouseEvent) : void{}
      
      private function __startLoading(param1:Event) : void{}
      
      protected function __onSetViewInfo(param1:CrazyTankSocketEvent) : void{}
      
      private function setProgressTipNum(param1:int) : void{}
      
      private function setAwardBoxState() : void{}
      
      protected function __onGetAward(param1:MouseEvent) : void{}
      
      protected function __onIsGetAward(param1:CrazyTankSocketEvent) : void{}
      
      private function setAwardBoxInfo(param1:int) : InventoryItemInfo{return null;}
      
      protected function __onProgressOver(param1:MouseEvent) : void{}
      
      protected function __onProgressOut(param1:MouseEvent) : void{}
      
      protected function __onBuyBuffClick(param1:MouseEvent) : void{}
      
      protected function __onIsBuyBuff(param1:CrazyTankSocketEvent) : void{}
      
      protected function __onChallengeClick(param1:MouseEvent) : void{}
      
      protected function __alertChallenge(param1:FrameEvent) : void{}
      
      private function sendPkg() : void{}
      
      public function show() : void{}
      
      private function removeEvent() : void{}
      
      protected function __alertBuyBuff(param1:FrameEvent) : void{}
      
      private function onResponseHander(param1:FrameEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function checkMoney(param1:Boolean) : Boolean{return false;}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
