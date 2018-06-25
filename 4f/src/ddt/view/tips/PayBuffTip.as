package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.VBox;   import ddt.data.BuffInfo;   import flash.events.Event;      public class PayBuffTip extends BuffTip   {                   private var _buffContainer:VBox;            private var _describe:String;            public function PayBuffTip() { super(); }
            private function __leaveStage(event:Event) : void { }
            override protected function drawNameField() : void { }
            override protected function setShow(isActive:Boolean, isFree:Boolean, day:int, hour:int, min:int, describe:String) : void { }
            private function updateTxt() : void { }
            override protected function updateWH() : void { }
   }}