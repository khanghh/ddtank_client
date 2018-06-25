package com.pickgliss.ui.controls.alert{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.vo.AlertInfo;      public class SimpleAlertWithNotShowAgain extends SimpleAlert   {                   private var _scb:SelectedCheckButton;            public function SimpleAlertWithNotShowAgain() { super(); }
            public function get isNoPrompt() : Boolean { return false; }
            override public function set info(value:AlertInfo) : void { }
            override protected function onProppertiesUpdate() : void { }
            override protected function layoutFrameRect() : void { }
   }}