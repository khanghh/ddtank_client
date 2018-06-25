package com.pickgliss.ui.controls.container{   import flash.display.DisplayObject;   import flash.events.Event;      public class VBox extends BoxContainer   {                   public function VBox() { super(); }
            override public function arrange() : void { }
            private function getItemHeight(child:DisplayObject) : Number { return 0; }
   }}