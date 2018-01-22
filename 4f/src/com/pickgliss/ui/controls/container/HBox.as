package com.pickgliss.ui.controls.container
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class HBox extends BoxContainer
   {
       
      
      public function HBox(){super();}
      
      override public function arrange() : void{}
      
      private function getItemWidth(param1:DisplayObject) : Number{return 0;}
   }
}
