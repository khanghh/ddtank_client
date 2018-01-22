package beadSystem.views
{
   import bagAndInfo.cell.BagCell;
   import beadSystem.model.AdvanceBeadInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BeadAdvancedItem extends Sprite implements Disposeable
   {
       
      
      private var _info:AdvanceBeadInfo;
      
      private var _noSelectBg:Bitmap;
      
      private var _selectBg:Bitmap;
      
      private var _selectLight:Bitmap;
      
      private var _itemName:FilterFrameText;
      
      private var _itemDesc:FilterFrameText;
      
      private var _itemCell:BagCell;
      
      private var _selectState:Boolean = false;
      
      private var _selectTextStyle:String = "beadSystem.advanceBeadItem.nameTxt";
      
      private var _noSelectStyle:String = "beadSystem.advanceBeadItem.noSelect.nameTxt";
      
      private var _index:int;
      
      public function BeadAdvancedItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         buttonMode = true;
      }
      
      protected function initView() : void
      {
         _noSelectBg = ComponentFactory.Instance.creat("asset.beadSystem.advanceBeadItem.noSelectBg");
         addChild(_noSelectBg);
         _selectBg = ComponentFactory.Instance.creat("asset.beadSystem.advanceBeadItem.selectBg");
         addChild(_selectBg);
         _selectBg.visible = false;
         _selectLight = ComponentFactory.Instance.creat("asset.beadSystem.advanceBeadItem.selectLight");
         addChild(_selectLight);
         _selectLight.visible = false;
         _itemName = ComponentFactory.Instance.creatComponentByStylename(_noSelectStyle);
         addChild(_itemName);
         _itemDesc = ComponentFactory.Instance.creatComponentByStylename("beadSystem.advanceBeadItem.descTxt");
         addChild(_itemDesc);
         _itemCell = new BagCell(0);
         _itemCell.x = 10;
         _itemCell.y = 12;
         _itemCell.BGVisible = false;
         addChild(_itemCell);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set isSelect(param1:Boolean) : void
      {
         _selectState = param1;
         _noSelectBg.visible = !_selectState;
         var _loc2_:* = _selectState;
         _selectLight.visible = _loc2_;
         _selectBg.visible = _loc2_;
         if(_itemName)
         {
            ObjectUtils.disposeObject(_itemName);
            _itemName = null;
         }
         _itemName = ComponentFactory.Instance.creatComponentByStylename(!!_selectState?_selectTextStyle:_noSelectStyle);
         _itemName.text = _info.runeName;
         addChild(_itemName);
      }
      
      public function get isSelect() : Boolean
      {
         return _selectState;
      }
      
      public function get info() : AdvanceBeadInfo
      {
         return _info;
      }
      
      public function set info(param1:AdvanceBeadInfo) : void
      {
         _info = param1;
         updateView();
      }
      
      protected function updateView() : void
      {
         var _loc1_:* = null;
         if(_info != null)
         {
            _itemName.text = _info.runeName;
            _itemDesc.text = _info.advanceDesc;
            _itemCell.info = createBagCellInfo(_info.advancedTempId);
         }
      }
      
      private function createBagCellInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         _loc2_ = ItemManager.fill(_loc2_);
         _loc2_.IsBinds = true;
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(_noSelectBg)
         {
            ObjectUtils.disposeObject(_noSelectBg);
         }
         _noSelectBg = null;
         if(_selectBg)
         {
            ObjectUtils.disposeObject(_selectBg);
         }
         _selectBg = null;
         if(_selectLight)
         {
            ObjectUtils.disposeObject(_selectLight);
         }
         _selectLight = null;
         if(_itemName)
         {
            ObjectUtils.disposeObject(_itemName);
         }
         _itemName = null;
         if(_itemDesc)
         {
            ObjectUtils.disposeObject(_itemDesc);
         }
         _itemDesc = null;
         if(_itemCell)
         {
            ObjectUtils.disposeObject(_itemCell);
         }
         _itemCell = null;
         _info = null;
      }
   }
}
