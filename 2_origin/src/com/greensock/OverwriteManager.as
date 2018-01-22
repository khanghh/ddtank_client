package com.greensock
{
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.TweenCore;
   
   public final class OverwriteManager
   {
      
      public static const version:Number = 6.1;
      
      public static const NONE:int = 0;
      
      public static const ALL_IMMEDIATE:int = 1;
      
      public static const AUTO:int = 2;
      
      public static const CONCURRENT:int = 3;
      
      public static const ALL_ONSTART:int = 4;
      
      public static const PREEXISTING:int = 5;
      
      public static var mode:int;
      
      public static var enabled:Boolean;
       
      
      public function OverwriteManager()
      {
         super();
      }
      
      public static function init(param1:int = 2) : int
      {
         TweenLite.overwriteManager = OverwriteManager;
         mode = param1;
         enabled = true;
         return mode;
      }
      
      public static function manageOverwrites(param1:TweenLite, param2:Object, param3:Array, param4:int) : Boolean
      {
         var _loc10_:Boolean = false;
         var _loc15_:* = null;
         var _loc11_:* = 0;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc14_:Number = NaN;
         var _loc5_:* = null;
         var _loc6_:Number = NaN;
         if(param4 >= 4)
         {
            _loc8_ = param3.length;
            _loc11_ = 0;
            while(_loc11_ < _loc8_)
            {
               _loc15_ = param3[_loc11_];
               if(_loc15_ != param1)
               {
                  if(_loc15_.setEnabled(false,false))
                  {
                     _loc10_ = true;
                  }
               }
               else if(param4 == 5)
               {
                  break;
               }
               _loc11_++;
            }
            return _loc10_;
         }
         var _loc12_:Number = param1.cachedStartTime + 1.0e-10;
         var _loc13_:Array = [];
         var _loc17_:Array = [];
         var _loc18_:int = 0;
         var _loc9_:int = 0;
         _loc11_ = int(param3.length);
         while(true)
         {
            _loc11_--;
            if(_loc11_ <= -1)
            {
               break;
            }
            _loc15_ = param3[_loc11_];
            if(!(_loc15_ == param1 || _loc15_.gc || !_loc15_.initted && _loc12_ - _loc15_.cachedStartTime <= 2.0e-10))
            {
               if(_loc15_.timeline != param1.timeline)
               {
                  if(!getGlobalPaused(_loc15_))
                  {
                     _loc18_++;
                     _loc17_[_loc18_] = _loc15_;
                  }
               }
               else if(_loc15_.cachedStartTime <= _loc12_ && _loc15_.cachedStartTime + _loc15_.totalDuration + 1.0e-10 > _loc12_ && !_loc15_.cachedPaused && !(param1.cachedDuration == 0 && _loc12_ - _loc15_.cachedStartTime <= 2.0e-10))
               {
                  _loc9_++;
                  _loc13_[_loc9_] = _loc15_;
               }
            }
         }
         if(_loc18_ != 0)
         {
            _loc6_ = param1.cachedTimeScale;
            var _loc16_:* = _loc12_;
            _loc5_ = param1.timeline;
            while(_loc5_)
            {
               _loc6_ = _loc6_ * _loc5_.cachedTimeScale;
               _loc16_ = Number(_loc16_ + _loc5_.cachedStartTime);
               _loc5_ = _loc5_.timeline;
            }
            _loc12_ = _loc6_ * _loc16_;
            _loc11_ = _loc18_;
            while(true)
            {
               _loc11_--;
               if(_loc11_ <= -1)
               {
                  break;
               }
               _loc7_ = _loc17_[_loc11_];
               _loc6_ = _loc7_.cachedTimeScale;
               _loc16_ = Number(_loc7_.cachedStartTime);
               _loc5_ = _loc7_.timeline;
               while(_loc5_)
               {
                  _loc6_ = _loc6_ * _loc5_.cachedTimeScale;
                  _loc16_ = Number(_loc16_ + _loc5_.cachedStartTime);
                  _loc5_ = _loc5_.timeline;
               }
               _loc14_ = _loc6_ * _loc16_;
               if(_loc14_ <= _loc12_ && (_loc14_ + _loc7_.totalDuration * _loc6_ + 1.0e-10 > _loc12_ || _loc7_.cachedDuration == 0))
               {
                  _loc9_++;
                  _loc13_[_loc9_] = _loc7_;
               }
            }
         }
         if(_loc9_ == 0)
         {
            return _loc10_;
         }
         _loc11_ = _loc9_;
         if(param4 == 2)
         {
            while(true)
            {
               _loc11_--;
               if(_loc11_ <= -1)
               {
                  break;
               }
               _loc15_ = _loc13_[_loc11_];
               if(_loc15_.killVars(param2))
               {
                  _loc10_ = true;
               }
               if(_loc15_.cachedPT1 == null && _loc15_.initted)
               {
                  _loc15_.setEnabled(false,false);
               }
            }
         }
         else
         {
            while(true)
            {
               _loc11_--;
               if(_loc11_ <= -1)
               {
                  break;
               }
               if(TweenLite(_loc13_[_loc11_]).setEnabled(false,false))
               {
                  _loc10_ = true;
               }
            }
         }
         return _loc10_;
      }
      
      public static function getGlobalPaused(param1:TweenCore) : Boolean
      {
         var _loc2_:Boolean = false;
         while(param1)
         {
            if(param1.cachedPaused)
            {
               _loc2_ = true;
               break;
            }
            param1 = param1.timeline;
         }
         return _loc2_;
      }
   }
}
