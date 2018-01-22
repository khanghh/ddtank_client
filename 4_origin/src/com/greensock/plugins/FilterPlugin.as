package com.greensock.plugins
{
   import com.greensock.core.PropTween;
   import flash.filters.BitmapFilter;
   
   public class FilterPlugin extends TweenPlugin
   {
      
      public static const VERSION:Number = 2.03;
      
      public static const API:Number = 1.0;
       
      
      protected var _target:Object;
      
      protected var _type:Class;
      
      protected var _filter:BitmapFilter;
      
      protected var _index:int;
      
      protected var _remove:Boolean;
      
      public function FilterPlugin()
      {
         super();
      }
      
      protected function initFilter(param1:Object, param2:BitmapFilter, param3:Array) : void
      {
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc6_:Array = _target.filters;
         var _loc7_:Object = param1 is BitmapFilter?{}:param1;
         _index = -1;
         if(_loc7_.index != null)
         {
            _index = _loc7_.index;
         }
         else
         {
            _loc8_ = _loc6_.length;
            while(true)
            {
               _loc8_--;
               if(_loc8_)
               {
                  if(_loc6_[_loc8_] is _type)
                  {
                     _index = _loc8_;
                     break;
                  }
                  continue;
               }
               break;
            }
         }
         if(_index == -1 || _loc6_[_index] == null || _loc7_.addFilter == true)
         {
            _index = _loc7_.index != null?_loc7_.index:_loc6_.length;
            _loc6_[_index] = param2;
            _target.filters = _loc6_;
         }
         _filter = _loc6_[_index];
         if(_loc7_.remove == true)
         {
            _remove = true;
            this.onComplete = onCompleteTween;
         }
         _loc8_ = param3.length;
         while(true)
         {
            _loc8_--;
            if(!_loc8_)
            {
               break;
            }
            _loc5_ = param3[_loc8_];
            if(_loc5_ in param1 && _filter[_loc5_] != param1[_loc5_])
            {
               if(_loc5_ == "color" || _loc5_ == "highlightColor" || _loc5_ == "shadowColor")
               {
                  _loc4_ = new HexColorsPlugin();
                  _loc4_.initColor(_filter,_loc5_,_filter[_loc5_],param1[_loc5_]);
                  _tweens[_tweens.length] = new PropTween(_loc4_,"changeFactor",0,1,_loc5_,false);
               }
               else if(_loc5_ == "quality" || _loc5_ == "inner" || _loc5_ == "knockout" || _loc5_ == "hideObject")
               {
                  _filter[_loc5_] = param1[_loc5_];
               }
               else
               {
                  addTween(_filter,_loc5_,_filter[_loc5_],param1[_loc5_],_loc5_);
               }
            }
         }
      }
      
      public function onCompleteTween() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(_remove)
         {
            _loc1_ = _target.filters;
            if(!(_loc1_[_index] is _type))
            {
               _loc2_ = _loc1_.length;
               while(true)
               {
                  _loc2_--;
                  if(_loc2_)
                  {
                     if(_loc1_[_loc2_] is _type)
                     {
                        _loc1_.splice(_loc2_,1);
                        break;
                     }
                     continue;
                  }
                  break;
               }
            }
            else
            {
               _loc1_.splice(_index,1);
            }
            _target.filters = _loc1_;
         }
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = _tweens.length;
         var _loc2_:Array = _target.filters;
         while(true)
         {
            _loc4_--;
            if(!_loc4_)
            {
               break;
            }
            _loc3_ = _tweens[_loc4_];
            _loc3_.target[_loc3_.property] = _loc3_.start + _loc3_.change * param1;
         }
         if(!(_loc2_[_index] is _type))
         {
            _index = _loc2_.length;
            _loc4_ = _loc2_.length;
            while(true)
            {
               _loc4_--;
               if(_loc4_)
               {
                  if(_loc2_[_loc4_] is _type)
                  {
                     _index = _loc4_;
                     break;
                  }
                  continue;
               }
               break;
            }
         }
         _loc2_[_index] = _filter;
         _target.filters = _loc2_;
      }
   }
}
