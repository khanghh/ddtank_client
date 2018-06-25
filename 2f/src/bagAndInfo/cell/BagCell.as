package bagAndInfo.cell{   import bagAndInfo.bag.BreakGoodsBtn;   import bagAndInfo.bag.ContinueGoodsBtn;   import bagAndInfo.bag.SellGoodsBtn;   import bagAndInfo.bag.SellGoodsFrame;   import baglocked.BaglockedManager;   import baglocked.SetPassEvent;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.cmd.CmdCheckBagLockedPSWNeeds;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CellEvent;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import enchant.EnchantManager;   import farm.viewx.FarmFieldBlock;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;   import flash.utils.getQualifiedClassName;   import magicHouse.MagicHouseModel;   import petsBag.PetsBagManager;   import petsBag.view.item.SkillItem;   import playerDress.components.DressUtils;      public class BagCell extends BaseCell   {                   protected var _place:int;            protected var _tbxCount:FilterFrameText;            protected var _bgOverDate:Bitmap;            protected var _cellMouseOverBg:Bitmap;            protected var _cellMouseOverFormer:Bitmap;            private var _mouseOverEffBoolean:Boolean;            protected var _bagType:int;            protected var _isShowIsUsedBitmap:Boolean;            protected var _isUsed:Boolean;            protected var _isUsedBitmap:Bitmap;            protected var _enchantMc:MovieClip;            protected var _enchantMcName:String = "asset.enchant.level";            protected var _enchantMcPosStr:String = "enchant.levelMcPos";            private var placeArr:Array;            protected var temInfo:InventoryItemInfo;            private var _sellFrame:SellGoodsFrame;            private var _markId:int = 0;            public function BagCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null); }
            public function setBgVisible(bool:Boolean) : void { }
            public function set mouseOverEffBoolean(boolean:Boolean) : void { }
            public function get bagType() : int { return 0; }
            public function set bagType(value:int) : void { }
            public function get isShowIsUsedBitmap() : Boolean { return false; }
            public function set isShowIsUsedBitmap(value:*) : void { }
            override protected function createChildren() : void { }
            public function set isUsed(value:Boolean) : void { }
            public function get isUsed() : Boolean { return false; }
            protected function addIsUsedBitmap() : void { }
            protected function addEnchantMc() : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            public function deleteEnchantMc() : void { }
            override protected function onMouseClick(evt:MouseEvent) : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            override protected function onMouseOut(evt:MouseEvent) : void { }
            public function onParentMouseOver(cellMouseOverBgEff:Bitmap) : void { }
            public function onParentMouseOut() : void { }
            protected function updateBgVisible(visible:Boolean) : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            private function isPetBagCellMove(source:BagCell, target:BagCell) : Boolean { return false; }
            private function sendDefy() : void { }
            override public function dragStart() : void { }
            override public function dragStop(effect:DragEffect) : void { }
            public function dragCountStart(count:int) : void { }
            public function sellItem($info:InventoryItemInfo = null) : void { }
            private function showSellFrame($info:InventoryItemInfo) : void { }
            private function disposeSellFrame(event:Event) : void { }
            protected function __onCellResponse(evt:FrameEvent) : void { }
            private function getAlertInfo() : AlertInfo { return null; }
            private function confirmCancel() : void { }
            public function get place() : int { return 0; }
            public function set place(value:int) : void { }
            public function get itemInfo() : InventoryItemInfo { return null; }
            public function replaceBg(bg:Sprite) : void { }
            public function setCount(num:*) : void { }
            public function getCount() : int { return 0; }
            public function refreshTbxPos() : void { }
            public function setCountNotVisible() : void { }
            public function updateCount() : void { }
            public function checkOverDate() : void { }
            public function grayPic() : void { }
            public function lightPic() : void { }
            public function set BGVisible(value:Boolean) : void { }
            private function __cancelBtn(event:SetPassEvent) : void { }
            override public function dispose() : void { }
            public function get markId() : int { return 0; }
            public function set markId(value:int) : void { }
            public function get tbxCount() : FilterFrameText { return null; }
   }}