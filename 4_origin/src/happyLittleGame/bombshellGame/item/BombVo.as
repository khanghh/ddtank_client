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
      
      public function BombVo(param1:int)
      {
         super();
         _state = param1;
         _stateMirror = param1;
         if(param1 != BombState.Bomb_Obs)
         {
            _scoresNum = ComponentFactory.Instance.creatComponentByStylename("bombgame.NumberC");
            _bomb = ClassUtils.CreatInstance("asset.bombgame.bomb");
            _bomb.gotoAndPlay("state" + _state);
            _bomb.addEventListener("complete",__mcComplete);
            PositionUtils.setPos(_scoresNum,"happygame.bombscore.pos");
            addChild(_scoresNum);
            sx = _scoresNum.x;
            _scoresNum.visible = false;
            _bomb.scaleX = 0.8;
            _bomb.scaleY = 0.8;
            this.addChild(_bomb);
         }
         else if(param1 == BombState.Bomb_Obs)
         {
            _bomb = ClassUtils.CreatInstance("asset.bombgame.stone");
            this.addChild(_bomb);
         }
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            _scoresBasic = ServerConfigManager.instance.BombFixGamePerScore;
         }
         else if(HappyLittleGameManager.instance.currentGameType == 1)
         {
            _scoresBasic = ServerConfigManager.instance.BombRandomGamePerScore;
         }
      }
      
      public function get orderParent() : int
      {
         return _orderParent;
      }
      
      public function set orderParent(param1:int) : void
      {
         _orderParent = param1;
      }
      
      public function get IsLock() : Boolean
      {
         return _isLock;
      }
      
      public function set IsLock(param1:Boolean) : void
      {
         _isLock = param1;
      }
      
      public function get stateMirror() : int
      {
         return _stateMirror;
      }
      
      public function set stateMirror(param1:int) : void
      {
         _stateMirror = param1 <= BombState.Bomb_5?param1:int(BombState.Bomb_5);
      }
      
      public function get order() : int
      {
         return _order;
      }
      
      public function set order(param1:int) : void
      {
         _order = param1;
      }
      
      public function get scores() : int
      {
         var _loc1_:int = 1;
         if(HappyLittleGameManager.instance.bombManager.doubleScore)
         {
            _loc1_ = 2;
         }
         if(order == 1)
         {
            return _scoresBasic * _loc1_;
         }
         return (_scoresBasic + 5 * (order - 1) + order) * _loc1_;
      }
      
      public function get canClick() : Boolean
      {
         return _canClick;
      }
      
      public function set canClick(param1:Boolean) : void
      {
         _canClick = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get vy() : int
      {
         return _vy;
      }
      
      public function set vy(param1:int) : void
      {
         _vy = param1;
      }
      
      public function get MC() : MovieClip
      {
         return _bomb;
      }
      
      public function get vx() : int
      {
         return _vx;
      }
      
      public function set vx(param1:int) : void
      {
         _vx = param1;
      }
      
      public function showNextBomb() : Boolean
      {
         if(_state < BombState.Bomb_5)
         {
            _state = Number(_state) + 1;
            stateMirror = _state;
            SoundManager.instance.play("218");
            _bomb.gotoAndPlay("turn" + _state);
            return true;
         }
         if(!IsLock)
         {
            if(_state == BombState.Bomb_5)
            {
               SoundManager.instance.play("218");
               _state = BombState.Bomb;
               IsLock = true;
               _bomb.gotoAndPlay("turn_bomb");
            }
            return false;
         }
         return false;
      }
      
      public function showScores() : void
      {
         this._scoresNum.count = scores;
         if(scores > 99)
         {
            _scoresNum.x = sx - 10;
         }
         else
         {
            _scoresNum.x = sx;
         }
      }
      
      private function ShowBomb() : void
      {
         if(_bombMc == null)
         {
            SoundManager.instance.play("219");
            _bombMc = ClassUtils.CreatInstance("asset.bombgame.explode");
            _bombMc.x = -_bombMc.width;
            _bombMc.y = -_bombMc.height;
            _bombMc.addEventListener("complete",__bombMcComplete);
            addChild(_bombMc);
         }
      }
      
      private function __bombMcComplete(param1:Event) : void
      {
         this.dispatchEvent(new Event("shootbullet"));
         _scoresNum.visible = true;
         canClick = false;
         if(_timer == null)
         {
            _timer = TimerManager.getInstance().addTimer1000ms(1000);
            _timer.addEventListener("timer",onEndTimeTimer);
         }
         _timer.start();
      }
      
      private function onEndTimeTimer(param1:Event) : void
      {
         _timer.stop();
         TimerManager.getInstance().removeTimer1000ms(_timer);
         _timer.removeEventListener("timer",onEndTimeTimer);
         _timer = null;
         dispose();
      }
      
      private function __mcComplete(param1:Event) : void
      {
         if(_state <= BombState.Bomb_5 && _state != BombState.Bomb)
         {
            canClick = true;
         }
         else
         {
            ShowBomb();
         }
      }
      
      public function dispose() : void
      {
         if(_bomb)
         {
            _bomb.removeEventListener("complete",__mcComplete);
         }
         if(_bombMc)
         {
            _bombMc.removeEventListener("complete",__bombMcComplete);
         }
         ObjectUtils.disposeObject(_bomb);
         ObjectUtils.disposeObject(_bombMc);
         ObjectUtils.disposeObject(_scoresNum);
         _scoresNum = null;
         _bomb = null;
         _bombMc = null;
      }
   }
}
