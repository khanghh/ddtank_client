package horseRace.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import hall.player.vo.PlayerVO;
   import horseRace.controller.HorseRaceManager;
   import horseRace.data.HorseRacePlayerInfo;
   import horseRace.events.HorseRaceEvents;
   import invite.InviteManager;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import road7th.comm.PackageIn;
   
   public class HorseRaceView extends Sprite implements Disposeable
   {
      
      public static const GAME_WIDTH:int = 1000;
       
      
      private var _backBg:Bitmap;
      
      private var _foreBg:MovieClip;
      
      private var racePlayerList:Array;
      
      private var racePlayerPos:FilterFrameText;
      
      private var racePlayerIntPosArr:Array;
      
      private var moreLen:int = 17;
      
      private var _selfPlayer:HorseRaceWalkPlayer;
      
      private var _playerInfoView:HorseRacePlayerInfoView;
      
      private var _msgView:HorseRaceMsgView;
      
      private var _buffView:HorseRaceBuffView;
      
      private var maxForeMapWidth:int = 40500;
      
      private var maxRaceLen:int = 40000;
      
      private var headLinePosX:int = 250;
      
      private var buffMsgTxt:FilterFrameText;
      
      private var canRanBySpeedToEND:Boolean = false;
      
      private var selfRanBySpeed:Boolean = false;
      
      private var forBgPos:Number;
      
      private var mycount:uint = 0;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var alert:BaseAlerFrame;
      
      private var canKeyDown:Boolean = true;
      
      private var keyShutTimer:Timer;
      
      private var serverTime:int;
      
      private var _first:Boolean = true;
      
      private var _tenCount:int = 0;
      
      private var gameId:int;
      
      public function HorseRaceView(){super();}
      
      private function startCountDown(param1:int) : void{}
      
      private function endCountDown(param1:int, param2:String, param3:Function) : void{}
      
      private function initView() : void{}
      
      private function addBuffMsg() : void{}
      
      private function createMap() : void{}
      
      private function startRace() : void{}
      
      private function _setTimer(param1:Timer) : void{}
      
      private function _setSelfCenter(param1:Event) : void{}
      
      private function _setOtherPlayerWithSelf(param1:Event) : void{}
      
      private function getPosArr(param1:String) : Array{return null;}
      
      public function addPlayer(param1:PlayerInfo, param2:int, param3:int) : void{}
      
      private function removePlayer(param1:int) : void{}
      
      private function removeAllPlayer() : void{}
      
      private function findPlayerByID(param1:int) : HorseRaceWalkPlayer{return null;}
      
      private function callBack(param1:HorseRaceWalkPlayer, param2:Boolean, param3:int) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function _use_pingzhang(param1:HorseRaceEvents) : void{}
      
      private function __onRecoverResponse(param1:FrameEvent) : void{}
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void{}
      
      private function _use_daoju(param1:HorseRaceEvents) : void{}
      
      private function __keyDown(param1:KeyboardEvent) : void{}
      
      private function _keyShut(param1:TimerEvent) : void{}
      
      private function _show_msg(param1:HorseRaceEvents) : void{}
      
      private function _buffItem_flush(param1:HorseRaceEvents) : void{}
      
      private function _synonesecond(param1:HorseRaceEvents) : void{}
      
      public function getRankByRaceLen() : void{}
      
      public function getRankByRaceLen2(param1:Array) : Array{return null;}
      
      private function _allRaceEnd(param1:HorseRaceEvents) : void{}
      
      private function _raceEnd(param1:HorseRaceEvents) : void{}
      
      private function _speedChange(param1:HorseRaceEvents) : void{}
      
      private function _beginRace(param1:HorseRaceEvents) : void{}
      
      private function _startFiveCountDown(param1:HorseRaceEvents) : void{}
      
      private function _initPlayerInfo(param1:HorseRaceEvents) : void{}
      
      private function initBuffView() : void{}
      
      private function initMsgView() : void{}
      
      private function initPlayerInfoView() : void{}
      
      public function dispose2() : void{}
      
      public function dispose() : void{}
   }
}
