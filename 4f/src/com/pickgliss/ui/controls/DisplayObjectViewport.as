package com.pickgliss.ui.controls
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.IntDimension;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.geom.IntRectangle;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IViewprot;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   
   public class DisplayObjectViewport extends Component implements IViewprot
   {
      
      public static const P_horizontalBlockIncrement:String = "horizontalBlockIncrement";
      
      public static const P_horizontalUnitIncrement:String = "horizontalUnitIncrement";
      
      public static const P_verticalBlockIncrement:String = "verticalBlockIncrement";
      
      public static const P_verticalUnitIncrement:String = "verticalUnitIncrement";
      
      public static const P_view:String = "view";
      
      public static const P_viewPosition:String = "viewPosition";
       
      
      protected var _horizontalBlockIncrement:int;
      
      protected var _horizontalUnitIncrement:int;
      
      protected var _maskShape:Shape;
      
      protected var _mouseActiveObjectShape:Shape;
      
      protected var _verticalBlockIncrement:int;
      
      protected var _verticalUnitIncrement:int;
      
      protected var _viewHeight:int;
      
      protected var _viewPosition:IntPoint;
      
      protected var _viewWidth:int;
      
      private var _view:DisplayObject;
      
      public function DisplayObjectViewport(){super();}
      
      public function addStateListener(param1:Function, param2:int = 0, param3:Boolean = false) : void{}
      
      override public function dispose() : void{}
      
      public function getExtentSize() : IntDimension{return null;}
      
      public function getViewSize() : IntDimension{return null;}
      
      public function getViewportPane() : Component{return null;}
      
      public function get horizontalBlockIncrement() : int{return 0;}
      
      public function set horizontalBlockIncrement(param1:int) : void{}
      
      public function get horizontalUnitIncrement() : int{return 0;}
      
      public function set horizontalUnitIncrement(param1:int) : void{}
      
      public function removeStateListener(param1:Function) : void{}
      
      public function scrollRectToVisible(param1:IntRectangle) : void{}
      
      public function setView(param1:DisplayObject) : void{}
      
      public function setViewportTestSize(param1:IntDimension) : void{}
      
      public function get verticalBlockIncrement() : int{return 0;}
      
      public function set verticalBlockIncrement(param1:int) : void{}
      
      public function get verticalUnitIncrement() : int{return 0;}
      
      public function set verticalUnitIncrement(param1:int) : void{}
      
      public function get viewPosition() : IntPoint{return null;}
      
      public function set viewPosition(param1:IntPoint) : void{}
      
      public function invalidateView() : void{}
      
      override protected function addChildren() : void{}
      
      protected function creatMaskShape() : void{}
      
      protected function fireStateChanged(param1:Boolean = true) : void{}
      
      protected function getViewMaxPos() : IntPoint{return null;}
      
      override protected function init() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function restrictionViewPos(param1:IntPoint) : IntPoint{return null;}
      
      protected function updatePos() : void{}
      
      protected function updateShowMask() : void{}
      
      private function __onResize(param1:ComponentEvent) : void{}
   }
}
