package bagAndInfo.cell
{
   import bagAndInfo.bag.BreakGoodsBtn;
   import bagAndInfo.bag.ContinueGoodsBtn;
   import bagAndInfo.bag.SellGoodsBtn;
   import bagAndInfo.bag.SellGoodsFrame;
   import baglocked.BaglockedManager;
   import baglocked.SetPassEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.cmd.CmdCheckBagLockedPSWNeeds;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import enchant.EnchantManager;
   import farm.viewx.FarmFieldBlock;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.getQualifiedClassName;
   import magicHouse.MagicHouseModel;
   import petsBag.PetsBagManager;
   import petsBag.view.item.SkillItem;
   import playerDress.components.DressUtils;
   
   public class BagCell extends BaseCell
   {
       
      
      protected var _place:int;
      
      protected var _tbxCount:FilterFrameText;
      
      protected var _bgOverDate:Bitmap;
      
      protected var _cellMouseOverBg:Bitmap;
      
      protected var _cellMouseOverFormer:Bitmap;
      
      private var _mouseOverEffBoolean:Boolean;
      
      protected var _bagType:int;
      
      protected var _isShowIsUsedBitmap:Boolean;
      
      protected var _isUsed:Boolean;
      
      protected var _isUsedBitmap:Bitmap;
      
      protected var _enchantMc:MovieClip;
      
      protected var _enchantMcName:String = "asset.enchant.level";
      
      protected var _enchantMcPosStr:String = "enchant.levelMcPos";
      
      private var placeArr:Array;
      
      protected var temInfo:InventoryItemInfo;
      
      private var _sellFrame:SellGoodsFrame;
      
      private var _markId:int = 0;
      
      public function BagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null);}
      
      public function setBgVisible(param1:Boolean) : void{}
      
      public function set mouseOverEffBoolean(param1:Boolean) : void{}
      
      public function get bagType() : int{return 0;}
      
      public function set bagType(param1:int) : void{}
      
      public function get isShowIsUsedBitmap() : Boolean{return false;}
      
      public function set isShowIsUsedBitmap(param1:*) : void{}
      
      override protected function createChildren() : void{}
      
      public function set isUsed(param1:Boolean) : void{}
      
      public function get isUsed() : Boolean{return false;}
      
      protected function addIsUsedBitmap() : void{}
      
      protected function addEnchantMc() : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      public function deleteEnchantMc() : void{}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
      
      public function onParentMouseOver(param1:Bitmap) : void{}
      
      public function onParentMouseOut() : void{}
      
      protected function updateBgVisible(param1:Boolean) : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function isPetBagCellMove(param1:BagCell, param2:BagCell) : Boolean{return false;}
      
      private function sendDefy() : void{}
      
      override public function dragStart() : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      public function dragCountStart(param1:int) : void{}
      
      public function sellItem(param1:InventoryItemInfo = null) : void{}
      
      private function showSellFrame(param1:InventoryItemInfo) : void{}
      
      private function disposeSellFrame(param1:Event) : void{}
      
      protected function __onCellResponse(param1:FrameEvent) : void{}
      
      private function getAlertInfo() : AlertInfo{return null;}
      
      private function confirmCancel() : void{}
      
      public function get place() : int{return 0;}
      
      public function set place(param1:int) : void{}
      
      public function get itemInfo() : InventoryItemInfo{return null;}
      
      public function replaceBg(param1:Sprite) : void{}
      
      public function setCount(param1:*) : void{}
      
      public function getCount() : int{return 0;}
      
      public function refreshTbxPos() : void{}
      
      public function setCountNotVisible() : void{}
      
      public function updateCount() : void{}
      
      public function checkOverDate() : void{}
      
      public function grayPic() : void{}
      
      public function lightPic() : void{}
      
      public function set BGVisible(param1:Boolean) : void{}
      
      private function __cancelBtn(param1:SetPassEvent) : void{}
      
      override public function dispose() : void{}
      
      public function get markId() : int{return 0;}
      
      public function set markId(param1:int) : void{}
      
      public function get tbxCount() : FilterFrameText{return null;}
   }
}
