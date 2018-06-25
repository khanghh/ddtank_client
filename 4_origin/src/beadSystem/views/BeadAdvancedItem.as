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
      
      public function BeadAdvancedItem(index:int)
      {
         super();
         _index = index;
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
      
      public function set isSelect(value:Boolean) : void
      {
         _selectState = value;
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
      
      public function set info(info:AdvanceBeadInfo) : void
      {
         _info = info;
         updateView();
      }
      
      protected function updateView() : void
      {
         var itemCell:* = null;
         if(_info != null)
         {
            _itemName.text = _info.runeName;
            _itemDesc.text = _info.advanceDesc;
            _itemCell.info = createBagCellInfo(_info.advancedTempId);
         }
      }
      
      private function createBagCellInfo(templeteId:int) : InventoryItemInfo
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = templeteId;
         info = ItemManager.fill(info);
         info.IsBinds = true;
         return info;
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
