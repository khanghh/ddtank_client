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
      
      public function set checkallBomb(value:Boolean) : void
      {
         _checkallBomb = value;
      }
      
      public function get currentGameType() : int
      {
         return _currentGameType;
      }
      
      public function set currentGameType(value:int) : void
      {
         _currentGameType = value;
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
         var vo:* = null;
         var i:int = 0;
         var lenII:int = 0;
         var j:int = 0;
         var len:int = bombPool.length;
         for(i = 0; i < len; )
         {
            lenII = bombPool[i].length;
            for(j = 0; j < lenII; )
            {
               if(bombPool[i][j] is BombVo)
               {
                  vo = bombPool[i][j] as BombVo;
                  if(vo.state != BombState.Bomb_Obs && vo.state != BombState.Bomb)
                  {
                     return true;
                  }
               }
               j++;
            }
            i++;
         }
         return false;
      }
      
      private function __enterFrameHandler(evt:Event) : void
      {
         var len:int = 0;
         var i:int = 0;
         if(bulletPool.length > 0)
         {
            len = bulletPool.length;
            for(i = 0; i < len; )
            {
               if(bulletPool[i])
               {
                  bulletPool[i].BulletMc();
                  if(CheckBulletHit(bulletPool[i]))
                  {
                     ObjectUtils.disposeObject(bulletPool[i]);
                     bulletPool[i] = null;
                     bulletPool.splice(i,1);
                     i--;
                  }
               }
               i++;
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
         var lenII:int = 0;
         var vo:* = null;
         var i:int = 0;
         var j:int = 0;
         var len:int = bombPool.length;
         for(i = 0; i < len; )
         {
            lenII = bombPool[0].length;
            for(j = 0; j < lenII; )
            {
               if(bombPool[i][j] is BombVo)
               {
                  vo = bombPool[i][j];
                  if(vo.state == BombState.Bomb_1 || vo.state == BombState.Bomb_2 || vo.state == BombState.Bomb_3 || vo.state == BombState.Bomb_4 || vo.state == BombState.Bomb_5)
                  {
                     return true;
                  }
               }
               j++;
            }
            i++;
         }
         return false;
      }
      
      private function CheckBulletHit(target:BombGameBullet) : Boolean
      {
         var hitTarget:* = null;
         var index:int = 0;
         var len:int = 0;
         var checkborder:Boolean = false;
         if(target != null)
         {
            hitTarget = GetHitBombVo(target.Direc,target.VX,target.VY);
            if(hitTarget && hitTarget.MC && target.MC && hitTarget.MC.hitTestObject(target.MC))
            {
               if(hitTarget.state != BombState.Bomb_Obs && !hitTarget.IsLock)
               {
                  if(!hitTarget.showNextBomb())
                  {
                     willbombvo.push(hitTarget);
                     hitTarget.order = target.order + 1;
                     hitTarget.showScores();
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
               if(hitTarget.state == BombState.Bomb_Obs)
               {
                  return true;
               }
               return false;
            }
            checkborder = false;
            if(target.x > 542 || target.x < -13)
            {
               checkborder = true;
            }
            if(target.y > 550 || target.y < -24)
            {
               checkborder = true;
            }
            if(checkborder)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      private function GetHitBombVo(_dir:int, _sx:int, _sy:int) : BombVo
      {
         var dirX:int = 0;
         var dirY:int = 0;
         var tempVo:BombVo = null;
         var _loc7_:* = _dir;
         if(BulletDirection.Down !== _loc7_)
         {
            if(BulletDirection.Up !== _loc7_)
            {
               if(BulletDirection.Left !== _loc7_)
               {
                  if(BulletDirection.Right === _loc7_)
                  {
                     for(dirY = _sy + 1; dirY < 10; )
                     {
                        if(bombPool[_sx][dirY] is BombVo)
                        {
                           tempVo = bombPool[_sx][dirY];
                           if(!tempVo.IsLock)
                           {
                              return tempVo;
                           }
                        }
                        dirY++;
                     }
                  }
               }
               else
               {
                  for(dirY = _sy - 1; dirY >= 0; )
                  {
                     if(bombPool[_sx][dirY] is BombVo)
                     {
                        tempVo = bombPool[_sx][dirY];
                        if(!tempVo.IsLock)
                        {
                           return tempVo;
                        }
                     }
                     dirY--;
                  }
               }
            }
            else
            {
               for(dirX = _sx - 1; dirX >= 0; )
               {
                  if(bombPool[dirX][_sy] is BombVo)
                  {
                     tempVo = bombPool[dirX][_sy];
                     if(!tempVo.IsLock)
                     {
                        return tempVo;
                     }
                  }
                  dirX--;
               }
            }
         }
         else
         {
            for(dirX = _sx + 1; dirX < 10; )
            {
               if(bombPool[dirX][_sy] is BombVo)
               {
                  tempVo = bombPool[dirX][_sy];
                  if(!tempVo.IsLock)
                  {
                     return tempVo;
                  }
               }
               dirX++;
            }
         }
         return tempVo;
      }
      
      private function initPool() : void
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < 10; )
         {
            bombPool[i] = [];
            senddata[i] = [];
            for(j = 0; j < 10; )
            {
               bombPool[i][j] = [];
               senddata[i][j] = [];
               j++;
            }
            i++;
         }
      }
      
      private function initBomb() : void
      {
         var index:int = 0;
         var arr:* = null;
         var indexII:int = 0;
         var state:int = 0;
         var vo:* = null;
         var dataArr:Array = HappyLittleGameManager.instance.bombManager.model.BombTrain;
         var posArr:Array = HappyLittleGameManager.instance.bombManager.model.bombPos;
         var length:int = dataArr.length;
         for(index = 0; index < length; )
         {
            arr = dataArr[index];
            for(indexII = 0; indexII < arr.length; )
            {
               state = arr[indexII];
               if(state != BombState.Bomb_None)
               {
                  vo = new BombVo(state);
                  vo.visible = false;
                  vo.MC.addEventListener("click",__clickhandler);
                  vo.MC.addEventListener("mouseOver",__overhandler);
                  vo.MC.addEventListener("mouseOut",__outhandler);
                  vo.addEventListener("shootbullet",__bulletShootHandler);
                  vo.vx = index;
                  vo.vy = indexII;
                  vo.name = "vx_" + index + "_vy_" + indexII;
                  vo.x = posArr[index][indexII][0];
                  vo.y = posArr[index][indexII][1] - 6;
                  bombPool[index][indexII] = vo;
                  showbomb.push(vo);
                  addChild(vo);
               }
               indexII++;
            }
            index++;
         }
      }
      
      private function __clickhandler(evt:Event) : void
      {
         var vo:BombVo = (evt.currentTarget as MovieClip).parent as BombVo;
         if(vo.state == BombState.Bomb_Obs)
         {
            return;
         }
         if(_mcComplete && vo.canClick && bulletPool.length == 0 && willbombvo.length == 0 && HappyLittleGameManager.instance.bombManager.model.CurrentGameCanBeClickTimes > 0)
         {
            vo.canClick = false;
            _currentClickVo = vo;
            if(gameBtnClick)
            {
               gameBtnClick(false);
            }
            SoundManager.instance.play("218");
            if(!vo.showNextBomb())
            {
               _isSendMapdata = true;
               willbombvo.push(vo);
               vo.order = 1;
               vo.showScores();
               stepMirror = 0;
            }
            else
            {
               _isSendMapdata = false;
               SocketManager.Instance.out.sendBombPos(HappyLittleGameManager.instance.currentGameType,vo.vx,vo.vy,false,null,null);
            }
            if(gameStepSub)
            {
               gameStepSub();
            }
         }
      }
      
      private function clearBombInfo() : void
      {
         var obj:* = null;
         var len:int = bombinfo.length;
         while(len > 0)
         {
            obj = bombinfo.shift();
            obj = null;
            len = bombinfo.length;
         }
      }
      
      public function sendCurrenMapdata() : void
      {
         var lenII:int = 0;
         var vo:* = null;
         var info:* = null;
         var i:int = 0;
         var j:int = 0;
         var len:int = bombPool.length;
         var temp:String = "";
         clearBombInfo();
         for(i = 0; i < len; )
         {
            lenII = bombPool[0].length;
            for(j = 0; j < lenII; )
            {
               if(bombPool[i][j] is BombVo)
               {
                  vo = bombPool[i][j] as BombVo;
                  if(vo.state != BombState.Bomb)
                  {
                     senddata[i][j] = vo.state;
                  }
                  else
                  {
                     if(vo.isSelect == false)
                     {
                        info = {};
                        info.vx = i;
                        info.vy = j;
                        info.order = vo.order;
                        vo.isSelect = true;
                        bombinfo.push(info);
                     }
                     senddata[i][j] = 0;
                  }
               }
               else
               {
                  senddata[i][j] = 0;
               }
               j++;
            }
            i++;
         }
         SocketManager.Instance.out.sendBombPos(HappyLittleGameManager.instance.currentGameType,_currentClickVo.vx,_currentClickVo.vy,true,senddata,bombinfo);
      }
      
      private function __overhandler(evt:Event) : void
      {
         var mc:* = null;
         var vo:* = null;
         if(bulletPool.length == 0)
         {
            mc = evt.currentTarget as MovieClip;
            vo = mc.parent as BombVo;
            if(vo.state == BombState.Bomb_Obs)
            {
               return;
            }
            vo.buttonMode = true;
            mc.scaleX = 0.9;
            mc.scaleY = 0.9;
         }
      }
      
      private function __outhandler(evt:Event) : void
      {
         var mc:* = null;
         var vo:* = null;
         if(bulletPool.length == 0)
         {
            mc = evt.currentTarget as MovieClip;
            vo = mc.parent as BombVo;
            if(vo.state == BombState.Bomb_Obs)
            {
               return;
            }
            vo.buttonMode = false;
            mc.scaleX = 0.8;
            mc.scaleY = 0.8;
         }
      }
      
      private function __bulletShootHandler(evt:Event) : void
      {
         var bulletL:* = null;
         var bulletR:* = null;
         var bulletU:* = null;
         var bulletD:* = null;
         var vo:BombVo = evt.currentTarget as BombVo;
         if(scoreCallBack)
         {
            scoreCallBack(vo.scores);
         }
         vo.removeEventListener("shootbullet",__bulletShootHandler);
         vo.MC.removeEventListener("click",__clickhandler);
         vo.MC.removeEventListener("mouseOver",__overhandler);
         vo.MC.removeEventListener("mouseOut",__outhandler);
         var index:int = willbombvo.indexOf(vo);
         if(index >= 0)
         {
            willbombvo.splice(index,1);
         }
         if(vo != null)
         {
            if(vo.vx == 0 && vo.vy == 0)
            {
               bulletD = new BombGameBullet(BulletDirection.Down,vo.vx,vo.vy,vo.x,vo.y);
               bulletR = new BombGameBullet(BulletDirection.Right,vo.vx,vo.vy,vo.x,vo.y);
               bulletPool.push(bulletD);
               bulletPool.push(bulletR);
               var _loc8_:* = vo.order;
               bulletD.order = _loc8_;
               bulletR.order = _loc8_;
               addChild(bulletR);
               addChild(bulletD);
               return;
            }
            if(vo.vx == 0 && vo.vy == 9)
            {
               bulletD = new BombGameBullet(BulletDirection.Down,vo.vx,vo.vy,vo.x,vo.y);
               bulletL = new BombGameBullet(BulletDirection.Left,vo.vx,vo.vy,vo.x,vo.y);
               bulletPool.push(bulletD);
               bulletPool.push(bulletL);
               addChild(bulletL);
               addChild(bulletD);
               _loc8_ = vo.order;
               bulletD.order = _loc8_;
               bulletL.order = _loc8_;
               return;
            }
            if(vo.vx == 9 && vo.vy == 9)
            {
               bulletU = new BombGameBullet(BulletDirection.Up,vo.vx,vo.vy,vo.x,vo.y);
               bulletL = new BombGameBullet(BulletDirection.Left,vo.vx,vo.vy,vo.x,vo.y);
               bulletPool.push(bulletU);
               bulletPool.push(bulletL);
               addChild(bulletL);
               addChild(bulletU);
               _loc8_ = vo.order;
               bulletU.order = _loc8_;
               bulletL.order = _loc8_;
               return;
            }
            if(vo.vx == 9 && vo.vy == 0)
            {
               bulletU = new BombGameBullet(BulletDirection.Up,vo.vx,vo.vy,vo.x,vo.y);
               bulletR = new BombGameBullet(BulletDirection.Right,vo.vx,vo.vy,vo.x,vo.y);
               bulletPool.push(bulletU);
               bulletPool.push(bulletR);
               addChild(bulletR);
               addChild(bulletU);
               _loc8_ = vo.order;
               bulletU.order = _loc8_;
               bulletR.order = _loc8_;
               return;
            }
            if(vo.vx == 0)
            {
               bulletD = new BombGameBullet(BulletDirection.Down,vo.vx,vo.vy,vo.x,vo.y);
               bulletL = new BombGameBullet(BulletDirection.Left,vo.vx,vo.vy,vo.x,vo.y);
               bulletR = new BombGameBullet(BulletDirection.Right,vo.vx,vo.vy,vo.x,vo.y);
               bulletPool.push(bulletD);
               bulletPool.push(bulletL);
               bulletPool.push(bulletR);
               addChild(bulletR);
               addChild(bulletL);
               addChild(bulletD);
               _loc8_ = vo.order;
               bulletD.order = _loc8_;
               _loc8_ = _loc8_;
               bulletL.order = _loc8_;
               bulletR.order = _loc8_;
               return;
            }
            if(vo.vx == 9)
            {
               bulletU = new BombGameBullet(BulletDirection.Up,vo.vx,vo.vy,vo.x,vo.y);
               bulletL = new BombGameBullet(BulletDirection.Left,vo.vx,vo.vy,vo.x,vo.y);
               bulletR = new BombGameBullet(BulletDirection.Right,vo.vx,vo.vy,vo.x,vo.y);
               bulletPool.push(bulletU);
               bulletPool.push(bulletL);
               bulletPool.push(bulletR);
               addChild(bulletL);
               addChild(bulletU);
               addChild(bulletR);
               _loc8_ = vo.order;
               bulletU.order = _loc8_;
               _loc8_ = _loc8_;
               bulletL.order = _loc8_;
               bulletR.order = _loc8_;
               return;
            }
            if(vo.vy == 0)
            {
               bulletR = new BombGameBullet(BulletDirection.Right,vo.vx,vo.vy,vo.x,vo.y);
               bulletU = new BombGameBullet(BulletDirection.Up,vo.vx,vo.vy,vo.x,vo.y);
               bulletD = new BombGameBullet(BulletDirection.Down,vo.vx,vo.vy,vo.x,vo.y);
               bulletPool.push(bulletU);
               bulletPool.push(bulletD);
               bulletPool.push(bulletR);
               addChild(bulletR);
               addChild(bulletU);
               addChild(bulletD);
               _loc8_ = vo.order;
               bulletU.order = _loc8_;
               _loc8_ = _loc8_;
               bulletD.order = _loc8_;
               bulletR.order = _loc8_;
               return;
            }
            if(vo.vy == 9)
            {
               bulletL = new BombGameBullet(BulletDirection.Left,vo.vx,vo.vy,vo.x,vo.y);
               bulletD = new BombGameBullet(BulletDirection.Down,vo.vx,vo.vy,vo.x,vo.y);
               bulletU = new BombGameBullet(BulletDirection.Up,vo.vx,vo.vy,vo.x,vo.y);
               bulletPool.push(bulletU);
               bulletPool.push(bulletD);
               bulletPool.push(bulletL);
               addChild(bulletL);
               addChild(bulletD);
               addChild(bulletU);
               _loc8_ = vo.order;
               bulletU.order = _loc8_;
               _loc8_ = _loc8_;
               bulletD.order = _loc8_;
               bulletL.order = _loc8_;
               return;
            }
            bulletL = new BombGameBullet(BulletDirection.Left,vo.vx,vo.vy,vo.x,vo.y);
            bulletR = new BombGameBullet(BulletDirection.Right,vo.vx,vo.vy,vo.x,vo.y);
            bulletU = new BombGameBullet(BulletDirection.Up,vo.vx,vo.vy,vo.x,vo.y);
            bulletD = new BombGameBullet(BulletDirection.Down,vo.vx,vo.vy,vo.x,vo.y);
            bulletPool.push(bulletU);
            bulletPool.push(bulletD);
            bulletPool.push(bulletL);
            bulletPool.push(bulletR);
            addChild(bulletU);
            addChild(bulletD);
            addChild(bulletL);
            addChild(bulletR);
            _loc8_ = vo.order;
            bulletU.order = _loc8_;
            _loc8_ = _loc8_;
            bulletD.order = _loc8_;
            _loc8_ = _loc8_;
            bulletL.order = _loc8_;
            bulletR.order = _loc8_;
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
         var vo:* = null;
         var lenx:int = 0;
         var leny:int = 0;
         var i:int = 0;
         var arr:* = null;
         var j:int = 0;
         var bullet:* = null;
         if(bombPool != null)
         {
            lenx = bombPool.length;
            for(i = 0; i < lenx; )
            {
               arr = bombPool[i];
               leny = arr.length;
               for(j = 0; j < leny; )
               {
                  if(bombPool[i][j] is BombVo)
                  {
                     vo = bombPool[i][j] as BombVo;
                     if(vo.MC)
                     {
                        vo.MC.removeEventListener("click",__clickhandler);
                        vo.MC.removeEventListener("mouseOver",__overhandler);
                        vo.MC.removeEventListener("mouseOut",__outhandler);
                     }
                     if(vo != null)
                     {
                        ObjectUtils.disposeObject(vo);
                        vo = null;
                     }
                  }
                  j++;
               }
               i++;
            }
         }
         if(bulletPool != null)
         {
            while(bulletPool.length > 0)
            {
               bullet = bulletPool.shift();
               ObjectUtils.disposeObject(bullet);
               bullet = null;
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
