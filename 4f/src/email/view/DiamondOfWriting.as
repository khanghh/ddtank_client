package email.view{   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.ITipedDisplay;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.EmailEvent;   import ddt.manager.LanguageMgr;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;      public class DiamondOfWriting extends DiamondBase implements ITipedDisplay   {                   private var _cellGoodsID:int;            private var _annex:ItemTemplateInfo;            private var _tipStyle:String;            private var _tipData:Object;            private var _tipDirctions:String;            private var _tipGapV:int;            private var _tipGapH:int;            public function DiamondOfWriting() { super(); }
            public function get annex() : ItemTemplateInfo { return null; }
            public function set annex(value:ItemTemplateInfo) : void { }
            override protected function initView() : void { }
            override protected function update() : void { }
            override protected function addEvent() : void { }
            override protected function removeEvent() : void { }
            public function setBagUnlock() : void { }
            private function __click(event:MouseEvent) : void { }
            private function __dragInBag(event:Event) : void { }
            override public function dispose() : void { }
            public function get tipStyle() : String { return null; }
            public function get tipData() : Object { return null; }
            public function get tipDirctions() : String { return null; }
            public function get tipGapV() : int { return 0; }
            public function get tipGapH() : int { return 0; }
            public function set tipStyle(value:String) : void { }
            public function set tipData(value:Object) : void { }
            public function set tipDirctions(value:String) : void { }
            public function set tipGapV(value:int) : void { }
            public function set tipGapH(value:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}