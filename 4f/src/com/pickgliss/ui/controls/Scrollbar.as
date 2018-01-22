package com.pickgliss.ui.controls
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IOrientable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class Scrollbar extends Component implements IOrientable
   {
      
      public static const HORIZONTAL:int = 1;
      
      public static const P_decreaseButton:String = "decreaseButton";
      
      public static const P_decreaseButtonInnerRect:String = "decreaseButtonInnerRect";
      
      public static const P_increaseButton:String = "increaseButton";
      
      public static const P_increaseButtonInnerRect:String = "increaseButtonInnerRect";
      
      public static const P_maximum:String = "maximum";
      
      public static const P_minimum:String = "minimum";
      
      public static const P_orientation:String = "orientation";
      
      public static const P_scrollValue:String = "scrollValue";
      
      public static const P_thumb:String = "thumb";
      
      public static const P_thumbAreaInnerRect:String = "thumbAreaInnerRect";
      
      public static const P_thumbMinSize:String = "thumbMinSize";
      
      public static const P_track:String = "track";
      
      public static const P_trackInnerRect:String = "trackInnerRect";
      
      public static const P_valueIsAdjusting:String = "valueIsAdjusting";
      
      public static const P_visibleAmount:String = "visibleAmount";
      
      public static const VERTICAL:int = 0;
       
      
      protected var _blockIncrement:int = 20;
      
      protected var _currentTrackClickDirction:int = 0;
      
      protected var _decreaseButton:BaseButton;
      
      protected var _decreaseButtonInnerRect:InnerRectangle;
      
      protected var _decreaseButtonInnerRectString:String;
      
      protected var _decreaseButtonStyle:String;
      
      protected var _increaseButton:BaseButton;
      
      protected var _increaseButtonInnerRect:InnerRectangle;
      
      protected var _increaseButtonInnerRectString:String;
      
      protected var _increaseButtonStyle:String;
      
      protected var _isDragging:Boolean;
      
      protected var _model:BoundedRangeModel;
      
      protected var _orientation:int;
      
      protected var _thumb:BaseButton;
      
      protected var _thumbAreaInnerRect:InnerRectangle;
      
      protected var _thumbAreaInnerRectString:String;
      
      protected var _thumbDownOffset:int;
      
      protected var _thumbMinSize:int;
      
      protected var _thumbRect:Rectangle;
      
      protected var _thumbStyle:String;
      
      protected var _track:DisplayObject;
      
      protected var _trackClickTimer:Timer;
      
      protected var _trackInnerRect:InnerRectangle;
      
      protected var _trackInnerRectString:String;
      
      protected var _trackStyle:String;
      
      protected var _unitIncrement:int = 2;
      
      public function Scrollbar(){super();}
      
      public function addStateListener(param1:Function, param2:int = 0, param3:Boolean = false) : void{}
      
      public function get blockIncrement() : int{return 0;}
      
      public function set blockIncrement(param1:int) : void{}
      
      public function set decreaseButton(param1:BaseButton) : void{}
      
      public function set decreaseButtonInnerRectString(param1:String) : void{}
      
      public function set decreaseButtonStyle(param1:String) : void{}
      
      override public function dispose() : void{}
      
      public function set downButtonStyle(param1:String) : void{}
      
      public function getModel() : BoundedRangeModel{return null;}
      
      public function getThumbVisible() : Boolean{return false;}
      
      public function set increaseButton(param1:BaseButton) : void{}
      
      public function set increaseButtonInnerRectString(param1:String) : void{}
      
      public function set increaseButtonStyle(param1:String) : void{}
      
      public function isVertical() : Boolean{return false;}
      
      public function get maximum() : int{return 0;}
      
      public function set maximum(param1:int) : void{}
      
      public function get minimum() : int{return 0;}
      
      public function set minimum(param1:int) : void{}
      
      public function get orientation() : int{return 0;}
      
      public function set orientation(param1:int) : void{}
      
      public function removeStateListener(param1:Function) : void{}
      
      public function get scrollValue() : int{return 0;}
      
      public function set scrollValue(param1:int) : void{}
      
      public function setupModel(param1:BoundedRangeModel) : void{}
      
      public function set thumb(param1:BaseButton) : void{}
      
      public function set thumbAreaInnerRectString(param1:String) : void{}
      
      public function get thumbMinSize() : int{return 0;}
      
      public function set thumbMinSize(param1:int) : void{}
      
      public function set thumbStyle(param1:String) : void{}
      
      public function set track(param1:DisplayObject) : void{}
      
      public function set trackInnerRectString(param1:String) : void{}
      
      public function set trackStyle(param1:String) : void{}
      
      public function get unitIncrement() : int{return 0;}
      
      public function set unitIncrement(param1:int) : void{}
      
      public function get valueIsAdjusting() : Boolean{return false;}
      
      public function set valueIsAdjusting(param1:Boolean) : void{}
      
      public function get visibleAmount() : int{return 0;}
      
      public function set visibleAmount(param1:int) : void{}
      
      protected function __decreaseButtonClicked(param1:Event) : void{}
      
      protected function __increaseButtonClicked(param1:Event) : void{}
      
      protected function __onModelChange(param1:InteractiveEvent) : void{}
      
      protected function __onScrollValueChange(param1:InteractiveEvent) : void{}
      
      protected function __onThumbDown(param1:MouseEvent) : void{}
      
      protected function __onThumbMoved(param1:MouseEvent) : void{}
      
      protected function __onThumbUp(param1:MouseEvent) : void{}
      
      protected function __onTrackClickStart(param1:MouseEvent) : void{}
      
      protected function __onTrackClickStop(param1:MouseEvent) : void{}
      
      protected function __onTrackPressed(param1:TimerEvent) : void{}
      
      override protected function addChildren() : void{}
      
      protected function getValueWithPosition(param1:Point) : int{return 0;}
      
      override protected function init() : void{}
      
      protected function layoutComponent() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function scrollByIncrement(param1:int) : void{}
      
      protected function scrollThumbToCurrentMousePosition() : void{}
      
      protected function scrollToAimPoint(param1:Point) : void{}
      
      protected function setThumbPosAndSize(param1:int, param2:int, param3:int, param4:int) : void{}
      
      protected function updatePosByScrollvalue() : void{}
      
      private function getValueWithThumbMaxMinPos(param1:int, param2:int, param3:int) : int{return 0;}
   }
}
