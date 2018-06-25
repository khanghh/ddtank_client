package mark.views{   import baglocked.BaglockedManager;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.MouseEvent;   import mark.MarkMgr;   import mark.data.MarkBagData;   import mark.data.MarkChipData;   import mark.data.MarkChipTemplateData;   import mark.data.MarkSetTemplateData;   import mark.event.MarkEvent;   import mark.items.MarkBagItem;   import mark.mornUI.views.MarkBagViewUI;   import morn.core.handlers.Handler;      public class MarkBagView extends MarkBagViewUI   {            private static const _ROW:int = 4;            private static const _CLOUMN:int = 7;                   private var _blackGound:Sprite = null;            private var _rankCombo:ComboBox = null;            private var _setId:int = -1;            private var _rankType:int = 0;            public function MarkBagView() { super(); }
            override protected function initialize() : void { }
            private function initEvent() : void { }
            private function cancelSell(evt:MarkEvent) : void { }
            private function removeEvent() : void { }
            private function updateSellStatus(evt:MarkEvent = null) : void { }
            private function help() : void { }
            private function get sortedSuits() : Array { return null; }
            private function itemClickHander(event:ListItemEvent) : void { }
            private function sort() : void { }
            private function goBack() : void { }
            private function cancel() : void { }
            private function choose() : void { }
            private function __onBlackGoundMouseDown(event:MouseEvent) : void { }
            private function sell() : void { }
            private function render(item:MarkBagItem, index:int) : void { }
            public function set data(value:MarkBagData) : void { }
            override public function dispose() : void { }
   }}