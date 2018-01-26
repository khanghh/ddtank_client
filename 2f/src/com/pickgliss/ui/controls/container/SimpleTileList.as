package com.pickgliss.ui.controls.container
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SimpleTileList extends BoxContainer
   {
       
      
      public var startPos:Point;
      
      protected var _column:int;
      
      protected var _arrangeType:int;
      
      protected var _hSpace:Number = 0;
      
      protected var _rowNum:int;
      
      protected var _vSpace:Number = 0;
      
      private var _selectedIndex:int;
      
      public function SimpleTileList(param1:int = 1, param2:int = 0){super();}
      
      public function get selectedIndex() : int{return 0;}
      
      public function set selectedIndex(param1:int) : void{}
      
      public function get hSpace() : Number{return 0;}
      
      public function set hSpace(param1:Number) : void{}
      
      public function get vSpace() : Number{return 0;}
      
      public function set vSpace(param1:Number) : void{}
      
      override public function addChild(param1:DisplayObject) : DisplayObject{return null;}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      override public function arrange() : void{}
      
      private function horizontalArrange() : void{}
      
      private function verticalArrange() : void{}
      
      private function changeSize(param1:int, param2:int) : void{}
      
      private function caculateRows() : void{}
      
      override public function dispose() : void{}
   }
}
