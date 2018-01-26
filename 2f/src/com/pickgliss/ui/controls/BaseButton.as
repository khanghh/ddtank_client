package com.pickgliss.ui.controls
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   [Event(name="change",type="flash.events.Event")]
   public class BaseButton extends Component
   {
      
      public static const P_backStyle:String = "backStyle";
      
      public static const P_backgoundRotation:String = "backgoundRotation";
      
      public static const P_pressEnable:String = "pressEnable";
      
      public static const P_transparentEnable:String = "transparentEnable";
      
      public static const P_autoSizeAble:String = "autoSizeAble";
      
      public static const P_stopMovieAtLastFrame:String = "stopMovieAtLastFrame";
       
      
      private var _offsetCount:int;
      
      protected var _PNGHitArea:Sprite;
      
      protected var _back:DisplayObject;
      
      protected var _backStyle:String;
      
      protected var _backgoundRotation:int;
      
      protected var _currentFrameIndex:int = 1;
      
      protected var _enable:Boolean = true;
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      protected var _pressEnable:Boolean;
      
      protected var _stopMovieAtLastFrame:Boolean;
      
      private var _displacementEnable:Boolean = true;
      
      private var _pressStartTimer:Timer;
      
      private var _pressStepTimer:Timer;
      
      protected var _transparentEnable:Boolean;
      
      protected var _autoSizeAble:Boolean = true;
      
      private var _useLogID:int = 0;
      
      private var _focusFrameStyle:String;
      
      public var _focusFrame:Bitmap;
      
      private var _autoFrame:Boolean = true;
      
      public function BaseButton(){super();}
      
      public function get autoFrame() : Boolean{return false;}
      
      public function set autoFrame(param1:Boolean) : void{}
      
      public function get focusFrameStyle() : String{return null;}
      
      public function set focusFrameStyle(param1:String) : void{}
      
      public function set useLogID(param1:int) : void{}
      
      public function get useLogID() : int{return 0;}
      
      public function get frameFilter() : Array{return null;}
      
      public function set frameFilter(param1:Array) : void{}
      
      public function set autoSizeAble(param1:Boolean) : void{}
      
      public function get backStyle() : String{return null;}
      
      public function set backStyle(param1:String) : void{}
      
      public function set backgound(param1:DisplayObject) : void{}
      
      public function get backgound() : DisplayObject{return null;}
      
      public function set backgoundRotation(param1:int) : void{}
      
      public function get displacement() : Boolean{return false;}
      
      public function set displacement(param1:Boolean) : void{}
      
      override public function dispose() : void{}
      
      public function get enable() : Boolean{return false;}
      
      public function set enable(param1:Boolean) : void{}
      
      private function updatePosition() : void{}
      
      public function set filterString(param1:String) : void{}
      
      public function set pressEnable(param1:Boolean) : void{}
      
      public function get transparentEnable() : Boolean{return false;}
      
      public function set transparentEnable(param1:Boolean) : void{}
      
      protected function __onMouseClick(param1:MouseEvent) : void{}
      
      protected function adaptHitArea() : void{}
      
      override protected function addChildren() : void{}
      
      protected function addEvent() : void{}
      
      public function set stopMovieAtLastFrame(param1:Boolean) : void{}
      
      public function get stopMovieAtLastFrame() : Boolean{return false;}
      
      protected function drawHitArea() : void{}
      
      override protected function init() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function removeEvent() : void{}
      
      public function setFrame(param1:int) : void{}
      
      protected function __onMouseRollout(param1:MouseEvent) : void{}
      
      protected function __onMouseRollover(param1:MouseEvent) : void{}
      
      private function __onMousedown(param1:MouseEvent) : void{}
      
      private function __onMouseup(param1:MouseEvent) : void{}
      
      private function __onPressStepTimer(param1:TimerEvent) : void{}
      
      private function __onPressedStart(param1:TimerEvent) : void{}
   }
}
