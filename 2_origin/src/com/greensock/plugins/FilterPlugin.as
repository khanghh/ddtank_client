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
      
      protected function initFilter(props:Object, defaultFilter:BitmapFilter, propNames:Array) : void
      {
         var p:* = null;
         var i:int = 0;
         var colorTween:* = null;
         var filters:Array = _target.filters;
         var extras:Object = props is BitmapFilter?{}:props;
         _index = -1;
         if(extras.index != null)
         {
            _index = extras.index;
         }
         else
         {
            i = filters.length;
            while(true)
            {
               i--;
               if(i)
               {
                  if(filters[i] is _type)
                  {
                     _index = i;
                     break;
                  }
                  continue;
               }
               break;
            }
         }
         if(_index == -1 || filters[_index] == null || extras.addFilter == true)
         {
            _index = extras.index != null?extras.index:filters.length;
            filters[_index] = defaultFilter;
            _target.filters = filters;
         }
         _filter = filters[_index];
         if(extras.remove == true)
         {
            _remove = true;
            this.onComplete = onCompleteTween;
         }
         i = propNames.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            p = propNames[i];
            if(p in props && _filter[p] != props[p])
            {
               if(p == "color" || p == "highlightColor" || p == "shadowColor")
               {
                  colorTween = new HexColorsPlugin();
                  colorTween.initColor(_filter,p,_filter[p],props[p]);
                  _tweens[_tweens.length] = new PropTween(colorTween,"changeFactor",0,1,p,false);
               }
               else if(p == "quality" || p == "inner" || p == "knockout" || p == "hideObject")
               {
                  _filter[p] = props[p];
               }
               else
               {
                  addTween(_filter,p,_filter[p],props[p],p);
               }
            }
         }
      }
      
      public function onCompleteTween() : void
      {
         var filters:* = null;
         var i:int = 0;
         if(_remove)
         {
            filters = _target.filters;
            if(!(filters[_index] is _type))
            {
               i = filters.length;
               while(true)
               {
                  i--;
                  if(i)
                  {
                     if(filters[i] is _type)
                     {
                        filters.splice(i,1);
                        break;
                     }
                     continue;
                  }
                  break;
               }
            }
            else
            {
               filters.splice(_index,1);
            }
            _target.filters = filters;
         }
      }
      
      override public function set changeFactor(n:Number) : void
      {
         var ti:* = null;
         var i:int = _tweens.length;
         var filters:Array = _target.filters;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            ti = _tweens[i];
            ti.target[ti.property] = ti.start + ti.change * n;
         }
         if(!(filters[_index] is _type))
         {
            _index = filters.length;
            i = filters.length;
            while(true)
            {
               i--;
               if(i)
               {
                  if(filters[i] is _type)
                  {
                     _index = i;
                     break;
                  }
                  continue;
               }
               break;
            }
         }
         filters[_index] = _filter;
         _target.filters = filters;
      }
   }
}
