package store.newFusion.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import store.newFusion.data.FusionNewVo;
   
   public class FusionNewMaterialCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _tipTxt:FilterFrameText;
      
      private var _itemCell:BagCell;
      
      private var _itemCountTxt:FilterFrameText;
      
      private var _index:int;
      
      private var _data:FusionNewVo;
      
      private var _needCount:int;
      
      public function FusionNewMaterialCell(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.ddtstore.GoodPanel");
         PositionUtils.setPos(_bg,"store.newFusion.rightView.materialBgPos");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBG.GoodCellText");
         PositionUtils.setPos(_tipTxt,"store.newFusion.rightView.materialTipTxtPos");
         _tipTxt.text = LanguageMgr.GetTranslation("ddt.store.newFusion.rightView.cellTipTxt");
         _itemCell = new BagCell(1,null,true,null,false);
         _itemCell.setBgVisible(false);
         PositionUtils.setPos(_itemCell,"store.newFusion.rightView.materialItemCellPos");
         _itemCountTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.rightView.cellCountTxt");
         addChild(_bg);
         addChild(_tipTxt);
         addChild(_itemCell);
         addChild(_itemCountTxt);
      }
      
      public function refreshView(param1:FusionNewVo) : void
      {
         _data = param1;
         var _loc2_:ItemTemplateInfo = !!_data?_data.getItemInfoByIndex(_index):null;
         if(!_loc2_)
         {
            _itemCell.visible = false;
            _itemCountTxt.visible = false;
         }
         else
         {
            _itemCell.visible = true;
            _itemCell.info = _loc2_;
            _itemCell.x = 20;
            _itemCell.y = 20;
            _itemCountTxt.visible = true;
            _needCount = _data.getItemNeedCount(_index);
            _itemCountTxt.text = _data.getItemHadCount(_index) + "/" + _needCount;
         }
      }
      
      public function refreshCount() : void
      {
         if(_data)
         {
            _itemCountTxt.text = _data.getItemHadCount(_index) + "/" + _needCount;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _tipTxt = null;
         _itemCell = null;
         _itemCountTxt = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
