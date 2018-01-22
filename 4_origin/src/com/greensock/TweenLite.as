package com.greensock
{
   import com.greensock.core.PropTween;
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.TweenCore;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class TweenLite extends TweenCore
   {
      
      public static const version:Number = 11.62;
      
      public static var plugins:Object = {};
      
      public static var fastEaseLookup:Dictionary = new Dictionary(false);
      
      public static var onPluginEvent:Function;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      public static var defaultEase:Function = TweenLite.easeOut;
      
      public static var overwriteManager:Object;
      
      public static var rootFrame:Number;
      
      public static var rootTimeline:SimpleTimeline;
      
      public static var rootFramesTimeline:SimpleTimeline;
      
      public static var masterList:Dictionary = new Dictionary(false);
      
      private static var _shape:Shape = new Shape();
      
      protected static var _reservedProps:Object = {
         "ease":1,
         "delay":1,
         "overwrite":1,
         "onComplete":1,
         "onCompleteParams":1,
         "useFrames":1,
         "runBackwards":1,
         "startAt":1,
         "onUpdate":1,
         "onUpdateParams":1,
         "onStart":1,
         "onStartParams":1,
         "onInit":1,
         "onInitParams":1,
         "onReverseComplete":1,
         "onReverseCompleteParams":1,
         "onRepeat":1,
         "onRepeatParams":1,
         "proxiedEase":1,
         "easeParams":1,
         "yoyo":1,
         "onCompleteListener":1,
         "onUpdateListener":1,
         "onStartListener":1,
         "onReverseCompleteListener":1,
         "onRepeatListener":1,
         "orientToBezier":1,
         "timeScale":1,
         "immediateRender":1,
         "repeat":1,
         "repeatDelay":1,
         "timeline":1,
         "data":1,
         "paused":1
      };
       
      
      public var target:Object;
      
      public var propTweenLookup:Object;
      
      public var ratio:Number = 0;
      
      public var cachedPT1:PropTween;
      
      protected var _ease:Function;
      
      protected var _overwrite:int;
      
      protected var _overwrittenProps:Object;
      
      protected var _hasPlugins:Boolean;
      
      protected var _notifyPluginsOfEnabled:Boolean;
      
      public function TweenLite(param1:Object, param2:Number, param3:Object)
      {
         super(param2,param3);
         if(param1 == null)
         {
            throw new Error("Cannot tween a null object.");
         }
         this.target = param1;
         if(this.target is TweenCore && this.vars.timeScale)
         {
            this.cachedTimeScale = 1;
         }
         propTweenLookup = {};
         _ease = defaultEase;
         _overwrite = Number(param3.overwrite) <= -1 || !overwriteManager.enabled && param3.overwrite > 1?overwriteManager.mode:int(param3.overwrite);
         var _loc5_:Array = masterList[param1];
         if(!_loc5_)
         {
            masterList[param1] = [this];
         }
         else if(_overwrite == 1)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _loc5_;
            for each(var _loc4_ in _loc5_)
            {
               if(!_loc4_.gc)
               {
                  _loc4_.setEnabled(false,false);
               }
            }
            masterList[param1] = [this];
         }
         else
         {
            _loc5_[_loc5_.length] = this;
         }
         if(this.active || this.vars.immediateRender)
         {
            renderTime(0,false,true);
         }
      }
      
      public static function initClass() : void
      {
         rootFrame = 0;
         rootTimeline = new SimpleTimeline(null);
         rootFramesTimeline = new SimpleTimeline(null);
         rootTimeline.cachedStartTime = getTimer() * 0.001;
         rootFramesTimeline.cachedStartTime = rootFrame;
         rootTimeline.autoRemoveChildren = true;
         rootFramesTimeline.autoRemoveChildren = true;
         _shape.addEventListener("enterFrame",updateAll,false,0,true);
         if(overwriteManager == null)
         {
            overwriteManager = {
               "mode":1,
               "enabled":false
            };
         }
      }
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenLite
      {
         return new TweenLite(param1,param2,param3);
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenLite
      {
         param3.runBackwards = true;
         if(!("immediateRender" in param3))
         {
            param3.immediateRender = true;
         }
         return new TweenLite(param1,param2,param3);
      }
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenLite
      {
         return new TweenLite(param2,0,{
            "delay":param1,
            "onComplete":param2,
            "onCompleteParams":param3,
            "immediateRender":false,
            "useFrames":param4,
            "overwrite":0
         });
      }
      
      protected static function updateAll(param1:Event = null) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         rootTimeline.renderTime((getTimer() * 0.001 - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale,false,false);
         rootFrame = rootFrame + 1;
         rootFramesTimeline.renderTime((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale,false,false);
         if(!(rootFrame % 60))
         {
            _loc4_ = masterList;
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for(_loc3_ in _loc4_)
            {
               _loc2_ = _loc4_[_loc3_];
               _loc5_ = _loc2_.length;
               while(true)
               {
                  _loc5_--;
                  if(_loc5_ <= -1)
                  {
                     break;
                  }
                  if(TweenLite(_loc2_[_loc5_]).gc)
                  {
                     _loc2_.splice(_loc5_,1);
                  }
               }
               if(_loc2_.length == 0)
               {
                  delete _loc4_[_loc3_];
               }
            }
         }
      }
      
      public static function killTweensOf(param1:Object, param2:Boolean = false, param3:Object = null) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         if(param1 in masterList)
         {
            _loc5_ = masterList[param1];
            _loc6_ = _loc5_.length;
            while(true)
            {
               _loc6_--;
               if(_loc6_ <= -1)
               {
                  break;
               }
               _loc4_ = _loc5_[_loc6_];
               if(!_loc4_.gc)
               {
                  if(param2)
                  {
                     _loc4_.complete(false,false);
                  }
                  if(param3 != null)
                  {
                     _loc4_.killVars(param3);
                  }
                  if(param3 == null || _loc4_.cachedPT1 == null && _loc4_.initted)
                  {
                     _loc4_.setEnabled(false,false);
                  }
               }
            }
            if(param3 == null)
            {
               delete masterList[param1];
            }
         }
      }
      
      protected static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         param1 = 1 - param1 / param4;
         return 1 - (1 - param1 / param4) * param1;
      }
      
      protected function init() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = undefined;
         var _loc1_:Boolean = false;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(this.vars.onInit)
         {
            this.vars.onInit.apply(null,this.vars.onInitParams);
         }
         if(typeof this.vars.ease == "function")
         {
            _ease = this.vars.ease;
         }
         if(this.vars.easeParams)
         {
            this.vars.proxiedEase = _ease;
            _ease = easeProxy;
         }
         this.cachedPT1 = null;
         this.propTweenLookup = {};
         var _loc8_:int = 0;
         var _loc7_:* = this.vars;
         for(_loc2_ in this.vars)
         {
            if(!(_loc2_ in _reservedProps && !(_loc2_ == "timeScale" && this.target is TweenCore)))
            {
               if(_loc2_ in plugins && _loc5_.onInitTween(this.target,this.vars[_loc2_],this))
               {
                  this.cachedPT1 = new PropTween(_loc5_,"changeFactor",0,1,_loc5_.overwriteProps.length == 1?_loc5_.overwriteProps[0]:"_MULTIPLE_",true,this.cachedPT1);
                  if(this.cachedPT1.name == "_MULTIPLE_")
                  {
                     _loc6_ = _loc5_.overwriteProps.length;
                     while(true)
                     {
                        _loc6_--;
                        if(_loc6_ <= -1)
                        {
                           break;
                        }
                        this.propTweenLookup[_loc5_.overwriteProps[_loc6_]] = this.cachedPT1;
                     }
                  }
                  else
                  {
                     this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
                  }
                  if(_loc5_.priority)
                  {
                     this.cachedPT1.priority = _loc5_.priority;
                     _loc1_ = true;
                  }
                  if(_loc5_.onDisable || _loc5_.onEnable)
                  {
                     _notifyPluginsOfEnabled = true;
                  }
                  _hasPlugins = true;
               }
               else
               {
                  this.cachedPT1 = new PropTween(this.target,_loc2_,Number(this.target[_loc2_]),typeof this.vars[_loc2_] == "number"?this.vars[_loc2_] - this.target[_loc2_]:Number(this.vars[_loc2_]),_loc2_,false,this.cachedPT1);
                  this.propTweenLookup[_loc2_] = this.cachedPT1;
               }
            }
         }
         if(_loc1_)
         {
            onPluginEvent("onInitAllProps",this);
         }
         if(this.vars.runBackwards)
         {
            _loc3_ = this.cachedPT1;
            while(_loc3_)
            {
               _loc3_.start = _loc3_.start + _loc3_.change;
               _loc3_.change = -_loc3_.change;
               _loc3_ = _loc3_.nextNode;
            }
         }
         _hasUpdate = this.vars.onUpdate != null;
         if(_overwrittenProps)
         {
            killVars(_overwrittenProps);
            if(this.cachedPT1 == null)
            {
               this.setEnabled(false,false);
            }
         }
         if(_overwrite > 1 && this.cachedPT1 && Boolean(masterList[this.target]) && _loc4_.length > 1)
         {
            if(overwriteManager.manageOverwrites(this,this.propTweenLookup,_loc4_,_overwrite))
            {
               init();
            }
         }
         this.initted = true;
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:Boolean = false;
         var _loc6_:Number = this.cachedTime;
         if(param1 >= this.cachedDuration)
         {
            var _loc7_:* = this.cachedDuration;
            this.cachedTime = _loc7_;
            this.cachedTotalTime = _loc7_;
            this.ratio = 1;
            _loc4_ = true;
            if(this.cachedDuration == 0)
            {
               if((param1 == 0 || _rawPrevTime < 0) && _rawPrevTime != param1)
               {
                  param3 = true;
               }
               _rawPrevTime = param1;
            }
         }
         else if(param1 <= 0)
         {
            _loc7_ = 0;
            this.ratio = _loc7_;
            _loc7_ = _loc7_;
            this.cachedTime = _loc7_;
            this.cachedTotalTime = _loc7_;
            if(param1 < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0)
               {
                  if(_rawPrevTime >= 0)
                  {
                     param3 = true;
                     _loc4_ = true;
                  }
                  _rawPrevTime = param1;
               }
            }
            if(this.cachedReversed && _loc6_ != 0)
            {
               _loc4_ = true;
            }
         }
         else
         {
            _loc7_ = param1;
            this.cachedTime = _loc7_;
            this.cachedTotalTime = _loc7_;
            this.ratio = _ease(param1,0,1,this.cachedDuration);
         }
         if(this.cachedTime == _loc6_ && !param3)
         {
            return;
         }
         if(!this.initted)
         {
            init();
            if(!_loc4_ && this.cachedTime)
            {
               this.ratio = _ease(this.cachedTime,0,1,this.cachedDuration);
            }
         }
         if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         if(_loc6_ == 0 && this.vars.onStart && (this.cachedTime != 0 || this.cachedDuration == 0) && !param2)
         {
            this.vars.onStart.apply(null,this.vars.onStartParams);
         }
         var _loc5_:PropTween = this.cachedPT1;
         while(_loc5_)
         {
            _loc5_.target[_loc5_.property] = _loc5_.start + this.ratio * _loc5_.change;
            _loc5_ = _loc5_.nextNode;
         }
         if(_hasUpdate && !param2)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(_loc4_ && !this.gc)
         {
            if(_hasPlugins && this.cachedPT1)
            {
               onPluginEvent("onComplete",this);
            }
            complete(true,param2);
         }
      }
      
      public function killVars(param1:Object, param2:Boolean = true) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         var _loc3_:* = null;
         if(_overwrittenProps == null)
         {
            _overwrittenProps = {};
         }
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for(_loc3_ in param1)
         {
            if(_loc3_ in propTweenLookup)
            {
               _loc4_ = propTweenLookup[_loc3_];
               if(_loc4_.isPlugin && _loc4_.name == "_MULTIPLE_")
               {
                  _loc4_.target.killProps(param1);
                  if(_loc4_.target.overwriteProps.length == 0)
                  {
                     _loc4_.name = "";
                  }
                  if(_loc3_ != _loc4_.target.propName || _loc4_.name == "")
                  {
                     delete propTweenLookup[_loc3_];
                  }
               }
               if(_loc4_.name != "_MULTIPLE_")
               {
                  if(_loc4_.nextNode)
                  {
                     _loc4_.nextNode.prevNode = _loc4_.prevNode;
                  }
                  if(_loc4_.prevNode)
                  {
                     _loc4_.prevNode.nextNode = _loc4_.nextNode;
                  }
                  else if(this.cachedPT1 == _loc4_)
                  {
                     this.cachedPT1 = _loc4_.nextNode;
                  }
                  if(_loc4_.isPlugin && _loc4_.target.onDisable)
                  {
                     _loc4_.target.onDisable();
                     if(_loc4_.target.activeDisable)
                     {
                        _loc5_ = true;
                     }
                  }
                  delete propTweenLookup[_loc3_];
               }
            }
            if(param2 && param1 != _overwrittenProps)
            {
               _overwrittenProps[_loc3_] = 1;
            }
         }
         return _loc5_;
      }
      
      override public function invalidate() : void
      {
         if(_notifyPluginsOfEnabled && this.cachedPT1)
         {
            onPluginEvent("onDisable",this);
         }
         this.cachedPT1 = null;
         _overwrittenProps = null;
         _notifyPluginsOfEnabled = false;
         var _loc1_:* = false;
         this.active = _loc1_;
         _loc1_ = _loc1_;
         this.initted = _loc1_;
         _hasUpdate = _loc1_;
         this.propTweenLookup = {};
      }
      
      override public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean
      {
         var _loc3_:* = null;
         if(param1)
         {
            _loc3_ = TweenLite.masterList[this.target];
            if(!_loc3_)
            {
               TweenLite.masterList[this.target] = [this];
            }
            else
            {
               _loc3_[_loc3_.length] = this;
            }
         }
         super.setEnabled(param1,param2);
         if(_notifyPluginsOfEnabled && this.cachedPT1)
         {
            return onPluginEvent(!!param1?"onEnable":"onDisable",this);
         }
         return false;
      }
      
      protected function easeProxy(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return this.vars.proxiedEase.apply(null,arguments.concat(this.vars.easeParams));
      }
   }
}
