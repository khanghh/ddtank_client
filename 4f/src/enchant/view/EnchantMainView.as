package enchant.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.bagStore.BagStore;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.events.ShortcutBuyEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import ddt.view.UIModuleSmallLoading;   import enchant.EnchantManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.getTimer;   import shop.manager.ShopBuyManager;      public class EnchantMainView extends Sprite implements Disposeable   {                   private var _itemBg:Bitmap;            private var _enchantValueTxt:FilterFrameText;            private var _enchantDesc:FilterFrameText;            private var _bagCell:BagCell;            private var _buyBtn:SimpleBitmapButton;            private var _upGradeBtn:SelectedCheckButton;            private var _enchantBtn:SimpleBitmapButton;            private var _successMc:MovieClip;            private var _enchantMc:MovieClip;            private var _expBar:EnchantExpBar;            private var _equipListView:EnchantBagListView;            private var _propListView:EnchantBagListView;            private var _leftDrapSprite:EnchantLeftDragSprite;            private var _itemCell:EnchantItemCell;            private var _equipCell:EnchantEquipCell;            public var updateEquipCellFunc:Function;            public var updateEquipCellInfo:InventoryItemInfo;            private var _helpBtn:BaseButton;            private var _lastExaltTime:int = 0;            public function EnchantMainView() { super(); }
            protected function _enchantProgress(event:UIModuleEvent) : void { }
            protected function _enchantCompHander(event:UIModuleEvent) : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function initProgress(isUpdate:Boolean) : void { }
            protected function __updateStoreBag(event:BagEvent) : void { }
            public function updateEquipCell() : void { }
            private function cellClickHandler(event:CellEvent) : void { }
            protected function __cellDoubleClick(evt:CellEvent) : void { }
            protected function __buySoulStoneHander(event:MouseEvent) : void { }
            private function removeFromStageHandler(event:Event) : void { }
            private function __shortCutBuyHandler(evt:ShortcutBuyEvent) : void { }
            private function createAcceptDragSprite() : void { }
            protected function __enchantHandler(event:MouseEvent) : void { }
            private function _responseI(e:FrameEvent) : void { }
            private function showEnchantMovie() : void { }
            private function disposeExaltMovie() : void { }
            private function showSuccessMovie() : void { }
            override public function set visible(value:Boolean) : void { }
            private function refreshBagList() : void { }
            public function addUpdateStoreEvent() : void { }
            public function removeUpdateStoreEvent() : void { }
            public function clearCellInfo() : void { }
            private function disposeSuccessMovie() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}