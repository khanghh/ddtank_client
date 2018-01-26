package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import ddt.data.BuffInfo;
   import flash.events.Event;
   
   public class PayBuffTip extends BuffTip
   {
       
      
      private var _buffContainer:VBox;
      
      private var _describe:String;
      
      public function PayBuffTip(){super();}
      
      private function __leaveStage(param1:Event) : void{}
      
      override protected function drawNameField() : void{}
      
      override protected function setShow(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int, param6:String) : void{}
      
      private function updateTxt() : void{}
      
      override protected function updateWH() : void{}
   }
}
