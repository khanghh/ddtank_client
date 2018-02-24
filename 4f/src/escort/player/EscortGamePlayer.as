package escort.player
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import escort.EscortControl;
   import escort.EscortManager;
   import escort.data.EscortCarInfo;
   import escort.data.EscortPlayerInfo;
   import escort.event.EscortEvent;
   import escort.view.EscortBuffCountDownView;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class EscortGamePlayer extends Sprite implements Disposeable
   {
       
      
      private var _playerInfo:EscortPlayerInfo;
      
      private var _playerMc:MovieClip;
      
      private var _destinationX:int;
      
      private var _carInfo:EscortCarInfo;
      
      private var _moveTimer:Timer;
      
      private var _nameTxt:FilterFrameText;
      
      private var _buffCountDownList:DictionaryData;
      
      private var _isDispose:Boolean = false;
      
      private var _fightMc:MovieClip;
      
      private var _leapArrow:Bitmap;
      
      public function EscortGamePlayer(param1:EscortPlayerInfo){super();}
      
      public function get playerInfo() : EscortPlayerInfo{return null;}
      
      public function set destinationX(param1:Number) : void{}
      
      private function loadRes() : void{}
      
      private function onLoadComplete(param1:LoaderEvent) : void{}
      
      private function moveTimerHandler(param1:TimerEvent) : void{}
      
      private function showOrHideLeapArrow(param1:EscortEvent) : void{}
      
      public function refreshBuffCountDown() : void{}
      
      private function buffCountDownEnd(param1:Event) : void{}
      
      public function updatePlayer() : void{}
      
      public function refreshFightMc() : void{}
      
      public function startGame() : void{}
      
      public function endGame() : void{}
      
      public function dispose() : void{}
   }
}
