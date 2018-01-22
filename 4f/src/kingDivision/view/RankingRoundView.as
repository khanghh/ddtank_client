package kingDivision.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kingDivision.KingDivisionManager;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   
   public class RankingRoundView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _winBg:Bitmap;
      
      private var _proBar:ProgressBarView;
      
      private var _points:FilterFrameText;
      
      private var _awardsBtn:BaseButton;
      
      private var _numberImg:Bitmap;
      
      private var _numberTxt:FilterFrameText;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _cup:Bitmap;
      
      private var _base:Bitmap;
      
      private var _info:PlayerInfo;
      
      private var _character:RoomCharacter;
      
      private var _fireWorkds:MovieClip;
      
      private var _zone:int;
      
      private var _kingImg:Bitmap;
      
      private var _kingBase:Bitmap;
      
      private var _kingTxt:GradientText;
      
      private var _items:Vector.<KingCell>;
      
      private var _itemsEight:Vector.<KingCell>;
      
      private var _itemsFour:Vector.<KingCell>;
      
      private var _itemsTwo:Vector.<KingCell>;
      
      private var _blind:Bitmap;
      
      private var _match:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _timerUpdate:Timer;
      
      private var eliminateInfo:Vector.<KingDivisionConsortionItemInfo>;
      
      private var eliminateAllZoneInfo:Vector.<KingDivisionConsortionItemInfo>;
      
      private var isWin:Boolean;
      
      private var index:int = 0;
      
      private var isConsortiaID:Boolean;
      
      private var _areaStyle:String;
      
      private var _areaSex:Boolean;
      
      private var _areaConsortionName:String;
      
      private var isCheckTime:Boolean;
      
      public function RankingRoundView(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onStartBtnClick(param1:MouseEvent) : void{}
      
      private function startGame() : void{}
      
      private function __onCancelBtnClick(param1:MouseEvent) : void{}
      
      public function cancelMatch() : void{}
      
      private function playerIsConsortion() : void{}
      
      public function updateMessage(param1:int, param2:int) : void{}
      
      private function __timer(param1:TimerEvent) : void{}
      
      public function updateButtons() : void{}
      
      private function createCell(param1:int, param2:int) : void{}
      
      public function set progressBarView(param1:ProgressBarView) : void{}
      
      public function set zone(param1:int) : void{}
      
      private function updateCell() : void{}
      
      private function promotion(param1:Vector.<KingDivisionConsortionItemInfo>) : void{}
      
      private function topSixteen(param1:Vector.<KingDivisionConsortionItemInfo>) : void{}
      
      private function topSixteenArea(param1:Vector.<KingDivisionConsortionItemInfo>) : void{}
      
      private function promotionGuild(param1:Vector.<KingCell>, param2:Vector.<KingCell>, param3:int, param4:int, param5:int) : void{}
      
      private function promotionGuildArea(param1:Vector.<KingCell>, param2:Vector.<KingCell>, param3:int, param4:int, param5:int) : void{}
      
      private function topOne() : void{}
      
      private function topOneArea() : void{}
      
      public function setDateStages(param1:Array) : void{}
      
      private function __onClickAwardsBtn(param1:MouseEvent) : void{}
      
      private function setPlayerInfo(param1:String) : void{}
      
      private function __playerInfoChange(param1:PlayerPropertyEvent) : void{}
      
      private function updateCharacter() : void{}
      
      private function championMC() : void{}
      
      private function rankNoMeConsortion() : void{}
      
      private function __updateConsortionMessage(param1:TimerEvent) : void{}
      
      private function checkGameStartTimer() : void{}
      
      public function dispose() : void{}
   }
}
