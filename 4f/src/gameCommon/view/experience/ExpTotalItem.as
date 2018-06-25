package gameCommon.view.experience{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.EnthrallManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import gameCommon.GameControl;      public class ExpTotalItem extends Sprite implements Disposeable   {                   public var value:Number;            private var _expTxt:Bitmap;            private var _exploitTxt:Bitmap;            private var _expNumTxt:ExpTotalNums;            private var _exploitNumTxt:ExpTotalNums;            private var _bg:Bitmap;            private var _bitmap:Bitmap;            private var _speed:Number;            private var _enthrallBit:Bitmap;            public function ExpTotalItem() { super(); }
            protected function init() : void { }
            private function addExploitTxt() : void { }
            protected function addTxt() : void { }
            public function playGreenLight() : void { }
            public function playRedLight() : void { }
            public function updateTotalExp(newValue:Number) : void { }
            public function updateTotalExploit(newValue:Number) : void { }
            public function dispose() : void { }
   }}