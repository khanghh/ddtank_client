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
      
      public function BombLogic()
      {
         super();
         bulletPool = [];
         bombPool = [];
         willbombvo = [];
         showbomb = [];
         senddata = [];
         bombinfo = [];
         stepMirror = HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes;
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            _stepPreCount = ServerConfigManager.instance.BombFixGamePerBombCountAddCount;
         }
         if(HappyLittleGameManager.instance.currentGameType == 1)
         {
            _stepPreCount = ServerConfigManager.instance.BombRandomGamePerBombCountAddCount;
         }
         initEvent();
      }
      
      public function get checkallBomb() : Boolean
      {
         return _checkallBomb;
      }
      
      public function set checkallBomb(param1:Boolean) : void
      {
         _checkallBomb = param1;
      }
      
      public function get currentGameType() : int
      {
         return _currentGameType;
      }
      
      public function set currentGameType(param1:int) : void
      {
         _currentGameType = param1;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("enterFrame",__enterFrameHandler);
      }
      
      public function removeEvent() : void
      {
         this.removeEventListener("enterFrame",__enterFrameHandler);
      }
      
      private function CheckBombNextLv() : Boolean
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = bombPool.length;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = bombPool[_loc4_].length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(bombPool[_loc4_][_loc2_] is BombVo)
               {
                  _loc5_ = bombPool[_loc4_][_loc2_] as BombVo;
                  if(_loc5_.state != BombState.Bomb_Obs && _loc5_.state != BombState.Bomb)
                  {
                     return true;
                  }
               }
               _loc2_++;
            }
            _loc4_++;
         }
         return false;
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(bulletPool.length > 0)
         {
            _loc2_ = bulletPool.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(bulletPool[_loc3_])
               {
                  bulletPool[_loc3_].BulletMc();
                  if(CheckBulletHit(bulletPool[_loc3_]))
                  {
                     ObjectUtils.disposeObject(bulletPool[_loc3_]);
                     bulletPool[_loc3_] = null;
                     bulletPool.splice(_loc3_,1);
                     _loc3_--;
                  }
               }
               _loc3_++;
            }
         }
         if(callBack != null)
         {
            callBack();
         }
         if(showbomb.length > 0)
         {
            if(_timerNum >= 10)
            {
               showbomb.shift().visible = true;
            }
            else
            {
               _timerNum = Number(_timerNum) - 1;
               if(_timerNum <= 0)
               {
                  _timerNum = 10;
               }
            }
         }
         else
         {
            _mcComplete = true;
            if(checkallBomb && willbombvo.length == 0 && bulletPool.length == 0)
            {
               if(showServerScore)
               {
                  showServerScore();
               }
               checkallBomb = false;
               if(gameBtnClick)
               {
                  gameBtnClick(true);
               }
               if(!CheckBombNextLv())
               {
                  if(HappyLittleGameManager.instance.currentGameState == 2)
                  {
                     if(gameNext)
                     {
                        gameNext();
                     }
                  }
                  if(HappyLittleGameManager.instance.currentGameState == 4)
                  {
                     if(gameover)
                     {
                        gameover();
                     }
                  }
               }
               else if(HappyLittleGameManager.instance.currentGameState == 1)
               {
                  if(gameover)
                  {
                     gameover();
                  }
               }
            }
            else if(_isSendMapdata)
            {
               if(willbombvo.length == 0 && bulletPool.length == 0)
               {
                  _isSendMapdata = false;
                  if(!isShowPassMc && !checkMapHasBomb())
                  {
                     isShowPassMc = true;
                     if(showPassMc)
                     {
                        showPassMc();
                     }
                  }
                  else
                  {
                     sendCurrenMapdata();
                  }
               }
            }
         }
      }
      
      private function checkMapHasBomb() : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = bombPool.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc5_ = bombPool[0].length;
            _loc2_ = 0;
            while(_loc2_ < _loc5_)
            {
               if(bombPool[_loc3_][_loc2_] is BombVo)
               {
                  _loc4_ = bombPool[_loc3_][_loc2_];
                  if(_loc4_.state == BombState.Bomb_1 || _loc4_.state == BombState.Bomb_2 || _loc4_.state == BombState.Bomb_3 || _loc4_.state == BombState.Bomb_4 || _loc4_.state == BombState.Bomb_5)
                  {
                     return true;
                  }
               }
               _loc2_++;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function CheckBulletHit(param1:BombGameBullet) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         if(param1 != null)
         {
            _loc3_ = GetHitBombVo(param1.Direc,param1.VX,param1.VY);
            if(_loc3_ && _loc3_.MC && param1.MC && _loc3_.MC.hitTestObject(param1.MC))
            {
               if(_loc3_.state != BombState.Bomb_Obs && !_loc3_.IsLock)
               {
                  if(!_loc3_.showNextBomb())
                  {
                     willbombvo.push(_loc3_);
                     _loc3_.order = param1.order + 1;
                     _loc3_.showScores();
                     stepMirror = Number(stepMirror) + 1;
                     if(stepMirror == _stepPreCount)
                     {
                        stepMirror = 0;
                        if(gameStepAdd)
                        {
                           gameStepAdd();
                        }
                     }
                  }
                  return true;
               }
               if(_loc3_.state == BombState.Bomb_Obs)
               {
                  return true;
               }
               return false;
            }
            _loc5_ = false;
            if(param1.x > 542 || param1.x < -13)
            {
               _loc5_ = true;
            }
            if(param1.y > 550 || param1.y < -24)
            {
               _loc5_ = true;
            }
            if(_loc5_)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      private function GetHitBombVo(param1:int, param2:int, param3:int) : BombVo
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:BombVo = null;
         var _loc7_:* = param1;
         if(BulletDirection.Down !== _loc7_)
         {
            if(BulletDirection.Up !== _loc7_)
            {
               if(BulletDirection.Left !== _loc7_)
               {
                  if(BulletDirection.Right === _loc7_)
                  {
                     _loc5_ = param3 + 1;
                     while(_loc5_ < 10)
                     {
                        if(bombPool[param2][_loc5_] is BombVo)
                        {
                           _loc4_ = bombPool[param2][_loc5_];
                           if(!_loc4_.IsLock)
                           {
                              return _loc4_;
                           }
                        }
                        _loc5_++;
                     }
                  }
               }
               else
               {
                  _loc5_ = param3 - 1;
                  while(_loc5_ >= 0)
                  {
                     if(bombPool[param2][_loc5_] is BombVo)
                     {
                        _loc4_ = bombPool[param2][_loc5_];
                        if(!_loc4_.IsLock)
                        {
                           return _loc4_;
                        }
                     }
                     _loc5_--;
                  }
               }
            }
            else
            {
               _loc6_ = param2 - 1;
               while(_loc6_ >= 0)
               {
                  if(bombPool[_loc6_][param3] is BombVo)
                  {
                     _loc4_ = bombPool[_loc6_][param3];
                     if(!_loc4_.IsLock)
                     {
                        return _loc4_;
                     }
                  }
                  _loc6_--;
               }
            }
         }
         else
         {
            _loc6_ = param2 + 1;
            while(_loc6_ < 10)
            {
               if(bombPool[_loc6_][param3] is BombVo)
               {
                  _loc4_ = bombPool[_loc6_][param3];
                  if(!_loc4_.IsLock)
                  {
                     return _loc4_;
                  }
               }
               _loc6_++;
            }
         }
         return _loc4_;
      }
      
      private function initPool() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            bombPool[_loc2_] = [];
            senddata[_loc2_] = [];
            _loc1_ = 0;
            while(_loc1_ < 10)
            {
               bombPool[_loc2_][_loc1_] = [];
               senddata[_loc2_][_loc1_] = [];
               _loc1_++;
            }
            _loc2_++;
         }
      }
      
      private function initBomb() : void
      {
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:* = null;
         var _loc1_:Array = HappyLittleGameManager.instance.bombManager.model.BombTrain;
         var _loc3_:Array = HappyLittleGameManager.instance.bombManager.model.bombPos;
         var _loc7_:int = _loc1_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc7_)
         {
            _loc5_ = _loc1_[_loc2_];
            _loc4_ = 0;
            while(_loc4_ < _loc5_.length)
            {
               _loc6_ = _loc5_[_loc4_];
               if(_loc6_ != BombState.Bomb_None)
               {
                  _loc8_ = new BombVo(_loc6_);
                  _loc8_.visible = false;
                  _loc8_.MC.addEventListener("click",__clickhandler);
                  _loc8_.MC.addEventListener("mouseOver",__overhandler);
                  _loc8_.MC.addEventListener("mouseOut",__outhandler);
                  _loc8_.addEventListener("shootbullet",__bulletShootHandler);
                  _loc8_.vx = _loc2_;
                  _loc8_.vy = _loc4_;
                  _loc8_.name = "vx_" + _loc2_ + "_vy_" + _loc4_;
                  _loc8_.x = _loc3_[_loc2_][_loc4_][0];
                  _loc8_.y = _loc3_[_loc2_][_loc4_][1] - 6;
                  bombPool[_loc2_][_loc4_] = _loc8_;
                  showbomb.push(_loc8_);
                  addChild(_loc8_);
               }
               _loc4_++;
            }
            _loc2_++;
         }
      }
      
      private function __clickhandler(param1:Event) : void
      {
         var _loc2_:BombVo = (param1.currentTarget as MovieClip).parent as BombVo;
         if(_loc2_.state == BombState.Bomb_Obs)
         {
            return;
         }
         if(_mcComplete && _loc2_.canClick && bulletPool.length == 0 && willbombvo.length == 0 && HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes > 0)
         {
            _loc2_.canClick = false;
            _currentClickVo = _loc2_;
            if(gameBtnClick)
            {
               gameBtnClick(false);
            }
            SoundManager.instance.play("218");
            if(!_loc2_.showNextBomb())
            {
               _isSendMapdata = true;
               willbombvo.push(_loc2_);
               _loc2_.order = 1;
               _loc2_.showScores();
               stepMirror = 0;
            }
            else
            {
               _isSendMapdata = false;
               SocketManager.Instance.out.sendBombPos(HappyLittleGameManager.instance.currentGameType,_loc2_.vx,_loc2_.vy,false,null,null);
            }
            if(gameStepSub)
            {
               gameStepSub();
            }
         }
      }
      
      private function clearBombInfo() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = bombinfo.length;
         while(_loc2_ > 0)
         {
            _loc1_ = bombinfo.shift();
            _loc1_ = null;
            _loc2_ = bombinfo.length;
         }
      }
      
      public function sendCurrenMapdata() : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = bombPool.length;
         var _loc1_:String = "";
         clearBombInfo();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc7_ = bombPool[0].length;
            _loc3_ = 0;
            while(_loc3_ < _loc7_)
            {
               if(bombPool[_loc4_][_loc3_] is BombVo)
               {
                  _loc6_ = bombPool[_loc4_][_loc3_] as BombVo;
                  if(_loc6_.state != BombState.Bomb)
                  {
                     senddata[_loc4_][_loc3_] = _loc6_.state;
                  }
                  else
                  {
                     if(_loc6_.isSelect == false)
                     {
                        _loc5_ = {};
                        _loc5_.vx = _loc4_;
                        _loc5_.vy = _loc3_;
                        _loc5_.order = _loc6_.order;
                        _loc6_.isSelect = true;
                        bombinfo.push(_loc5_);
                     }
                     senddata[_loc4_][_loc3_] = 0;
                  }
               }
               else
               {
                  senddata[_loc4_][_loc3_] = 0;
               }
               _loc3_++;
            }
            _loc4_++;
         }
         SocketManager.Instance.out.sendBombPos(HappyLittleGameManager.instance.currentGameType,_currentClickVo.vx,_currentClickVo.vy,true,senddata,bombinfo);
      }
      
      private function __overhandler(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(bulletPool.length == 0)
         {
            _loc2_ = param1.currentTarget as MovieClip;
            _loc3_ = _loc2_.parent as BombVo;
            if(_loc3_.state == BombState.Bomb_Obs)
            {
               return;
            }
            _loc3_.buttonMode = true;
            _loc2_.scaleX = 0.9;
            _loc2_.scaleY = 0.9;
         }
      }
      
      private function __outhandler(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(bulletPool.length == 0)
         {
            _loc2_ = param1.currentTarget as MovieClip;
            _loc3_ = _loc2_.parent as BombVo;
            if(_loc3_.state == BombState.Bomb_Obs)
            {
               return;
            }
            _loc3_.buttonMode = false;
            _loc2_.scaleX = 0.8;
            _loc2_.scaleY = 0.8;
         }
      }
      
      private function __bulletShootHandler(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc7_:BombVo = param1.currentTarget as BombVo;
         if(scoreCallBack)
         {
            scoreCallBack(_loc7_.scores);
         }
         _loc7_.removeEventListener("shootbullet",__bulletShootHandler);
         _loc7_.MC.removeEventListener("click",__clickhandler);
         _loc7_.MC.removeEventListener("mouseOver",__overhandler);
         _loc7_.MC.removeEventListener("mouseOut",__outhandler);
         var _loc2_:int = willbombvo.indexOf(_loc7_);
         if(_loc2_ >= 0)
         {
            willbombvo.splice(_loc2_,1);
         }
         if(_loc7_ != null)
         {
            if(_loc7_.vx == 0 && _loc7_.vy == 0)
            {
               _loc5_ = new BombGameBullet(BulletDirection.Down,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc4_ = new BombGameBullet(BulletDirection.Right,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               bulletPool.push(_loc5_);
               bulletPool.push(_loc4_);
               var _loc8_:* = _loc7_.order;
               _loc5_.order = _loc8_;
               _loc4_.order = _loc8_;
               addChild(_loc4_);
               addChild(_loc5_);
               return;
            }
            if(_loc7_.vx == 0 && _loc7_.vy == 9)
            {
               _loc5_ = new BombGameBullet(BulletDirection.Down,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc3_ = new BombGameBullet(BulletDirection.Left,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               bulletPool.push(_loc5_);
               bulletPool.push(_loc3_);
               addChild(_loc3_);
               addChild(_loc5_);
               _loc8_ = _loc7_.order;
               _loc5_.order = _loc8_;
               _loc3_.order = _loc8_;
               return;
            }
            if(_loc7_.vx == 9 && _loc7_.vy == 9)
            {
               _loc6_ = new BombGameBullet(BulletDirection.Up,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc3_ = new BombGameBullet(BulletDirection.Left,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               bulletPool.push(_loc6_);
               bulletPool.push(_loc3_);
               addChild(_loc3_);
               addChild(_loc6_);
               _loc8_ = _loc7_.order;
               _loc6_.order = _loc8_;
               _loc3_.order = _loc8_;
               return;
            }
            if(_loc7_.vx == 9 && _loc7_.vy == 0)
            {
               _loc6_ = new BombGameBullet(BulletDirection.Up,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc4_ = new BombGameBullet(BulletDirection.Right,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               bulletPool.push(_loc6_);
               bulletPool.push(_loc4_);
               addChild(_loc4_);
               addChild(_loc6_);
               _loc8_ = _loc7_.order;
               _loc6_.order = _loc8_;
               _loc4_.order = _loc8_;
               return;
            }
            if(_loc7_.vx == 0)
            {
               _loc5_ = new BombGameBullet(BulletDirection.Down,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc3_ = new BombGameBullet(BulletDirection.Left,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc4_ = new BombGameBullet(BulletDirection.Right,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               bulletPool.push(_loc5_);
               bulletPool.push(_loc3_);
               bulletPool.push(_loc4_);
               addChild(_loc4_);
               addChild(_loc3_);
               addChild(_loc5_);
               _loc8_ = _loc7_.order;
               _loc5_.order = _loc8_;
               _loc8_ = _loc8_;
               _loc3_.order = _loc8_;
               _loc4_.order = _loc8_;
               return;
            }
            if(_loc7_.vx == 9)
            {
               _loc6_ = new BombGameBullet(BulletDirection.Up,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc3_ = new BombGameBullet(BulletDirection.Left,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc4_ = new BombGameBullet(BulletDirection.Right,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               bulletPool.push(_loc6_);
               bulletPool.push(_loc3_);
               bulletPool.push(_loc4_);
               addChild(_loc3_);
               addChild(_loc6_);
               addChild(_loc4_);
               _loc8_ = _loc7_.order;
               _loc6_.order = _loc8_;
               _loc8_ = _loc8_;
               _loc3_.order = _loc8_;
               _loc4_.order = _loc8_;
               return;
            }
            if(_loc7_.vy == 0)
            {
               _loc4_ = new BombGameBullet(BulletDirection.Right,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc6_ = new BombGameBullet(BulletDirection.Up,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc5_ = new BombGameBullet(BulletDirection.Down,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               bulletPool.push(_loc6_);
               bulletPool.push(_loc5_);
               bulletPool.push(_loc4_);
               addChild(_loc4_);
               addChild(_loc6_);
               addChild(_loc5_);
               _loc8_ = _loc7_.order;
               _loc6_.order = _loc8_;
               _loc8_ = _loc8_;
               _loc5_.order = _loc8_;
               _loc4_.order = _loc8_;
               return;
            }
            if(_loc7_.vy == 9)
            {
               _loc3_ = new BombGameBullet(BulletDirection.Left,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc5_ = new BombGameBullet(BulletDirection.Down,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               _loc6_ = new BombGameBullet(BulletDirection.Up,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
               bulletPool.push(_loc6_);
               bulletPool.push(_loc5_);
               bulletPool.push(_loc3_);
               addChild(_loc3_);
               addChild(_loc5_);
               addChild(_loc6_);
               _loc8_ = _loc7_.order;
               _loc6_.order = _loc8_;
               _loc8_ = _loc8_;
               _loc5_.order = _loc8_;
               _loc3_.order = _loc8_;
               return;
            }
            _loc3_ = new BombGameBullet(BulletDirection.Left,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
            _loc4_ = new BombGameBullet(BulletDirection.Right,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
            _loc6_ = new BombGameBullet(BulletDirection.Up,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
            _loc5_ = new BombGameBullet(BulletDirection.Down,_loc7_.vx,_loc7_.vy,_loc7_.x,_loc7_.y);
            bulletPool.push(_loc6_);
            bulletPool.push(_loc5_);
            bulletPool.push(_loc3_);
            bulletPool.push(_loc4_);
            addChild(_loc6_);
            addChild(_loc5_);
            addChild(_loc3_);
            addChild(_loc4_);
            _loc8_ = _loc7_.order;
            _loc6_.order = _loc8_;
            _loc8_ = _loc8_;
            _loc5_.order = _loc8_;
            _loc8_ = _loc8_;
            _loc3_.order = _loc8_;
            _loc4_.order = _loc8_;
            return;
         }
      }
      
      public function ReStart() : void
      {
         clear();
         initPool();
         initBomb();
         _mcComplete = false;
         _isSendMapdata = false;
         isShowPassMc = false;
      }
      
      public function clear() : void
      {
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         if(bombPool != null)
         {
            _loc4_ = bombPool.length;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc1_ = bombPool[_loc6_];
               _loc2_ = _loc1_.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  if(bombPool[_loc6_][_loc3_] is BombVo)
                  {
                     _loc7_ = bombPool[_loc6_][_loc3_] as BombVo;
                     if(_loc7_.MC)
                     {
                        _loc7_.MC.removeEventListener("click",__clickhandler);
                        _loc7_.MC.removeEventListener("mouseOver",__overhandler);
                        _loc7_.MC.removeEventListener("mouseOut",__outhandler);
                     }
                     if(_loc7_ != null)
                     {
                        ObjectUtils.disposeObject(_loc7_);
                        _loc7_ = null;
                     }
                  }
                  _loc3_++;
               }
               _loc6_++;
            }
         }
         if(bulletPool != null)
         {
            while(bulletPool.length > 0)
            {
               _loc5_ = bulletPool.shift();
               ObjectUtils.disposeObject(_loc5_);
               _loc5_ = null;
            }
         }
         if(willbombvo != null)
         {
            while(willbombvo.length > 0)
            {
               willbombvo.shift();
            }
         }
         if(showbomb != null)
         {
            while(showbomb.length > 0)
            {
               showbomb.shift();
            }
         }
         clearBombInfo();
      }
      
      public function dispose() : void
      {
         removeEvent();
         clear();
         bulletPool = null;
         bombPool = null;
         callBack = null;
         willbombvo = null;
         senddata = null;
         bombinfo = null;
      }
   }
}
