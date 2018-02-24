package com.pickgliss.ui.controls
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class NumberSelecter extends Component
   {
      
      public static const P_back:String = "P_back";
      
      public static const P_upStyle:String = "P_upStyle";
      
      public static const P_downStyle:String = "P_downStyle";
      
      public static const P_targetFieldStyle:String = "P_targetFieldStyle";
       
      
      private var _back:DisplayObject;
      
      private var _backStyle:String;
      
      private var _upDisplay:DisplayObject;
      
      private var _upStyle:String;
      
      private var _downDisplay:DisplayObject;
      
      private var _downStyle:String;
      
      private var _targetField:TextField;
      
      private var _targetFieldStyle:String;
      
      private var _currentValue:Number;
      
      private var _increment:Number = 1;
      
      protected var _valueLimit:Point;
      
      public function NumberSelecter(){super();}
      
      public function set valueLimit(param1:String) : void{}
      
      public function get currentValue() : Number{return 0;}
      
      public function get increment() : Number{return 0;}
      
      public function set increment(param1:Number) : void{}
      
      public function get targetFieldStyle() : String{return null;}
      
      public function set targetFieldStyle(param1:String) : void{}
      
      public function set targetField(param1:TextField) : void{}
      
      public function get upStyle() : String{return null;}
      
      public function set upStyle(param1:String) : void{}
      
      public function set upDisplay(param1:DisplayObject) : void{}
      
      public function get downStyle() : String{return null;}
      
      public function set downStyle(param1:String) : void{}
      
      public function set downDisplay(param1:DisplayObject) : void{}
      
      public function get downDisplay() : DisplayObject{return null;}
      
      public function get upDisplay() : DisplayObject{return null;}
      
      override protected function addChildren() : void{}
      
      private function __fieldChange(param1:Event) : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      private function setReduceBtnState() : void{}
      
      protected function __targetFieldChange(param1:Event) : void{}
      
      private function __onMouseWheel(param1:MouseEvent) : void{}
      
      public function set back(param1:DisplayObject) : void{}
      
      public function set backStyle(param1:String) : void{}
      
      public function validate(param1:FocusEvent = null) : void{}
      
      public function set currentValue(param1:Number) : void{}
      
      private function setText(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
