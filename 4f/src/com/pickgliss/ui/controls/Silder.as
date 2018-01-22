package com.pickgliss.ui.controls
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IOrientable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Silder extends Component implements IOrientable
   {
      
      public static const P_bar:String = "bar";
      
      public static const P_maskShowAreaInnerRect:String = "maskShowAreaInnerRect";
      
      public static const P_maximum:String = "maximum";
      
      public static const P_minimum:String = "minimum";
      
      public static const P_orientation:String = "orientation";
      
      public static const P_progressBar:String = "progressBar";
      
      public static const P_thumb:String = "thumb";
      
      public static const P_thumbShowInnerRect:String = "thumbShowInnerRect";
      
      public static const P_value:String = "value";
       
      
      protected var _bar:DisplayObject;
      
      protected var _barStyle:String;
      
      protected var _isDragging:Boolean;
      
      protected var _maskShape:Shape;
      
      protected var _maskShowAreaInnerRect:InnerRectangle;
      
      protected var _maskShowAreaInnerRectString:String;
      
      protected var _model:BoundedRangeModel;
      
      protected var _orientation:int = -1;
      
      protected var _progressBar:DisplayObject;
      
      protected var _progressBarStyle:String;
      
      protected var _thumb:BaseButton;
      
      protected var _thumbDownOffset:int;
      
      protected var _thumbShowInnerRect:InnerRectangle;
      
      protected var _thumbShowInnerRectString:String;
      
      protected var _thumbStyle:String;
      
      protected var _value:Number;
      
      public function Silder(){super();}
      
      public function set bar(param1:DisplayObject) : void{}
      
      public function set barStyle(param1:String) : void{}
      
      override public function dispose() : void{}
      
      public function getModel() : BoundedRangeModel{return null;}
      
      public function isVertical() : Boolean{return false;}
      
      public function set maskShowAreaInnerRectString(param1:String) : void{}
      
      public function get maximum() : int{return 0;}
      
      public function set maximum(param1:int) : void{}
      
      public function get minimum() : int{return 0;}
      
      public function set minimum(param1:int) : void{}
      
      public function get orientation() : int{return 0;}
      
      public function set orientation(param1:int) : void{}
      
      public function set progressBar(param1:DisplayObject) : void{}
      
      public function set progressBarStyle(param1:String) : void{}
      
      public function removeStateListener(param1:Function) : void{}
      
      public function setupModel(param1:BoundedRangeModel) : void{}
      
      public function set thumb(param1:BaseButton) : void{}
      
      public function set thumbShowInnerRectString(param1:String) : void{}
      
      public function set thumbStyle(param1:String) : void{}
      
      public function get value() : Number{return 0;}
      
      public function set value(param1:Number) : void{}
      
      protected function __onModelChange(param1:InteractiveEvent) : void{}
      
      protected function __onSilderClick(param1:MouseEvent) : void{}
      
      protected function __onThumbMouseDown(param1:MouseEvent) : void{}
      
      protected function __onThumbMouseMoved(param1:MouseEvent) : void{}
      
      protected function __onThumbMouseUp(param1:MouseEvent) : void{}
      
      override protected function addChildren() : void{}
      
      override protected function init() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function scrollThumbToCurrentMousePosition() : void{}
      
      protected function setupMask() : void{}
      
      protected function updateMask() : void{}
      
      protected function updateSize() : void{}
      
      protected function updateThumbPos() : void{}
      
      private function calculateValuePercent() : Number{return 0;}
      
      private function getValueWithThumbMaxMinPos(param1:Number, param2:Number, param3:Number) : Number{return 0;}
   }
}
