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
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         if(!(target is Array) || !(value is Array))
         {
            return false;
         }
         init(target as Array,value);
         return true;
      }
      
      public function init(start:Array, end:Array) : void
      {
         _a = start;
         var i:int = end.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(start[i] != end[i] && start[i] != null)
            {
               _info[_info.length] = new ArrayTweenInfo(i,_a[i],end[i] - _a[i]);
            }
         }
      }
      
      override public function set changeFactor(n:Number) : void
      {
         var ti:* = null;
         var val:Number = NaN;
         var i:int = _info.length;
         if(this.round)
         {
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               ti = _info[i];
               val = ti.start + ti.change * n;
               if(val > 0)
               {
                  _a[ti.index] = val + 0.5 >> 0;
               }
               else
               {
                  _a[ti.index] = val - 0.5 >> 0;
               }
            }
         }
         else
         {
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               ti = _info[i];
               _a[ti.index] = ti.start + ti.change * n;
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
   
   function ArrayTweenInfo(index:uint, start:Number, change:Number)
   {
      super();
      this.index = index;
      this.start = start;
      this.change = change;
   }
}
