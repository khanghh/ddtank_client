package magicHouse.treasureHouse{   import bagAndInfo.bag.BagView;   import bagAndInfo.bag.CellMenu;   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelController;   import ddt.data.BagInfo;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.SelfInfo;   import ddt.events.CellEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import magicHouse.MagicHouseControl;   import magicHouse.MagicHouseManager;   import magicHouse.MagicHouseModel;   import playerDress.PlayerDressManager;   import playerDress.components.DressUtils;   import playerDress.data.DressVo;      public class MagicHouseTreasureHouseView extends BagView   {                   private var _bagListBg:MutipleImage;            private var _bagTipBitmap:Bitmap;            private var _treasureBagListView:MagicHouseTreasureBagListView;            private var _changeToConsortion:SimpleBitmapButton;            public function MagicHouseTreasureHouseView() { super(); }
            override protected function init() : void { }
            private function setInit() : void { }
            public function setData($info:SelfInfo) : void { }
            override protected function __cellClick(evt:CellEvent) : void { }
            override protected function initEvent() : void { }
            override protected function removeEvents() : void { }
            override protected function initBackGround() : void { }
            override protected function __listChange(evt:Event) : void { }
            private function __jumpToConsortion(e:MouseEvent) : void { }
            private function __messageUpdate(e:Event) : void { }
            private function __upMagicHouseStroeLevel(evt:PlayerPropertyEvent) : void { }
            private function __addToStageHandler(evt:Event) : void { }
            override protected function __cellDoubleClick(evt:CellEvent) : void { }
            override protected function __sortBagClick(evt:MouseEvent) : void { }
            private function __bankCellClick(evt:CellEvent) : void { }
            private function __bankCellDoubleClick(evt:CellEvent) : void { }
            private function getItemBagType(info:InventoryItemInfo) : int { return 0; }
            private function checkDressSaved(info:InventoryItemInfo) : Boolean { return false; }
            override public function dispose() : void { }
   }}