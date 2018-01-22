package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   
   public class RoundPropsPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _tween:TweenLite;
      
      public function RoundPropsPlugin()
      {
         super();
         this.propName = "roundProps";
         this.overwriteProps = ["roundProps"];
         this.round = true;
         this.priority = -1;
         this.onInitAllProps = _initAllProps;
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         _tween = param3;
         this.overwriteProps = this.overwriteProps.concat(param2 as Array);
         return true;
      }
      
      protected function _initAllProps() : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:Array = _tween.vars.roundProps;
         var _loc4_:int = _loc1_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= -1)
            {
               break;
            }
            _loc2_ = _loc1_[_loc4_];
            _loc3_ = _tween.cachedPT1;
            while(_loc3_)
            {
               if(_loc3_.name == _loc2_)
               {
                  if(_loc3_.isPlugin)
                  {
                     _loc3_.target.round = true;
                  }
                  else
                  {
                     add(_loc3_.target,_loc2_,_loc3_.start,_loc3_.change);
                     _removePropTween(_loc3_);
                     _tween.propTweenLookup[_loc2_] = _tween.propTweenLookup.roundProps;
                  }
               }
               else if(_loc3_.isPlugin && _loc3_.name == "_MULTIPLE_" && !_loc3_.target.round)
               {
                  _loc5_ = " " + _loc3_.target.overwriteProps.join(" ") + " ";
                  if(_loc5_.indexOf(" " + _loc2_ + " ") != -1)
                  {
                     _loc3_.target.round = true;
                  }
               }
               _loc3_ = _loc3_.nextNode;
            }
         }
      }
      
      protected function _removePropTween(param1:PropTween) : void
      {
         if(param1.nextNode)
         {
            param1.nextNode.prevNode = param1.prevNode;
         }
         if(param1.prevNode)
         {
            param1.prevNode.nextNode = param1.nextNode;
         }
         else if(_tween.cachedPT1 == param1)
         {
            _tween.cachedPT1 = param1.nextNode;
         }
         if(param1.isPlugin && param1.target.onDisable)
         {
            param1.target.onDisable();
         }
      }
      
      public function add(param1:Object, param2:String, param3:Number, param4:Number) : void
      {
         addTween(param1,param2,param3,param3 + param4,param2);
         this.overwriteProps[this.overwriteProps.length] = param2;
      }
   }
}
