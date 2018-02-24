package happyLittleGame.bombshellGame.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import happyLittleGame.bombshellGame.item.BombGameBullet;
   import happyLittleGame.bombshellGame.item.BombVo;
   import times.utils.timerManager.TimerJuggler;
   import uiModeManager.bombUI.BombState;
   import uiModeManager.bombUI.BulletDirection;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class BombLogic extends Sprite implements Disposeable
   {
       
      
      private var bulletPool:Array;
      
      private var bombPool:Array;
      
      private var willbombvo:Array;
      
      private var showbomb:Array;
      
      private var _currentGameType:int;
      
      public var callBack:Function;
      
      public var scoreCallBack:Function;
      
      private var _timer:TimerJuggler;
      
      private var _isSendMapdata:Boolean = false;
      
      private var _mcComplete:Boolean = false;
      
      private var _timerNum:int = 10;
      
      private var _timerTemp:int = 0;
      
      public var showServerScore:Function;
      
      private var _checkallBomb:Boolean = false;
      
      public var checkNextBomb:Boolean = false;
      
      public var gameover:Function;
      
      public var gameNext:Function;
      
      public var gameStepSub:Function;
      
      public var gameStepAdd:Function;
      
      public var gameBtnClick:Function;
      
      private var stepMirror:int = 0;
      
      private var _currentClickVo:BombVo;
      
      private var senddata:Array;
      
      private var bombinfo:Array;
      
      private var _stepPreCount:int;
      
      public var showPassMc:Function;
      
      private var isShowPassMc:Boolean = false;
      
      public function BombLogic(){super();}
      
      public function get checkallBomb() : Boolean{return false;}
      
      public function set checkallBomb(param1:Boolean) : void{}
      
      public function get currentGameType() : int{return 0;}
      
      public function set currentGameType(param1:int) : void{}
      
      private function initEvent() : void{}
      
      public function removeEvent() : void{}
      
      private function CheckBombNextLv() : Boolean{return false;}
      
      private function __enterFrameHandler(param1:Event) : void{}
      
      private function checkMapHasBomb() : Boolean{return false;}
      
      private function CheckBulletHit(param1:BombGameBullet) : Boolean{return false;}
      
      private function GetHitBombVo(param1:int, param2:int, param3:int) : BombVo{return null;}
      
      private function initPool() : void{}
      
      private function initBomb() : void{}
      
      private function __clickhandler(param1:Event) : void{}
      
      private function clearBombInfo() : void{}
      
      public function sendCurrenMapdata() : void{}
      
      private function __overhandler(param1:Event) : void{}
      
      private function __outhandler(param1:Event) : void{}
      
      private function __bulletShootHandler(param1:Event) : void{}
      
      public function ReStart() : void{}
      
      public function clear() : void{}
      
      public function dispose() : void{}
   }
}
