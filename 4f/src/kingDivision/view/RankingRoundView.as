package kingDivision.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.RoomCharacter;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import kingDivision.KingDivisionManager;   import kingDivision.data.KingDivisionConsortionItemInfo;      public class RankingRoundView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _winBg:Bitmap;            private var _proBar:ProgressBarView;            private var _points:FilterFrameText;            private var _awardsBtn:BaseButton;            private var _numberImg:Bitmap;            private var _numberTxt:FilterFrameText;            private var _startBtn:SimpleBitmapButton;            private var _cancelBtn:SimpleBitmapButton;            private var _cup:Bitmap;            private var _base:Bitmap;            private var _info:PlayerInfo;            private var _character:RoomCharacter;            private var _fireWorkds:MovieClip;            private var _zone:int;            private var _kingImg:Bitmap;            private var _kingBase:Bitmap;            private var _kingTxt:GradientText;            private var _items:Vector.<KingCell>;            private var _itemsEight:Vector.<KingCell>;            private var _itemsFour:Vector.<KingCell>;            private var _itemsTwo:Vector.<KingCell>;            private var _blind:Bitmap;            private var _match:Bitmap;            private var _timeTxt:FilterFrameText;            private var _timer:Timer;            private var _timerUpdate:Timer;            private var eliminateInfo:Vector.<KingDivisionConsortionItemInfo>;            private var eliminateAllZoneInfo:Vector.<KingDivisionConsortionItemInfo>;            private var isWin:Boolean;            private var index:int = 0;            private var isConsortiaID:Boolean;            private var _areaStyle:String;            private var _areaSex:Boolean;            private var _areaConsortionName:String;            private var isCheckTime:Boolean;            public function RankingRoundView() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __onStartBtnClick(evt:MouseEvent) : void { }
            private function startGame() : void { }
            private function __onCancelBtnClick(evt:MouseEvent) : void { }
            public function cancelMatch() : void { }
            private function playerIsConsortion() : void { }
            public function updateMessage(score:int, gameNum:int) : void { }
            private function __timer(evt:TimerEvent) : void { }
            public function updateButtons() : void { }
            private function createCell(round:int, count:int) : void { }
            public function set progressBarView(value:ProgressBarView) : void { }
            public function set zone(value:int) : void { }
            private function updateCell() : void { }
            private function promotion(info:Vector.<KingDivisionConsortionItemInfo>) : void { }
            private function topSixteen(eliminateInfo:Vector.<KingDivisionConsortionItemInfo>) : void { }
            private function topSixteenArea(info:Vector.<KingDivisionConsortionItemInfo>) : void { }
            private function promotionGuild(cell:Vector.<KingCell>, proCell:Vector.<KingCell>, state:int, num:int, linkName:int) : void { }
            private function promotionGuildArea(cell:Vector.<KingCell>, proCell:Vector.<KingCell>, state:int, num:int, linkName:int) : void { }
            private function topOne() : void { }
            private function topOneArea() : void { }
            public function setDateStages(arr:Array) : void { }
            private function __onClickAwardsBtn(evt:MouseEvent) : void { }
            private function setPlayerInfo(nickName:String) : void { }
            private function __playerInfoChange(event:PlayerPropertyEvent) : void { }
            private function updateCharacter() : void { }
            private function championMC() : void { }
            private function rankNoMeConsortion() : void { }
            private function __updateConsortionMessage(evt:TimerEvent) : void { }
            private function checkGameStartTimer() : void { }
            public function dispose() : void { }
   }}