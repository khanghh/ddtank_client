package dragonBoat.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ServerConfigInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.BagEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import dragonBoat.DragonBoatManager;
   import dragonBoat.event.DragonBoatEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import store.HelpFrame;
   
   public class DragonBoatFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _leftDragonBoatSprite:Sprite;
      
      private var _leftPlayerSprite:Sprite;
      
      private var _dragonboatBg:Bitmap;
      
      private var _selfRankBg:Bitmap;
      
      private var _otherRankBg:Bitmap;
      
      private var _smallBorder:Bitmap;
      
      private var _progressBg:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _progressMask:Bitmap;
      
      private var _selfRankSelectedBtn:SelectedButton;
      
      private var _otherRankSelectedBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _selfRankSprite:Sprite;
      
      private var _otherRankSprite:Sprite;
      
      private var _normalDecorateBtn:SimpleBitmapButton;
      
      private var _highDecorateBtn:SimpleBitmapButton;
      
      private var _normalBuildBtn:SimpleBitmapButton;
      
      private var _highBuildBtn:SimpleBitmapButton;
      
      private var _scoreExchangeBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _progressTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _itemCountTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _scoreTxt2:FilterFrameText;
      
      private var _rankTxt:FilterFrameText;
      
      private var _needTxt:FilterFrameText;
      
      private var _leftBottomTxt:FilterFrameText;
      
      private var _rightBottomTxt:FilterFrameText;
      
      private var _selfRankList:ListPanel;
      
      private var _otherRankList:ListPanel;
      
      private var _selfDataList:Array;
      
      private var _selfRank:String = "";
      
      private var _selfLessScore:String = "";
      
      private var _otherDataList:Array;
      
      private var _otherRank:String = "";
      
      private var _otherLessScore:String = "";
      
      private var _timer:Timer;
      
      private var _displayMc:MovieClip;
      
      private var _dragonBoatLeftCurrentCharcter:DragonBoatLeftCurrentCharcter;
      
      private var type:int;
      
      private var _playerInfo:PlayerInfo;
      
      public function DragonBoatFrame(){super();}
      
      public function init2(param1:int) : void{}
      
      private function initView() : void{}
      
      private function initTimer() : void{}
      
      private function timerHander(param1:TimerEvent) : void{}
      
      private function refreshView() : void{}
      
      private function refreshBtnStatus(param1:Boolean, param2:Boolean) : void{}
      
      private function refreshItemCount() : void{}
      
      private function initEvent() : void{}
      
      private function updateRankInfo(param1:DragonBoatEvent) : void{}
      
      private function refreshRankView(param1:int) : void{}
      
      private function openShopFrame(param1:MouseEvent) : void{}
      
      private function openHelpFrame(param1:MouseEvent) : void{}
      
      private function refreshBoatStatusHandler(param1:Event) : void{}
      
      private function itemUpdateHandler(param1:BagEvent) : void{}
      
      private function buildOrDecorateHandler(param1:Event) : void{}
      
      private function consumeHandler(param1:Event) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function __soundPlay(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function isShowDragonboat(param1:Boolean) : void{}
      
      private function showPlayerNo1() : void{}
      
      private function __playerInfoChange(param1:PlayerPropertyEvent) : void{}
      
      private function initPlayerNo1() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
