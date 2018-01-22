package happyLittleGame.bombshellGame.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import uiModeManager.bombUI.BombState;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class BombVo extends Sprite implements Disposeable
   {
       
      
      private var _state:int;
      
      private var _stateMirror:int;
      
      private var _bomb:MovieClip;
      
      private var _bombMc:MovieClip;
      
      private var _vx:int;
      
      private var _vy:int;
      
      private var _canClick:Boolean = true;
      
      private var _isLock:Boolean = false;
      
      private var _scoresBasic:int = 10;
      
      private var _currentscores:int = 0;
      
      private var _scoresNum:NumberImage;
      
      private var _timer:TimerJuggler;
      
      private var _order:int = 0;
      
      private var _orderParent:int = 0;
      
      private var _bombNum:int;
      
      public var isSelect:Boolean = false;
      
      private var sx:int = 0;
      
      public function BombVo(param1:int){super();}
      
      public function get orderParent() : int{return 0;}
      
      public function set orderParent(param1:int) : void{}
      
      public function get IsLock() : Boolean{return false;}
      
      public function set IsLock(param1:Boolean) : void{}
      
      public function get stateMirror() : int{return 0;}
      
      public function set stateMirror(param1:int) : void{}
      
      public function get order() : int{return 0;}
      
      public function set order(param1:int) : void{}
      
      public function get scores() : int{return 0;}
      
      public function get canClick() : Boolean{return false;}
      
      public function set canClick(param1:Boolean) : void{}
      
      public function get state() : int{return 0;}
      
      public function get vy() : int{return 0;}
      
      public function set vy(param1:int) : void{}
      
      public function get MC() : MovieClip{return null;}
      
      public function get vx() : int{return 0;}
      
      public function set vx(param1:int) : void{}
      
      public function showNextBomb() : Boolean{return false;}
      
      public function showScores() : void{}
      
      private function ShowBomb() : void{}
      
      private function __bombMcComplete(param1:Event) : void{}
      
      private function onEndTimeTimer(param1:Event) : void{}
      
      private function __mcComplete(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
