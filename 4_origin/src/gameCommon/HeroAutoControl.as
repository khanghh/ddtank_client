package gameCommon
{
   import ddt.events.LivingEvent;
   import ddt.view.character.GameCharacter;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import game.view.map.MapView;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.SmallEnemy;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import phy.math.EulerVector;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   
   public class HeroAutoControl extends EventDispatcher
   {
       
      
      private var _keyBoards:Array;
      
      private var _isAuto:Boolean = false;
      
      private var _stateFlag:int;
      
      private var _arf:int;
      
      private var _gf:int;
      
      private var _ga:int;
      
      private var _wa:int;
      
      private var _mass:Number = 10;
      
      private var _gravityFactor:Number = 70;
      
      private var _dt:Number = 0.04;
      
      protected var _windFactor:Number = 240;
      
      private var _currentLivID:int;
      
      private var _drawRoute:Sprite;
      
      private var _collideRect:Rectangle;
      
      private var _curWind:Number = 0;
      
      private var _keyBoardTime:uint = 0;
      
      private var _shootTime:uint = 0;
      
      public function HeroAutoControl()
      {
         _keyBoards = [];
         _collideRect = new Rectangle(-45,-30,100,80);
         super();
         initCanves();
         setKeyEventDisenable(true);
      }
      
      private function initCanves() : void
      {
         _drawRoute = new Sprite();
         map.addChild(_drawRoute);
      }
      
      private function shoot() : void
      {
         readyShoot(function():*
         {
            var /*UnknownSlot*/:* = function():void
            {
               var power:* = NaN;
               var xS_Lef_E:Boolean = false;
               var yS_Up_E:Boolean = false;
               var sPoint:* = null;
               var tartLiv:* = null;
               var ePoint:* = null;
               var _shootAngle:Number = NaN;
               var totalLen:Number = NaN;
               if(_isAuto)
               {
                  if(gameInfo == null || selfPlayer == null || map == null)
                  {
                     return;
                  }
                  xS_Lef_E = true;
                  yS_Up_E = true;
                  sPoint = getSelfPoint();
                  tartLiv = getTarget(sPoint);
                  if(tartLiv == null)
                  {
                     return;
                  }
                  ePoint = tartLiv.pos;
                  tartLiv.route = null;
                  selfPlayer.direction = sPoint.x > ePoint.x?-1:1;
                  selfPlayer.manuallySetGunAngle(45 - selfPlayer.playerAngle * -1 * selfPlayer.direction);
                  _shootAngle = selfPlayer.calcBombAngle();
                  _arf = map.airResistance;
                  _gf = map.gravity * _mass * _gravityFactor;
                  _ga = _gf / _mass;
                  _wa = curWind / _mass;
                  if(selfPlayer.isLiving && selfPlayer.isAttacking)
                  {
                     if(sPoint.x > ePoint.x)
                     {
                        xS_Lef_E = false;
                     }
                     if(sPoint.y > ePoint.y)
                     {
                        yS_Up_E = false;
                     }
                     totalLen = Math.abs(sPoint.x - ePoint.x);
                     if(totalLen <= 40)
                     {
                        power = 10;
                     }
                     else if(judgeMaxPower(sPoint,ePoint,_shootAngle,xS_Lef_E,yS_Up_E))
                     {
                        power = Number(getPower(0,2000,sPoint,ePoint,_shootAngle,xS_Lef_E,yS_Up_E));
                     }
                     else
                     {
                        power = Number(2100);
                     }
                     _stateFlag = 0;
                     if(power > 2000)
                     {
                        if(tartLiv.state)
                        {
                           _stateFlag = 1;
                        }
                        else
                        {
                           _stateFlag = 2;
                        }
                        tartLiv.state = false;
                     }
                     else
                     {
                        if(tartLiv.state)
                        {
                           _stateFlag = 3;
                        }
                        else
                        {
                           _stateFlag = 4;
                        }
                        tartLiv.state = true;
                     }
                     if(_stateFlag == 1 || _stateFlag == 2)
                     {
                        tartLiv.route = null;
                     }
                     else
                     {
                        tartLiv.route = getRouteData(power,_shootAngle,sPoint,ePoint);
                     }
                     if(currentLivID == -1 || !gameInfo.livings[currentLivID].route)
                     {
                        currentLivID = calculateRecent();
                     }
                     else
                     {
                        currentLivID = tartLiv.LivingID;
                     }
                     if(power < 2100)
                     {
                        selfPlayer.force = power;
                     }
                     selfPlayer.dispatchEvent(new LivingEvent("sendShootAction",0,0,power));
                     setKeyEventDisenable(false);
                  }
               }
            };
            return function():void
            {
               var power:* = NaN;
               var xS_Lef_E:Boolean = false;
               var yS_Up_E:Boolean = false;
               var sPoint:* = null;
               var tartLiv:* = null;
               var ePoint:* = null;
               var _shootAngle:Number = NaN;
               var totalLen:Number = NaN;
               if(_isAuto)
               {
                  if(gameInfo == null || selfPlayer == null || map == null)
                  {
                     return;
                  }
                  xS_Lef_E = true;
                  yS_Up_E = true;
                  sPoint = getSelfPoint();
                  tartLiv = getTarget(sPoint);
                  if(tartLiv == null)
                  {
                     return;
                  }
                  ePoint = tartLiv.pos;
                  tartLiv.route = null;
                  selfPlayer.direction = sPoint.x > ePoint.x?-1:1;
                  selfPlayer.manuallySetGunAngle(45 - selfPlayer.playerAngle * -1 * selfPlayer.direction);
                  _shootAngle = selfPlayer.calcBombAngle();
                  _arf = map.airResistance;
                  _gf = map.gravity * _mass * _gravityFactor;
                  _ga = _gf / _mass;
                  _wa = curWind / _mass;
                  if(selfPlayer.isLiving && selfPlayer.isAttacking)
                  {
                     if(sPoint.x > ePoint.x)
                     {
                        xS_Lef_E = false;
                     }
                     if(sPoint.y > ePoint.y)
                     {
                        yS_Up_E = false;
                     }
                     totalLen = Math.abs(sPoint.x - ePoint.x);
                     if(totalLen <= 40)
                     {
                        power = 10;
                     }
                     else if(judgeMaxPower(sPoint,ePoint,_shootAngle,xS_Lef_E,yS_Up_E))
                     {
                        power = Number(getPower(0,2000,sPoint,ePoint,_shootAngle,xS_Lef_E,yS_Up_E));
                     }
                     else
                     {
                        power = Number(2100);
                     }
                     _stateFlag = 0;
                     if(power > 2000)
                     {
                        if(tartLiv.state)
                        {
                           _stateFlag = 1;
                        }
                        else
                        {
                           _stateFlag = 2;
                        }
                        tartLiv.state = false;
                     }
                     else
                     {
                        if(tartLiv.state)
                        {
                           _stateFlag = 3;
                        }
                        else
                        {
                           _stateFlag = 4;
                        }
                        tartLiv.state = true;
                     }
                     if(_stateFlag == 1 || _stateFlag == 2)
                     {
                        tartLiv.route = null;
                     }
                     else
                     {
                        tartLiv.route = getRouteData(power,_shootAngle,sPoint,ePoint);
                     }
                     if(currentLivID == -1 || !gameInfo.livings[currentLivID].route)
                     {
                        currentLivID = calculateRecent();
                     }
                     else
                     {
                        currentLivID = tartLiv.LivingID;
                     }
                     if(power < 2100)
                     {
                        selfPlayer.force = power;
                     }
                     selfPlayer.dispatchEvent(new LivingEvent("sendShootAction",0,0,power));
                     setKeyEventDisenable(false);
                  }
               }
            };
         }());
      }
      
      private function readyShoot(calFun:Function) : void
      {
         initAddKey();
         exeKeyBoard(calFun);
      }
      
      private function initAddKey() : void
      {
         addKeyBoard(int(KeyStroke.VK_3.getCode()));
         addKeyBoard(int(KeyStroke.VK_2.getCode()));
         if(selfPlayer.energy < 700)
         {
            addKeyBoard(int(KeyStroke.VK_4.getCode()));
         }
      }
      
      private function exeKeyBoard(calFun:Function) : void
      {
         calFun = calFun;
         if(_keyBoards.length > 0)
         {
            var keyObj:Object = _keyBoards.shift();
            KeyboardManager.getInstance().customDispatchEvent(new KeyboardEvent(keyObj["type"],true,false,0,keyObj["code"]));
            if(_keyBoardTime != 0)
            {
               clearTimeout(_keyBoardTime);
            }
            _keyBoardTime = setTimeout(function():void
            {
               exeKeyBoard(calFun);
            },200);
         }
         else
         {
            calFun();
         }
      }
      
      private function addKeyBoard(code:int, backFun:Function = null) : void
      {
         _keyBoards.push({
            "type":"keyDown",
            "code":code,
            "backFun":null
         });
         _keyBoards.push({
            "type":"keyUp",
            "code":code,
            "backFun":backFun
         });
      }
      
      private function getTarget(attackerPos:Point) : Living
      {
         var len:int = 0;
         var nearPlay:* = null;
         var minDistance:* = 2147483647;
         var livings:DictionaryData = gameInfo.livings;
         var _loc8_:int = 0;
         var _loc7_:* = livings;
         for each(var player in livings)
         {
            if(!(player.team == selfPlayer.team || !player.isLiving || player.LivingID == selfPlayer.LivingID))
            {
               len = Math.abs(attackerPos.x - player.pos.x);
               if(len < minDistance)
               {
                  minDistance = len;
                  nearPlay = player;
               }
            }
         }
         return nearPlay;
      }
      
      private function getSelfPoint() : Point
      {
         return localToGlcbalByPoint((gameInfo.selfGamePlayer.movie as GameCharacter).localToGlobal(new Point(30,-20)));
      }
      
      private function localToGlcbalByPoint($p:Point) : Point
      {
         if(selfPlayer.currentMap)
         {
            return selfPlayer.currentMap.globalToLocal($p);
         }
         return new Point(0,0);
      }
      
      private function get map() : MapView
      {
         return selfPlayer.currentMap;
      }
      
      public function setAutoState($state:Boolean) : void
      {
         if(_isAuto != $state)
         {
            _isAuto = $state;
            if(_isAuto)
            {
               initEvent();
            }
            else
            {
               removeEvent();
            }
         }
      }
      
      private function initEvent() : void
      {
         selfPlayer.addEventListener("attackingChanged",__autoShootHandler);
      }
      
      private function removeEvent() : void
      {
         selfPlayer.removeEventListener("attackingChanged",__autoShootHandler);
      }
      
      public function updateWind(value:Number) : void
      {
         _curWind = value / 10 * _windFactor;
      }
      
      private function get curWind() : Number
      {
         return _curWind;
      }
      
      private function __autoShootHandler(evt:LivingEvent) : void
      {
         if(RoomManager.Instance.current.type == 49 && selfPlayer.isAttacking)
         {
            setKeyEventDisenable(true);
            if(_shootTime != 0)
            {
               clearTimeout(_shootTime);
            }
            _shootTime = setTimeout(shoot,1000);
         }
      }
      
      private function get selfPlayer() : LocalPlayer
      {
         if(GameControl.Instance.Current)
         {
            return GameControl.Instance.Current.selfGamePlayer;
         }
         return null;
      }
      
      private function get gameInfo() : GameInfo
      {
         return GameControl.Instance.Current;
      }
      
      public function clear() : void
      {
         if(_shootTime != 0)
         {
            clearTimeout(_shootTime);
         }
         if(_keyBoardTime != 0)
         {
            clearTimeout(_keyBoardTime);
         }
         removeEvent();
         _keyBoards = [];
      }
      
      protected function judgeMaxPower(shootPos:Point, enemyPos:Point, shootAngle:Number, xS_Lef_E:Boolean, yS_Up_E:Boolean) : Boolean
      {
         var Ex:* = null;
         var Ey:* = null;
         var vx:int = 0;
         var vy:int = 0;
         vx = 2000 * Math.cos(shootAngle / 180 * 3.14159265358979);
         Ex = new EulerVector(shootPos.x,vx,_wa);
         vy = 2000 * Math.sin(shootAngle / 180 * 3.14159265358979);
         Ey = new EulerVector(shootPos.y,vy,_ga);
         var timeTemp:Boolean = false;
         while(true)
         {
            if(xS_Lef_E)
            {
               if(Ex.x0 > map.bound.width)
               {
                  return true;
               }
               if(Ex.x0 < map.bound.x || Ey.x0 > map.bound.height)
               {
                  return false;
               }
            }
            else
            {
               if(Ex.x0 < map.bound.x)
               {
                  break;
               }
               if(Ex.x0 > map.bound.width || Ey.x0 > map.bound.height)
               {
                  return false;
               }
            }
            if(ifHit(Ex.x0,Ey.x0,enemyPos))
            {
               return true;
            }
            Ex.ComputeOneEulerStep(_mass,_arf,curWind,_dt);
            Ey.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            if(xS_Lef_E && yS_Up_E)
            {
               if(Ey.x0 > enemyPos.y)
               {
                  if(Ex.x0 < enemyPos.x)
                  {
                     return false;
                  }
                  return true;
               }
            }
            else if(xS_Lef_E && !yS_Up_E)
            {
               if(!timeTemp)
               {
                  if(Ex.x0 > enemyPos.x)
                  {
                     return false;
                  }
                  if(Ey.x0 < enemyPos.y)
                  {
                     timeTemp = true;
                  }
               }
               else if(timeTemp)
               {
                  if(Ey.x0 > enemyPos.y)
                  {
                     if(Ex.x0 < enemyPos.x)
                     {
                        return false;
                     }
                     return true;
                  }
               }
            }
            else if(!xS_Lef_E && !yS_Up_E)
            {
               if(!timeTemp)
               {
                  if(Ex.x0 < enemyPos.x)
                  {
                     return false;
                  }
                  if(Ey.x0 < enemyPos.y)
                  {
                     timeTemp = true;
                  }
               }
               else if(timeTemp)
               {
                  if(Ey.x0 > enemyPos.y)
                  {
                     if(Ex.x0 < enemyPos.x)
                     {
                        return true;
                     }
                     return false;
                  }
               }
            }
            else if(!xS_Lef_E && yS_Up_E)
            {
               if(Ey.x0 > enemyPos.y)
               {
                  if(Ex.x0 < enemyPos.x)
                  {
                     return true;
                  }
                  return false;
               }
            }
         }
         return true;
      }
      
      protected function ifHit(bulletX:Number, bulletY:Number, enemyPos:Point) : Boolean
      {
         if(bulletX > enemyPos.x - 15 && bulletX < enemyPos.x + 20 && bulletY > enemyPos.y - 20 && bulletY < enemyPos.y + 30)
         {
            return true;
         }
         return false;
      }
      
      protected function getPower(min:Number, max:Number, shootPos:Point, enemyPos:Point, shootAngle:Number, xS_Lef_E:Boolean, yS_Up_E:Boolean) : Number
      {
         var Ex:* = null;
         var Ey:* = null;
         var vx:int = 0;
         var vy:int = 0;
         var power:int = (min + max) / 2;
         if(power <= min || power >= max)
         {
            return power;
         }
         vx = power * Math.cos(shootAngle / 180 * 3.14159265358979);
         Ex = new EulerVector(shootPos.x,vx,_wa);
         vy = power * Math.sin(shootAngle / 180 * 3.14159265358979);
         Ey = new EulerVector(shootPos.y,vy,_ga);
         var timeTemp:Boolean = false;
         while(true)
         {
            if(xS_Lef_E)
            {
               if(Ex.x0 > map.bound.width)
               {
                  power = getPower(min,power,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                  break;
               }
               if(Ey.x0 > map.bound.height)
               {
                  power = getPower(power,max,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                  break;
               }
               if(Ex.x0 < map.bound.x)
               {
                  power = 2100;
                  return 2100;
               }
            }
            else
            {
               if(Ex.x0 < map.bound.x)
               {
                  power = getPower(min,power,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                  break;
               }
               if(Ey.x0 > map.bound.height)
               {
                  power = getPower(power,max,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                  break;
               }
               if(Ex.x0 > map.bound.width)
               {
                  power = 2100;
                  return 2100;
               }
            }
            if(ifHit(Ex.x0,Ey.x0,enemyPos))
            {
               return power;
            }
            Ex.ComputeOneEulerStep(_mass,_arf,curWind,_dt);
            Ey.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            if(xS_Lef_E && yS_Up_E)
            {
               if(Ey.x0 > enemyPos.y)
               {
                  if(Ex.x0 < enemyPos.x)
                  {
                     power = getPower(power,max,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                  }
                  else
                  {
                     power = getPower(min,power,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                  }
                  break;
               }
            }
            else if(xS_Lef_E && !yS_Up_E)
            {
               if(!timeTemp)
               {
                  if(Ex.x0 > enemyPos.x)
                  {
                     power = getPower(power,max,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                     break;
                  }
                  if(Ey.x0 < enemyPos.y)
                  {
                     timeTemp = true;
                  }
               }
               else if(timeTemp)
               {
                  if(Ey.x0 > enemyPos.y)
                  {
                     if(Ex.x0 < enemyPos.x)
                     {
                        power = getPower(power,max,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                     }
                     else
                     {
                        power = getPower(min,power,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                     }
                     break;
                  }
               }
            }
            else if(!xS_Lef_E && !yS_Up_E)
            {
               if(!timeTemp)
               {
                  if(Ex.x0 < enemyPos.x)
                  {
                     power = getPower(power,max,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                     break;
                  }
                  if(Ey.x0 < enemyPos.y)
                  {
                     timeTemp = true;
                  }
               }
               else if(timeTemp)
               {
                  if(Ey.x0 > enemyPos.y)
                  {
                     if(Ex.x0 > enemyPos.x)
                     {
                        power = getPower(power,max,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                     }
                     else
                     {
                        power = getPower(min,power,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                     }
                     break;
                  }
               }
            }
            else if(!xS_Lef_E && yS_Up_E)
            {
               if(Ey.x0 > enemyPos.y)
               {
                  if(Ex.x0 > enemyPos.x)
                  {
                     power = getPower(power,max,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                  }
                  else
                  {
                     power = getPower(min,power,shootPos,enemyPos,shootAngle,xS_Lef_E,yS_Up_E);
                  }
                  break;
               }
            }
         }
         return power;
      }
      
      private function getRouteData(power:Number, shootAngle:Number, shootPos:Point, enemyPos:Point) : Vector.<Point>
      {
         var Ex:* = null;
         var Ey:* = null;
         var vx:int = 0;
         var vy:int = 0;
         if(power > 2000)
         {
            return null;
         }
         vx = power * Math.cos(shootAngle / 180 * 3.14159265358979);
         Ex = new EulerVector(shootPos.x,vx,_wa);
         vy = power * Math.sin(shootAngle / 180 * 3.14159265358979);
         Ey = new EulerVector(shootPos.y,vy,_ga);
         var ary:Vector.<Point> = new Vector.<Point>();
         ary.push(new Point(shootPos.x,shootPos.y));
         while(!isOutOfMap(Ex,Ey))
         {
            if(ifHit(Ex.x0,Ey.x0,enemyPos))
            {
               return ary;
            }
            Ex.ComputeOneEulerStep(_mass,_arf,curWind,_dt);
            Ey.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            ary.push(new Point(Ex.x0,Ey.x0));
         }
         return ary;
      }
      
      private function isOutOfMap(ex:EulerVector, ey:EulerVector) : Boolean
      {
         if(ex.x0 < map.bound.x || ex.x0 > map.bound.width || ey.x0 > map.bound.height)
         {
            return true;
         }
         return false;
      }
      
      public function get currentLivID() : int
      {
         return _currentLivID;
      }
      
      public function set currentLivID(value:int) : void
      {
         _currentLivID = value;
      }
      
      private function drawRouteLine(id:int) : void
      {
         var i:int = 0;
         _drawRoute.graphics.clear();
         var _loc8_:int = 0;
         var _loc7_:* = gameInfo.livings;
         for each(var liv in gameInfo.livings)
         {
            liv.currentSelectId = id;
         }
         if(id < 0)
         {
            return;
         }
         var living:Living = gameInfo.livings[id];
         if(!living)
         {
            return;
         }
         var data:Vector.<Point> = living.route;
         if(!data || data.length == 0)
         {
            return;
         }
         _collideRect.x = living.pos.x - 50;
         _collideRect.y = living.pos.y - 50;
         _drawRoute.graphics.lineStyle(2,16711680,0.5);
         var length:int = data.length;
         for(i = 0; i < length - 1; )
         {
            drawDashed(_drawRoute.graphics,data[i],data[i + 1],8,5);
            i++;
         }
      }
      
      public function drawDashed(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number, grap:Number) : void
      {
         var y:Number = NaN;
         var x:Number = NaN;
         if(!graphics || !beginPoint || !endPoint || width <= 0 || grap <= 0)
         {
            return;
         }
         var Ox:Number = beginPoint.x;
         var Oy:Number = beginPoint.y;
         var radian:Number = Math.atan2(endPoint.y - Oy,endPoint.x - Ox);
         var totalLen:Number = Point.distance(beginPoint,endPoint);
         trace("big map :" + totalLen);
         var currLen:* = 0;
         while(currLen <= totalLen)
         {
            if(_collideRect.contains(x,y))
            {
               return;
            }
            x = Ox + Math.cos(radian) * currLen;
            y = Oy + Math.sin(radian) * currLen;
            graphics.moveTo(x,y);
            currLen = Number(currLen + width);
            if(currLen > totalLen)
            {
               currLen = totalLen;
            }
            x = Ox + Math.cos(radian) * currLen;
            y = Oy + Math.sin(radian) * currLen;
            graphics.lineTo(x,y);
            currLen = Number(currLen + grap);
         }
      }
      
      private function calculateRecent() : int
      {
         var livRoute:* = undefined;
         var length:int = 0;
         var distance:int = 0;
         var min:* = 2147483647;
         var ret:int = -1;
         var _loc8_:int = 0;
         var _loc7_:* = gameInfo.livings;
         for each(var liv in gameInfo.livings)
         {
            if(liv.route)
            {
               if(RoomManager.Instance.current.type == 49 || !(liv is SmallEnemy))
               {
                  livRoute = liv.route;
                  length = livRoute.length;
                  if(length >= 2)
                  {
                     distance = getDistance(livRoute[0],livRoute[length - 1]);
                     if(distance < min)
                     {
                        min = distance;
                        ret = liv.LivingID;
                     }
                  }
               }
            }
         }
         return ret;
      }
      
      private function getDistance(start:Point, end:Point) : int
      {
         return (end.x - start.x) * (end.x - start.x) + (end.y - start.y) * (end.y - start.y);
      }
      
      private function setKeyEventDisenable(value:Boolean) : void
      {
         KeyboardManager.getInstance().isStopDispatching = value;
      }
   }
}
