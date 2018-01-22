package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class BezierPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
      
      protected static const _RAD2DEG:Number = 57.29577951308232;
       
      
      protected var _target:Object;
      
      protected var _orientData:Array;
      
      protected var _orient:Boolean;
      
      protected var _future:Object;
      
      protected var _beziers:Object;
      
      public function BezierPlugin()
      {
         _future = {};
         super();
         this.propName = "bezier";
         this.overwriteProps = [];
      }
      
      public static function parseBeziers(param1:Object, param2:Boolean = false) : Object
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc6_:Object = {};
         if(param2)
         {
            var _loc9_:int = 0;
            var _loc8_:* = param1;
            for(_loc4_ in param1)
            {
               _loc5_ = param1[_loc4_];
               _loc3_ = [];
               _loc6_[_loc4_] = [];
               if(_loc5_.length > 2)
               {
                  _loc3_[_loc3_.length] = [_loc5_[0],_loc5_[1] - (_loc5_[2] - _loc5_[0]) / 4,_loc5_[1]];
                  _loc7_ = 1;
                  while(_loc7_ < _loc5_.length - 1)
                  {
                     _loc3_[_loc3_.length] = [_loc5_[_loc7_],_loc5_[_loc7_] + (_loc5_[_loc7_] - _loc3_[_loc7_ - 1][1]),_loc5_[_loc7_ + 1]];
                     _loc7_ = _loc7_ + 1;
                  }
               }
               else
               {
                  _loc3_[_loc3_.length] = [_loc5_[0],(_loc5_[0] + _loc5_[1]) / 2,_loc5_[1]];
               }
            }
         }
         else
         {
            var _loc11_:int = 0;
            var _loc10_:* = param1;
            for(_loc4_ in param1)
            {
               _loc5_ = param1[_loc4_];
               _loc3_ = [];
               _loc6_[_loc4_] = [];
               if(_loc5_.length > 3)
               {
                  _loc3_[_loc3_.length] = [_loc5_[0],_loc5_[1],(_loc5_[1] + _loc5_[2]) / 2];
                  _loc7_ = 2;
                  while(_loc7_ < _loc5_.length - 2)
                  {
                     _loc3_[_loc3_.length] = [_loc3_[_loc7_ - 2][2],_loc5_[_loc7_],(_loc5_[_loc7_] + _loc5_[_loc7_ + 1]) / 2];
                     _loc7_ = _loc7_ + 1;
                  }
                  _loc3_[_loc3_.length] = [_loc3_[_loc3_.length - 1][2],_loc5_[_loc5_.length - 2],_loc5_[_loc5_.length - 1]];
               }
               else if(_loc5_.length == 3)
               {
                  _loc3_[_loc3_.length] = [_loc5_[0],_loc5_[1],_loc5_[2]];
               }
               else if(_loc5_.length == 2)
               {
                  _loc3_[_loc3_.length] = [_loc5_[0],(_loc5_[0] + _loc5_[1]) / 2,_loc5_[1]];
               }
            }
         }
         return _loc6_;
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param2 is Array))
         {
            return false;
         }
         init(param3,param2 as Array,false);
         return true;
      }
      
      protected function init(param1:TweenLite, param2:Array, param3:Boolean) : void
      {
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         _target = param1.target;
         var _loc4_:Object = param1.vars.isTV == true?param1.vars.exposedVars:param1.vars;
         if(_loc4_.orientToBezier == true)
         {
            _orientData = [["x","y","rotation",0,0.01]];
            _orient = true;
         }
         else if(_loc4_.orientToBezier is Array)
         {
            _orientData = _loc4_.orientToBezier;
            _orient = true;
         }
         var _loc7_:Object = {};
         _loc8_ = 0;
         while(_loc8_ < param2.length)
         {
            var _loc10_:int = 0;
            var _loc9_:* = param2[_loc8_];
            for(_loc5_ in param2[_loc8_])
            {
               if(_loc7_[_loc5_] == undefined)
               {
                  _loc7_[_loc5_] = [param1.target[_loc5_]];
               }
               if(typeof param2[_loc8_][_loc5_] == "number")
               {
                  _loc7_[_loc5_].push(param2[_loc8_][_loc5_]);
               }
               else
               {
                  _loc7_[_loc5_].push(param1.target[_loc5_] + Number(param2[_loc8_][_loc5_]));
               }
            }
            _loc8_ = _loc8_ + 1;
         }
         var _loc12_:int = 0;
         var _loc11_:* = _loc7_;
         for(this.overwriteProps[this.overwriteProps.length] in _loc7_)
         {
            if(_loc4_[_loc5_] != undefined)
            {
               if(typeof _loc4_[_loc5_] == "number")
               {
                  _loc7_[_loc5_].push(_loc4_[_loc5_]);
               }
               else
               {
                  _loc7_[_loc5_].push(param1.target[_loc5_] + Number(_loc4_[_loc5_]));
               }
               _loc6_ = {};
               _loc6_[_loc5_] = true;
               param1.killVars(_loc6_,false);
               delete _loc4_[_loc5_];
            }
         }
         _beziers = parseBeziers(_loc7_,param3);
      }
      
      override public function killProps(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _beziers;
         for(var _loc2_ in _beziers)
         {
            if(_loc2_ in param1)
            {
               delete _beziers[_loc2_];
            }
         }
         super.killProps(param1);
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc12_:* = null;
         var _loc5_:* = null;
         var _loc10_:Number = NaN;
         var _loc6_:int = 0;
         var _loc2_:Number = NaN;
         var _loc9_:* = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc14_:* = null;
         var _loc11_:Number = NaN;
         var _loc3_:* = null;
         var _loc13_:* = null;
         _changeFactor = param1;
         if(param1 == 1)
         {
            var _loc16_:int = 0;
            var _loc15_:* = _beziers;
            for(_loc12_ in _beziers)
            {
               _loc9_ = int(_beziers[_loc12_].length - 1);
               _target[_loc12_] = _beziers[_loc12_][_loc9_][2];
            }
         }
         else
         {
            var _loc18_:int = 0;
            var _loc17_:* = _beziers;
            for(_loc12_ in _beziers)
            {
               _loc6_ = _beziers[_loc12_].length;
               if(param1 < 0)
               {
                  _loc9_ = 0;
               }
               else if(param1 >= 1)
               {
                  _loc9_ = int(_loc6_ - 1);
               }
               else
               {
                  _loc9_ = _loc6_ * param1 >> 0;
               }
               _loc10_ = (param1 - _loc9_ * (1 / _loc6_)) * _loc6_;
               _loc5_ = _beziers[_loc12_][_loc9_];
               if(this.round)
               {
                  _loc2_ = _loc5_[0] + _loc10_ * (2 * (1 - _loc10_) * (_loc5_[1] - _loc5_[0]) + _loc10_ * (_loc5_[2] - _loc5_[0]));
                  if(_loc2_ > 0)
                  {
                     _target[_loc12_] = _loc2_ + 0.5 >> 0;
                  }
                  else
                  {
                     _target[_loc12_] = _loc2_ - 0.5 >> 0;
                  }
               }
               else
               {
                  _target[_loc12_] = _loc5_[0] + _loc10_ * (2 * (1 - _loc10_) * (_loc5_[1] - _loc5_[0]) + _loc10_ * (_loc5_[2] - _loc5_[0]));
               }
            }
         }
         if(_orient)
         {
            _loc9_ = int(_orientData.length);
            _loc3_ = {};
            while(true)
            {
               _loc9_--;
               if(!_loc9_)
               {
                  break;
               }
               _loc14_ = _orientData[_loc9_];
               _loc3_[_loc14_[0]] = _target[_loc14_[0]];
               _loc3_[_loc14_[1]] = _target[_loc14_[1]];
            }
            _loc13_ = _target;
            var _loc4_:Boolean = this.round;
            _target = _future;
            this.round = false;
            _orient = false;
            _loc9_ = int(_orientData.length);
            while(true)
            {
               _loc9_--;
               if(!_loc9_)
               {
                  break;
               }
               _loc14_ = _orientData[_loc9_];
               this.changeFactor = param1 + (_loc14_[4] || 0.01);
               _loc11_ = _loc14_[3] || 0;
               _loc7_ = _future[_loc14_[0]] - _loc3_[_loc14_[0]];
               _loc8_ = _future[_loc14_[1]] - _loc3_[_loc14_[1]];
               _loc13_[_loc14_[2]] = Math.atan2(_loc8_,_loc7_) * 57.2957795130823 + _loc11_;
            }
            _target = _loc13_;
            this.round = _loc4_;
            _orient = true;
         }
      }
   }
}
