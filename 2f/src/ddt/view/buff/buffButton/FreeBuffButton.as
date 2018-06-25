package ddt.view.buff.buffButton{   import ddt.data.BuffInfo;   import ddt.view.tips.BuffTipInfo;   import flash.events.MouseEvent;      public class FreeBuffButton extends BuffButton   {                   public function FreeBuffButton() { super(null); }
            override protected function __onclick(evt:MouseEvent) : void { }
            override public function set info(value:BuffInfo) : void { }
            override public function get tipData() : Object { return null; }
   }}