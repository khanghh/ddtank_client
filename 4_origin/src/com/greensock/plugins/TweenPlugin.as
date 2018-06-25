package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   
   public class TweenPlugin
   {
      
      public static const VERSION:Number = 1.4;
      
      public static const API:Number = 1.0;
       
      
      public var propName:String;
      
      public var overwriteProps:Array;
      
      public var round:Boolean;
      
      public var priority:int = 0;
      
      public var activeDisable:Boolean;
      
      public var onInitAllProps:Function;
      
      public var onComplete:Function;
      
      public var onEnable:Function;
      
      public var onDisable:Function;
      
      protected var _tweens:Array;
      
      protected var _changeFactor:Number = 0;
      
      public function TweenPlugin()
      {
         _tweens = [];
         super();
      }
      
      private static function onTweenEvent(type:String, tween:TweenLite) : Boolean
      {
         var changed:Boolean = false;
         var tweens:* = null;
         var i:int = 0;
         var pt:* = tween.cachedPT1;
         if(type == "onInitAllProps")
         {
            tweens = [];
            i = 0;
            while(pt)
            {
               i++;
               tweens[i] = pt;
               pt = pt.nextNode;
            }
            tweens.sortOn("priority",16 | 2);
            while(true)
            {
               i--;
               if(i <= -1)
               {
                  break;
               }
               PropTween(tweens[i]).nextNode = tweens[i + 1];
               PropTween(tweens[i]).prevNode = tweens[i - 1];
            }
            var _loc7_:* = tweens[0];
            tween.cachedPT1 = _loc7_;
            pt = _loc7_;
         }
         while(pt)
         {
            if(pt.isPlugin && pt.target[type])
            {
               if(pt.target.activeDisable)
               {
                  changed = true;
               }
               pt.target[type]();
            }
            pt = pt.nextNode;
         }
         return changed;
      }
      
      public static function activate(plugins:Array) : Boolean
      {
         var instance:* = null;
         TweenLite.onPluginEvent = TweenPlugin.onTweenEvent;
         var i:int = plugins.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(plugins[i].hasOwnProperty("API"))
            {
               instance = new (plugins[i] as Class)();
               TweenLite.plugins[instance.propName] = plugins[i];
            }
         }
         return true;
      }
      
      public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         addTween(target,this.propName,target[this.propName],value,this.propName);
         return true;
      }
      
      protected function addTween(object:Object, propName:String, start:Number, end:*, overwriteProp:String = null) : void
      {
         var change:Number = NaN;
         if(end != null)
         {
            change = typeof end == "number"?end - start:Number(end);
            if(change != 0)
            {
               _tweens[_tweens.length] = new PropTween(object,propName,start,change,overwriteProp || propName,false);
            }
         }
      }
      
      protected function updateTweens(changeFactor:Number) : void
      {
         var pt:* = null;
         var val:Number = NaN;
         var i:int = _tweens.length;
         if(this.round)
         {
            while(true)
            {
               i--;
               if(i <= -1)
               {
                  break;
               }
               pt = _tweens[i];
               val = pt.start + pt.change * changeFactor;
               if(val > 0)
               {
                  pt.target[pt.property] = val + 0.5 >> 0;
               }
               else
               {
                  pt.target[pt.property] = val - 0.5 >> 0;
               }
            }
         }
         else
         {
            while(true)
            {
               i--;
               if(i <= -1)
               {
                  break;
               }
               pt = _tweens[i];
               pt.target[pt.property] = pt.start + pt.change * changeFactor;
            }
         }
      }
      
      public function get changeFactor() : Number
      {
         return _changeFactor;
      }
      
      public function set changeFactor(n:Number) : void
      {
         updateTweens(n);
         _changeFactor = n;
      }
      
      public function killProps(lookup:Object) : void
      {
         var i:int = this.overwriteProps.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            if(this.overwriteProps[i] in lookup)
            {
               this.overwriteProps.splice(i,1);
            }
         }
         i = _tweens.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            if(PropTween(_tweens[i]).name in lookup)
            {
               _tweens.splice(i,1);
            }
         }
      }
   }
}
