package store.view.shortcutBuy{   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class ShortcutBuyList extends Sprite implements Disposeable   {                   private var _list:SimpleTileList;            private var _cells:Vector.<ShortcutBuyCell>;            private var _cow:int;            public function ShortcutBuyList() { super(); }
            public function setup(itemIDs:Array) : void { }
            private function init() : void { }
            override public function get height() : Number { return 0; }
            private function createCells(itemIDs:Array) : void { }
            public function shine() : void { }
            public function noShine() : void { }
            private function cellClickHandler(evt:MouseEvent) : void { }
            public function get selectedItemID() : int { return 0; }
            public function set selectedItemID(value:int) : void { }
            public function set selectedIndex(value:int) : void { }
            public function get list() : SimpleTileList { return null; }
            public function dispose() : void { }
   }}