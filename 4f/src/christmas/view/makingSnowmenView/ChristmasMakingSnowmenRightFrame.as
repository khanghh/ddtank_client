package christmas.view.makingSnowmenView{   import christmas.ChristmasCoreController;   import christmas.ChristmasCoreManager;   import christmas.info.ChristmasSystemItemsInfo;   import christmas.items.ChristmasListItem;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;   import road7th.comm.PackageIn;      public class ChristmasMakingSnowmenRightFrame extends Sprite implements Disposeable   {            public static var specialItemId:int = 201156;            public static var packsReceiveOK:Boolean;                   private var _list:VBox;            private var _panel:ScrollPanel;            private var _itemList:Array;            private var SHOP_ITEM_NUM:int = 9;            private var CURRENT_PAGE:int = 1;            private var _shopItemArr:Array;            public function ChristmasMakingSnowmenRightFrame() { super(); }
            public function get shopItemArr() : Array { return null; }
            public function set itemList(value:Array) : void { }
            public function get itemList() : Array { return null; }
            private function initView() : void { }
            public function loadList() : void { }
            public function setList(list:Vector.<ChristmasSystemItemsInfo>) : void { }
            private function initEvent() : void { }
            private function playerIsReceivePacks(event:CrazyTankSocketEvent) : void { }
            private function clearitems() : void { }
            private function removeEvent() : void { }
            private function disposeItems() : void { }
            public function dispose() : void { }
   }}