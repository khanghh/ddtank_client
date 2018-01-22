package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class EndArrayPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _a:Array;
      
      protected var _info:Array;
      
      public function EndArrayPlugin()
      {
         _info = [];
         super();
         this.propName = "endArray";
         this.overwriteProps = ["endArray"];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is Array) || !(param2 is Array))
         {
            return false;
         }
         init(param1 as Array,param2);
         return true;
      }
      
      public function init(param1:Array, param2:Array) : void
      {
         _a = param1;
         var _loc3_:int = param2.length;
         while(true)
         {
            _loc3_--;
            if(!_loc3_)
            {
               break;
            }
            if(param1[_loc3_] != param2[_loc3_] && param1[_loc3_] != null)
            {
               _info[_info.length] = new ArrayTweenInfo(_loc3_,_a[_loc3_],param2[_loc3_] - _a[_loc3_]);
            }
         }
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         var _loc4_:int = _info.length;
         if(this.round)
         {
            while(true)
            {
               _loc4_--;
               if(!_loc4_)
               {
                  break;
               }
               _loc3_ = _info[_loc4_];
               _loc2_ = _loc3_.start + _loc3_.change * param1;
               if(_loc2_ > 0)
               {
                  _a[_loc3_.index] = _loc2_ + 0.5 >> 0;
               }
               else
               {
                  _a[_loc3_.index] = _loc2_ - 0.5 >> 0;
               }
            }
         }
         else
         {
            while(true)
            {
               _loc4_--;
               if(!_loc4_)
               {
                  break;
               }
               _loc3_ = _info[_loc4_];
               _a[_loc3_.index] = _loc3_.start + _loc3_.change * param1;
            }
         }
      }
   }
}

class ArrayTweenInfo
{
    
   
   public var index:uint;
   
   public var start:Number;
   
   public var change:Number;
   
   function ArrayTweenInfo(param1:uint, param2:Number, param3:Number)
   {
      super();
      this.index = param1;
      this.start = param2;
      this.change = param3;
   }
}
