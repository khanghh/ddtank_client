package morn.core.components
{
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.tip.ITip;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.core.utils.ObjectUtils;
   import morn.editor.core.IComponent;
   
   [Event(name="hideTip",type="morn.core.events.UIEvent")]
   [Event(name="showTip",type="morn.core.events.UIEvent")]
   [Event(name="move",type="morn.core.events.UIEvent")]
   [Event(name="resize",type="flash.events.Event")]
   public class Component extends Sprite implements IComponent, Disposeable, ITipedDisplay, ITip
   {
      
      public static const P_height:String = "height";
      
      public static const P_tipData:String = "tipData";
      
      public static const P_tipDirction:String = "tipDirction";
      
      public static const P_tipGap:String = "tipGap";
      
      public static const P_tipStyle:String = "tipStyle";
      
      public static const P_width:String = "width";
       
      
      protected var _width:Number;
      
      protected var _height:Number;
      
      protected var _contentWidth:Number = 0;
      
      protected var _contentHeight:Number = 0;
      
      protected var _disabled:Boolean;
      
      protected var _tag:Object;
      
      protected var _comXml:XML;
      
      protected var _comJSON:Object;
      
      protected var _dataSource:Object;
      
      protected var _toolTip:Object;
      
      protected var _mouseChildren:Boolean;
      
      protected var _top:Number;
      
      protected var _bottom:Number;
      
      protected var _left:Number;
      
      protected var _right:Number;
      
      protected var _centerX:Number;
      
      protected var _centerY:Number;
      
      protected var _layOutEabled:Boolean;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      protected var _disposeHandler:Handler;
      
      protected var _changeCount:int = 0;
      
      protected var _tipData:Object;
      
      protected var _tipDirctions:String = "4,5,6,7,0,1,2,3";
      
      protected var _tipGapV:int;
      
      protected var _tipGapH:int;
      
      protected var _tipStyle:String;
      
      protected var _changedPropeties:Dictionary;
      
      public function Component(){super();}
      
      protected function preinitialize() : void{}
      
      protected function createChildren() : void{}
      
      protected function initialize() : void{}
      
      public function callLater(param1:Function, param2:Array = null) : void{}
      
      public function exeCallLater(param1:Function) : void{}
      
      public function sendEvent(param1:String, param2:* = null) : void{}
      
      public function remove() : void{}
      
      public function removeChildByName(param1:String) : void{}
      
      public function setPosition(param1:Number, param2:Number) : void{}
      
      override public function set x(param1:Number) : void{}
      
      override public function set y(param1:Number) : void{}
      
      override public function get width() : Number{return 0;}
      
      public function get displayWidth() : Number{return 0;}
      
      protected function get measureWidth() : Number{return 0;}
      
      override public function set width(param1:Number) : void{}
      
      override public function get height() : Number{return 0;}
      
      public function get displayHeight() : Number{return 0;}
      
      protected function get measureHeight() : Number{return 0;}
      
      override public function set height(param1:Number) : void{}
      
      override public function get x() : Number{return 0;}
      
      override public function get y() : Number{return 0;}
      
      override public function set scaleX(param1:Number) : void{}
      
      override public function set scaleY(param1:Number) : void{}
      
      public function commitMeasure() : void{}
      
      protected function changeSize() : void{}
      
      public function setSize(param1:Number, param2:Number) : void{}
      
      public function set scale(param1:Number) : void{}
      
      public function get scale() : Number{return 0;}
      
      public function get disabled() : Boolean{return false;}
      
      public function set disabled(param1:Boolean) : void{}
      
      override public function set mouseChildren(param1:Boolean) : void{}
      
      public function get tag() : Object{return null;}
      
      public function set tag(param1:Object) : void{}
      
      public function showBorder(param1:uint = 16711680) : void{}
      
      public function get comXml() : XML{return null;}
      
      public function set comXml(param1:XML) : void{}
      
      public function get comJSON() : Object{return null;}
      
      public function set comJSON(param1:Object) : void{}
      
      public function get dataSource() : Object{return null;}
      
      public function set dataSource(param1:Object) : void{}
      
      public function get toolTip() : Object{return null;}
      
      public function set toolTip(param1:Object) : void{}
      
      private function onRollMouse(param1:MouseEvent) : void{}
      
      public function get top() : Number{return 0;}
      
      public function set top(param1:Number) : void{}
      
      public function get bottom() : Number{return 0;}
      
      public function set bottom(param1:Number) : void{}
      
      public function get left() : Number{return 0;}
      
      public function set left(param1:Number) : void{}
      
      public function get right() : Number{return 0;}
      
      public function set right(param1:Number) : void{}
      
      public function get centerX() : Number{return 0;}
      
      public function set centerX(param1:Number) : void{}
      
      public function get centerY() : Number{return 0;}
      
      public function set centerY(param1:Number) : void{}
      
      private function set layOutEabled(param1:Boolean) : void{}
      
      private function onRemoved(param1:Event) : void{}
      
      private function onAdded(param1:Event) : void{}
      
      private function onResize(param1:Event) : void{}
      
      protected function resetPosition() : void{}
      
      override public function set doubleClickEnabled(param1:Boolean) : void{}
      
      override public function addChild(param1:DisplayObject) : DisplayObject{return null;}
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject{return null;}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      protected function onPropertiesChanged(param1:String = null) : void{}
      
      protected function invalidate() : void{}
      
      public function draw() : void{}
      
      protected function onProppertiesUpdate() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
      
      protected function updateTransform() : void{}
      
      public function get disposeHandler() : Handler{return null;}
      
      public function set disposeHandler(param1:Handler) : void{}
      
      public function dispose() : void{}
   }
}
