package room.view.chooseMap{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class DungeonMapItem extends BaseMapItem   {            private static const SHINE_DELAY:int = 200;                   private var _timer:Timer;            private var _isNightmare:Boolean;            private var _isDouble:Boolean;            private var _doubleBmp:Bitmap;            public function DungeonMapItem() { super(); }
            override protected function initView() : void { }
            public function shine() : void { }
            public function stopShine() : void { }
            private function __onTimer(evt:TimerEvent) : void { }
            override public function set mapId(value:int) : void { }
            override protected function updateMapIcon() : void { }
            override protected function solvePath() : String { return null; }
            public function get isNightmare() : Boolean { return false; }
            public function set isNightmare(value:Boolean) : void { }
            public function get isDouble() : Boolean { return false; }
            public function set isDouble(value:Boolean) : void { }
            private function addDoulbeBmp() : void { }
            override public function dispose() : void { }
   }}