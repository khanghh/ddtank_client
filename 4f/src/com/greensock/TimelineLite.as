package com.greensock
{
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.TweenCore;
   
   public class TimelineLite extends SimpleTimeline
   {
      
      public static const version:Number = 1.64;
      
      private static var _overwriteMode:int = !!OverwriteManager.enabled?OverwriteManager.mode:int(OverwriteManager.init(2));
       
      
      protected var _labels:Object;
      
      protected var _endCaps:Array;
      
      public function TimelineLite(param1:Object = null){super(null);}
      
      override public function remove(param1:TweenCore, param2:Boolean = false) : void{}
      
      override public function insert(param1:TweenCore, param2:* = 0) : TweenCore{return null;}
      
      public function append(param1:TweenCore, param2:Number = 0) : TweenCore{return null;}
      
      public function prepend(param1:TweenCore, param2:Boolean = false) : TweenCore{return null;}
      
      public function insertMultiple(param1:Array, param2:* = 0, param3:String = "normal", param4:Number = 0) : Array{return null;}
      
      public function appendMultiple(param1:Array, param2:Number = 0, param3:String = "normal", param4:Number = 0) : Array{return null;}
      
      public function prependMultiple(param1:Array, param2:String = "normal", param3:Number = 0, param4:Boolean = false) : Array{return null;}
      
      public function addLabel(param1:String, param2:Number) : void{}
      
      public function removeLabel(param1:String) : Number{return 0;}
      
      public function getLabelTime(param1:String) : Number{return 0;}
      
      protected function parseTimeOrLabel(param1:*) : Number{return 0;}
      
      public function stop() : void{}
      
      public function gotoAndPlay(param1:*, param2:Boolean = true) : void{}
      
      public function gotoAndStop(param1:*, param2:Boolean = true) : void{}
      
      public function goto_(param1:*, param2:Boolean = true) : void{}
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void{}
      
      protected function forceChildrenToBeginning(param1:Number, param2:Boolean = false) : Number{return 0;}
      
      protected function forceChildrenToEnd(param1:Number, param2:Boolean = false) : Number{return 0;}
      
      public function hasPausedChild() : Boolean{return false;}
      
      public function getChildren(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true, param4:Number = -9.999999999E9) : Array{return null;}
      
      public function getTweensOf(param1:Object, param2:Boolean = true) : Array{return null;}
      
      public function shiftChildren(param1:Number, param2:Boolean = false, param3:Number = 0) : void{}
      
      public function killTweensOf(param1:Object, param2:Boolean = true, param3:Object = null) : Boolean{return false;}
      
      override public function invalidate() : void{}
      
      public function clear(param1:Array = null) : void{}
      
      override public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean{return false;}
      
      public function get currentProgress() : Number{return 0;}
      
      public function set currentProgress(param1:Number) : void{}
      
      override public function get duration() : Number{return 0;}
      
      override public function set duration(param1:Number) : void{}
      
      override public function get totalDuration() : Number{return 0;}
      
      override public function set totalDuration(param1:Number) : void{}
      
      public function get timeScale() : Number{return 0;}
      
      public function set timeScale(param1:Number) : void{}
      
      public function get useFrames() : Boolean{return false;}
      
      override public function get rawTime() : Number{return 0;}
   }
}
