package cityBattle.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import cityBattle.CityBattleManager;   import cityBattle.data.WelfareInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class WelfareCell extends Sprite implements Disposeable   {                   private var _exchangeBtn:SimpleBitmapButton;            private var _bagCell:BagCell;            private var _info:WelfareInfo;            private var _lockIcon:Bitmap;            private var open:Boolean = true;            public function WelfareCell() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            protected function __outHandler(event:MouseEvent) : void { }
            protected function __overHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            private function __exchangeHandler(e:MouseEvent) : void { }
            public function set info(value:WelfareInfo) : void { }
            public function get info() : WelfareInfo { return null; }
            public function dispose() : void { }
   }}