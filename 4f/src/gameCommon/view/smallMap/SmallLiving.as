package gameCommon.view.smallMap{   import flash.geom.Matrix;   import gameCommon.GameControl;   import gameCommon.model.Living;   import phy.object.SmallObject;      public class SmallLiving extends SmallObject   {                   protected var _info:Living;            public function SmallLiving() { super(); }
            public function set info(value:Living) : void { }
            public function get info() : Living { return null; }
            override protected function draw() : void { }
            protected function drawOldCircle() : void { }
            protected function drawRect() : void { }
            protected function drawCircle() : void { }
            protected function drawTriangle() : void { }
            protected function drawLinearColor() : void { }
            protected function fitInfo() : void { }
            public function setColor(index:int) : void { }
   }}