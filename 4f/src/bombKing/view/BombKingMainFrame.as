package bombKing.view
{
   import bombKing.BombKingControl;
   import bombKing.BombKingManager;
   import bombKing.components.BKingLine;
   import bombKing.components.BKingPlayerItem;
   import bombKing.components.BKingPlayerTip;
   import bombKing.components.BKingbattleLogItem;
   import bombKing.data.BKingLogInfo;
   import bombKing.data.BKingPlayerInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import road7th.comm.PackageIn;
   
   public class BombKingMainFrame extends Frame
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 120;
       
      
      private var _bg:Bitmap;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _timeTxt:FilterFrameText;
      
      private var _rankBtn:SimpleBitmapButton;
      
      private var _rankTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _prizeBtn:SimpleBitmapButton;
      
      private var _ruleBtn:SimpleBitmapButton;
      
      private var _purpleIcon:Bitmap;
      
      private var _redIcon:Bitmap;
      
      private var _blueIcon:Bitmap;
      
      private var _firstName:FilterFrameText;
      
      private var _secondName:FilterFrameText;
      
      private var _thirdName:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _logVBox:VBox;
      
      private var _battleSoon:Bitmap;
      
      private var _remain:FilterFrameText;
      
      private var _firstStageInPlay:Bitmap;
      
      private var _secondStageInPlay:Bitmap;
      
      private var _finalStageInPlay:Bitmap;
      
      private var _rankFrame:BombKingRankFrame;
      
      private var _prizeFrame:BombKingPrizeFrame;
      
      private var _playerTips:BKingPlayerTip;
      
      private var _itemArr:Array;
      
      private var _lineArr:Array;
      
      private var _stampArr:Array;
      
      private var _itemDic:Dictionary;
      
      private var _lineDic:Dictionary;
      
      private var _rankDic:Dictionary;
      
      private var _top3InfoArr:Array;
      
      private var _top3NameArr:Array;
      
      private var _logArr:Array;
      
      private var _headImgArr:Array;
      
      private var _loaderArr:Array;
      
      private var _battleStage:int;
      
      private var _turn:int;
      
      private var _status:int;
      
      private var _battleEndDate:Date;
      
      private var _tipSprite:Component;
      
      private var nextTimer:Timer;
      
      private var remainTimer:Timer;
      
      public function BombKingMainFrame(){super();}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __waitGameRecv(param1:CrazyTankSocketEvent) : void{}
      
      protected function __waitGameFailed(param1:CrazyTankSocketEvent) : void{}
      
      protected function __playerItemClick(param1:MouseEvent) : void{}
      
      protected function __onStageClick(param1:MouseEvent) : void{}
      
      protected function __startBtnClick(param1:MouseEvent) : void{}
      
      protected function __rankBtnClick(param1:MouseEvent) : void{}
      
      protected function __prizeBtnClick(param1:MouseEvent) : void{}
      
      protected function __update(param1:PkgEvent) : void{}
      
      public function setDateOfNext() : void{}
      
      private function getTurnStr() : String{return null;}
      
      private function getDayStr(param1:int) : String{return null;}
      
      private function __characterComplete(param1:Event) : void{}
      
      private function setStartBtnStatus(param1:Date) : void{}
      
      protected function onNextTimer(param1:TimerEvent) : void{}
      
      private function fillZero(param1:int) : String{return null;}
      
      protected function onRemainTimer(param1:TimerEvent) : void{}
      
      private function fillRankDic(param1:Array) : void{}
      
      private function updateItems() : void{}
      
      protected function __updateRequest(param1:PkgEvent) : void{}
      
      protected function __battleLog(param1:PkgEvent) : void{}
      
      private function __startLoading(param1:Event) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
   }
}
