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
               var _loc1_:* = NaN;
               var _loc6_:Boolean = false;
               var _loc7_:Boolean = false;
               var _loc5_:* = null;
               var _loc3_:* = null;
               var _loc8_:* = null;
               var _loc4_:Number = NaN;
               var _loc2_:Number = NaN;
               if(_isAuto)
               {
                  if(gameInfo == null || selfPlayer == null || map == null)
                  {
                     return;
                  }
                  _loc6_ = true;
                  _loc7_ = true;
                  _loc5_ = getSelfPoint();
                  _loc3_ = getTarget(_loc5_);
                  if(_loc3_ == null)
                  {
                     return;
                  }
                  _loc8_ = _loc3_.pos;
                  _loc3_.route = null;
                  selfPlayer.direction = _loc5_.x > _loc8_.x?-1:1;
                  selfPlayer.manuallySetGunAngle(25 - selfPlayer.playerAngle * -1 * selfPlayer.direction);
                  _loc4_ = selfPlayer.calcBombAngle();
                  _arf = map.airResistance;
                  _gf = map.gravity * _mass * _gravityFactor;
                  _ga = _gf / _mass;
                  _wa = curWind / _mass;
                  if(selfPlayer.isLiving && selfPlayer.isAttacking)
                  {
                     if(_loc5_.x > _loc8_.x)
                     {
                        _loc6_ = false;
                     }
                     if(_loc5_.y > _loc8_.y)
                     {
                        _loc7_ = false;
                     }
                     _loc2_ = Math.abs(_loc5_.x - _loc8_.x);
                     if(_loc2_ <= 40)
                     {
                        _loc1_ = 10;
                     }
                     else if(judgeMaxPower(_loc5_,_loc8_,_loc4_,_loc6_,_loc7_))
                     {
                        _loc1_ = Number(getPower(0,2000,_loc5_,_loc8_,_loc4_,_loc6_,_loc7_));
                     }
                     else
                     {
                        _loc1_ = Number(2100);
                     }
                     _stateFlag = 0;
                     if(_loc1_ > 2000)
                     {
                        if(_loc3_.state)
                        {
                           _stateFlag = 1;
                        }
                        else
                        {
                           _stateFlag = 2;
                        }
                        _loc3_.state = false;
                     }
                     else
                     {
                        if(_loc3_.state)
                        {
                           _stateFlag = 3;
                        }
                        else
                        {
                           _stateFlag = 4;
                        }
                        _loc3_.state = true;
                     }
                     if(_stateFlag == 1 || _stateFlag == 2)
                     {
                        _loc3_.route = null;
                     }
                     else
                     {
                        _loc3_.route = getRouteData(_loc1_,_loc4_,_loc5_,_loc8_);
                     }
                     if(currentLivID == -1 || !gameInfo.livings[currentLivID].route)
                     {
                        currentLivID = calculateRecent();
                     }
                     else
                     {
                        currentLivID = _loc3_.LivingID;
                     }
                     if(_loc1_ < 2100)
                     {
                        selfPlayer.force = _loc1_;
                     }
                     selfPlayer.dispatchEvent(new LivingEvent("sendShootAction",0,0,_loc1_));
                     setKeyEventDisenable(false);
                  }
               }
            };
            return function():void
            {
               var _loc1_:* = NaN;
               var _loc6_:Boolean = false;
               var _loc7_:Boolean = false;
               var _loc5_:* = null;
               var _loc3_:* = null;
               var _loc8_:* = null;
               var _loc4_:Number = NaN;
               var _loc2_:Number = NaN;
               if(_isAuto)
               {
                  if(gameInfo == null || selfPlayer == null || map == null)
                  {
                     return;
                  }
                  _loc6_ = true;
                  _loc7_ = true;
                  _loc5_ = getSelfPoint();
                  _loc3_ = getTarget(_loc5_);
                  if(_loc3_ == null)
                  {
                     return;
                  }
                  _loc8_ = _loc3_.pos;
                  _loc3_.route = null;
                  selfPlayer.direction = _loc5_.x > _loc8_.x?-1:1;
                  selfPlayer.manuallySetGunAngle(25 - selfPlayer.playerAngle * -1 * selfPlayer.direction);
                  _loc4_ = selfPlayer.calcBombAngle();
                  _arf = map.airResistance;
                  _gf = map.gravity * _mass * _gravityFactor;
                  _ga = _gf / _mass;
                  _wa = curWind / _mass;
                  if(selfPlayer.isLiving && selfPlayer.isAttacking)
                  {
                     if(_loc5_.x > _loc8_.x)
                     {
                        _loc6_ = false;
                     }
                     if(_loc5_.y > _loc8_.y)
                     {
                        _loc7_ = false;
                     }
                     _loc2_ = Math.abs(_loc5_.x - _loc8_.x);
                     if(_loc2_ <= 40)
                     {
                        _loc1_ = 10;
                     }
                     else if(judgeMaxPower(_loc5_,_loc8_,_loc4_,_loc6_,_loc7_))
                     {
                        _loc1_ = Number(getPower(0,2000,_loc5_,_loc8_,_loc4_,_loc6_,_loc7_));
                     }
                     else
                     {
                        _loc1_ = Number(2100);
                     }
                     _stateFlag = 0;
                     if(_loc1_ > 2000)
                     {
                        if(_loc3_.state)
                        {
                           _stateFlag = 1;
                        }
                        else
                        {
                           _stateFlag = 2;
                        }
                        _loc3_.state = false;
                     }
                     else
                     {
                        if(_loc3_.state)
                        {
                           _stateFlag = 3;
                        }
                        else
                        {
                           _stateFlag = 4;
                        }
                        _loc3_.state = true;
                     }
                     if(_stateFlag == 1 || _stateFlag == 2)
                     {
                        _loc3_.route = null;
                     }
                     else
                     {
                        _loc3_.route = getRouteData(_loc1_,_loc4_,_loc5_,_loc8_);
                     }
                     if(currentLivID == -1 || !gameInfo.livings[currentLivID].route)
                     {
                        currentLivID = calculateRecent();
                     }
                     else
                     {
                        currentLivID = _loc3_.LivingID;
                     }
                     if(_loc1_ < 2100)
                     {
                        selfPlayer.force = _loc1_;
                     }
                     selfPlayer.dispatchEvent(new LivingEvent("sendShootAction",0,0,_loc1_));
                     setKeyEventDisenable(false);
                  }
               }
            };
         }());
      }
      
      private function readyShoot(param1:Function) : void
      {
         initAddKey();
         exeKeyBoard(param1);
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
      
      private function exeKeyBoard(param1:Function) : void
      {
         calFun = param1;
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
      
      private function addKeyBoard(param1:int, param2:Function = null) : void
      {
         _keyBoards.push({
            "type":"keyDown",
            "code":param1,
            "backFun":null
         });
         _keyBoards.push({
            "type":"keyUp",
            "code":param1,
            "backFun":param2
         });
      }
      
      private function getTarget(param1:Point) : Living
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = 2147483647;
         var _loc4_:DictionaryData = gameInfo.livings;
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_;
         for each(var _loc2_ in _loc4_)
         {
            if(!(_loc2_.team == selfPlayer.team || !_loc2_.isLiving || _loc2_.LivingID == selfPlayer.LivingID))
            {
               _loc6_ = Math.abs(param1.x - _loc2_.pos.x);
               if(_loc6_ < _loc3_)
               {
                  _loc3_ = _loc6_;
                  _loc5_ = _loc2_;
               }
            }
         }
         return _loc5_;
      }
      
      private function getSelfPoint() : Point
      {
         return localToGlcbalByPoint((gameInfo.selfGamePlayer.movie as GameCharacter).localToGlobal(new Point(30,-20)));
      }
      
      private function localToGlcbalByPoint(param1:Point) : Point
      {
         if(selfPlayer.currentMap)
         {
            return selfPlayer.currentMap.globalToLocal(param1);
         }
         return new Point(0,0);
      }
      
      private function get map() : MapView
      {
         return selfPlayer.currentMap;
      }
      
      public function setAutoState(param1:Boolean) : void
      {
         if(_isAuto != param1)
         {
            _isAuto = param1;
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
      
      public function updateWind(param1:Number) : void
      {
         _curWind = param1 / 10 * _windFactor;
      }
      
      private function get curWind() : Number
      {
         return _curWind;
      }
      
      private function __autoShootHandler(param1:LivingEvent) : void
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
      
      protected function judgeMaxPower(param1:Point, param2:Point, param3:Number, param4:Boolean, param5:Boolean) : Boolean
      {
         var _loc10_:* = null;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         _loc7_ = 2000 * Math.cos(param3 / 180 * 3.14159265358979);
         _loc10_ = new EulerVector(param1.x,_loc7_,_wa);
         _loc6_ = 2000 * Math.sin(param3 / 180 * 3.14159265358979);
         _loc8_ = new EulerVector(param1.y,_loc6_,_ga);
         var _loc9_:Boolean = false;
         while(true)
         {
            if(param4)
            {
               if(_loc10_.x0 > map.bound.width)
               {
                  return true;
               }
               if(_loc10_.x0 < map.bound.x || _loc8_.x0 > map.bound.height)
               {
                  return false;
               }
            }
            else
            {
               if(_loc10_.x0 < map.bound.x)
               {
                  break;
               }
               if(_loc10_.x0 > map.bound.width || _loc8_.x0 > map.bound.height)
               {
                  return false;
               }
            }
            if(ifHit(_loc10_.x0,_loc8_.x0,param2))
            {
               return true;
            }
            _loc10_.ComputeOneEulerStep(_mass,_arf,curWind,_dt);
            _loc8_.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            if(param4 && param5)
            {
               if(_loc8_.x0 > param2.y)
               {
                  if(_loc10_.x0 < param2.x)
                  {
                     return false;
                  }
                  return true;
               }
            }
            else if(param4 && !param5)
            {
               if(!_loc9_)
               {
                  if(_loc10_.x0 > param2.x)
                  {
                     return false;
                  }
                  if(_loc8_.x0 < param2.y)
                  {
                     _loc9_ = true;
                  }
               }
               else if(_loc9_)
               {
                  if(_loc8_.x0 > param2.y)
                  {
                     if(_loc10_.x0 < param2.x)
                     {
                        return false;
                     }
                     return true;
                  }
               }
            }
            else if(!param4 && !param5)
            {
               if(!_loc9_)
               {
                  if(_loc10_.x0 < param2.x)
                  {
                     return false;
                  }
                  if(_loc8_.x0 < param2.y)
                  {
                     _loc9_ = true;
                  }
               }
               else if(_loc9_)
               {
                  if(_loc8_.x0 > param2.y)
                  {
                     if(_loc10_.x0 < param2.x)
                     {
                        return true;
                     }
                     return false;
                  }
               }
            }
            else if(!param4 && param5)
            {
               if(_loc8_.x0 > param2.y)
               {
                  if(_loc10_.x0 < param2.x)
                  {
                     return true;
                  }
                  return false;
               }
            }
         }
         return true;
      }
      
      protected function ifHit(param1:Number, param2:Number, param3:Point) : Boolean
      {
         if(param1 > param3.x - 15 && param1 < param3.x + 20 && param2 > param3.y - 20 && param2 < param3.y + 30)
         {
            return true;
         }
         return false;
      }
      
      protected function getPower(param1:Number, param2:Number, param3:Point, param4:Point, param5:Number, param6:Boolean, param7:Boolean) : Number
      {
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:int = (param1 + param2) / 2;
         if(_loc12_ <= param1 || _loc12_ >= param2)
         {
            return _loc12_;
         }
         _loc11_ = _loc12_ * Math.cos(param5 / 180 * 3.14159265358979);
         _loc9_ = new EulerVector(param3.x,_loc11_,_wa);
         _loc10_ = _loc12_ * Math.sin(param5 / 180 * 3.14159265358979);
         _loc8_ = new EulerVector(param3.y,_loc10_,_ga);
         var _loc13_:Boolean = false;
         while(true)
         {
            if(param6)
            {
               if(_loc9_.x0 > map.bound.width)
               {
                  _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                  break;
               }
               if(_loc8_.x0 > map.bound.height)
               {
                  _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                  break;
               }
               if(_loc9_.x0 < map.bound.x)
               {
                  _loc12_ = 2100;
                  return 2100;
               }
            }
            else
            {
               if(_loc9_.x0 < map.bound.x)
               {
                  _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                  break;
               }
               if(_loc8_.x0 > map.bound.height)
               {
                  _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                  break;
               }
               if(_loc9_.x0 > map.bound.width)
               {
                  _loc12_ = 2100;
                  return 2100;
               }
            }
            if(ifHit(_loc9_.x0,_loc8_.x0,param4))
            {
               return _loc12_;
            }
            _loc9_.ComputeOneEulerStep(_mass,_arf,curWind,_dt);
            _loc8_.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            if(param6 && param7)
            {
               if(_loc8_.x0 > param4.y)
               {
                  if(_loc9_.x0 < param4.x)
                  {
                     _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                  }
                  else
                  {
                     _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                  }
                  break;
               }
            }
            else if(param6 && !param7)
            {
               if(!_loc13_)
               {
                  if(_loc9_.x0 > param4.x)
                  {
                     _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                     break;
                  }
                  if(_loc8_.x0 < param4.y)
                  {
                     _loc13_ = true;
                  }
               }
               else if(_loc13_)
               {
                  if(_loc8_.x0 > param4.y)
                  {
                     if(_loc9_.x0 < param4.x)
                     {
                        _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                     }
                     else
                     {
                        _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                     }
                     break;
                  }
               }
            }
            else if(!param6 && !param7)
            {
               if(!_loc13_)
               {
                  if(_loc9_.x0 < param4.x)
                  {
                     _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                     break;
                  }
                  if(_loc8_.x0 < param4.y)
                  {
                     _loc13_ = true;
                  }
               }
               else if(_loc13_)
               {
                  if(_loc8_.x0 > param4.y)
                  {
                     if(_loc9_.x0 > param4.x)
                     {
                        _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                     }
                     else
                     {
                        _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                     }
                     break;
                  }
               }
            }
            else if(!param6 && param7)
            {
               if(_loc8_.x0 > param4.y)
               {
                  if(_loc9_.x0 > param4.x)
                  {
                     _loc12_ = getPower(_loc12_,param2,param3,param4,param5,param6,param7);
                  }
                  else
                  {
                     _loc12_ = getPower(param1,_loc12_,param3,param4,param5,param6,param7);
                  }
                  break;
               }
            }
         }
         return _loc12_;
      }
      
      private function getRouteData(param1:Number, param2:Number, param3:Point, param4:Point) : Vector.<Point>
      {
         var _loc9_:* = null;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(param1 > 2000)
         {
            return null;
         }
         _loc6_ = param1 * Math.cos(param2 / 180 * 3.14159265358979);
         _loc9_ = new EulerVector(param3.x,_loc6_,_wa);
         _loc5_ = param1 * Math.sin(param2 / 180 * 3.14159265358979);
         _loc7_ = new EulerVector(param3.y,_loc5_,_ga);
         var _loc8_:Vector.<Point> = new Vector.<Point>();
         _loc8_.push(new Point(param3.x,param3.y));
         while(!isOutOfMap(_loc9_,_loc7_))
         {
            if(ifHit(_loc9_.x0,_loc7_.x0,param4))
            {
               return _loc8_;
            }
            _loc9_.ComputeOneEulerStep(_mass,_arf,curWind,_dt);
            _loc7_.ComputeOneEulerStep(_mass,_arf,_gf,_dt);
            _loc8_.push(new Point(_loc9_.x0,_loc7_.x0));
         }
         return _loc8_;
      }
      
      private function isOutOfMap(param1:EulerVector, param2:EulerVector) : Boolean
      {
         if(param1.x0 < map.bound.x || param1.x0 > map.bound.width || param2.x0 > map.bound.height)
         {
            return true;
         }
         return false;
      }
      
      public function get currentLivID() : int
      {
         return _currentLivID;
      }
      
      public function set currentLivID(param1:int) : void
      {
         _currentLivID = param1;
      }
      
      private function drawRouteLine(param1:int) : void
      {
         var _loc6_:int = 0;
         _drawRoute.graphics.clear();
         var _loc8_:int = 0;
         var _loc7_:* = gameInfo.livings;
         for each(var _loc5_ in gameInfo.livings)
         {
            _loc5_.currentSelectId = param1;
         }
         if(param1 < 0)
         {
            return;
         }
         var _loc4_:Living = gameInfo.livings[param1];
         if(!_loc4_)
         {
            return;
         }
         var _loc3_:Vector.<Point> = _loc4_.route;
         if(!_loc3_ || _loc3_.length == 0)
         {
            return;
         }
         _collideRect.x = _loc4_.pos.x - 50;
         _collideRect.y = _loc4_.pos.y - 50;
         _drawRoute.graphics.lineStyle(2,16711680,0.5);
         var _loc2_:int = _loc3_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_ - 1)
         {
            drawDashed(_drawRoute.graphics,_loc3_[_loc6_],_loc3_[_loc6_ + 1],8,5);
            _loc6_++;
         }
      }
      
      public function drawDashed(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:Number) : void
      {
         var _loc9_:Number = NaN;
         var _loc11_:Number = NaN;
         if(!param1 || !param2 || !param3 || param4 <= 0 || param5 <= 0)
         {
            return;
         }
         var _loc8_:Number = param2.x;
         var _loc10_:Number = param2.y;
         var _loc12_:Number = Math.atan2(param3.y - _loc10_,param3.x - _loc8_);
         var _loc7_:Number = Point.distance(param2,param3);
         trace("big map :" + _loc7_);
         var _loc6_:* = 0;
         while(_loc6_ <= _loc7_)
         {
            if(_collideRect.contains(_loc11_,_loc9_))
            {
               return;
            }
            _loc11_ = _loc8_ + Math.cos(_loc12_) * _loc6_;
            _loc9_ = _loc10_ + Math.sin(_loc12_) * _loc6_;
            param1.moveTo(_loc11_,_loc9_);
            _loc6_ = Number(_loc6_ + param4);
            if(_loc6_ > _loc7_)
            {
               _loc6_ = _loc7_;
            }
            _loc11_ = _loc8_ + Math.cos(_loc12_) * _loc6_;
            _loc9_ = _loc10_ + Math.sin(_loc12_) * _loc6_;
            param1.lineTo(_loc11_,_loc9_);
            _loc6_ = Number(_loc6_ + param5);
         }
      }
      
      private function calculateRecent() : int
      {
         var _loc3_:* = undefined;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = 2147483647;
         var _loc1_:int = -1;
         var _loc8_:int = 0;
         var _loc7_:* = gameInfo.livings;
         for each(var _loc6_ in gameInfo.livings)
         {
            if(_loc6_.route)
            {
               if(RoomManager.Instance.current.type == 49 || !(_loc6_ is SmallEnemy))
               {
                  _loc3_ = _loc6_.route;
                  _loc5_ = _loc3_.length;
                  if(_loc5_ >= 2)
                  {
                     _loc4_ = getDistance(_loc3_[0],_loc3_[_loc5_ - 1]);
                     if(_loc4_ < _loc2_)
                     {
                        _loc2_ = _loc4_;
                        _loc1_ = _loc6_.LivingID;
                     }
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function getDistance(param1:Point, param2:Point) : int
      {
         return (param2.x - param1.x) * (param2.x - param1.x) + (param2.y - param1.y) * (param2.y - param1.y);
      }
      
      private function setKeyEventDisenable(param1:Boolean) : void
      {
         KeyboardManager.getInstance().isStopDispatching = param1;
      }
   }
}
