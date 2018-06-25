package yyvip.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class YYVipAwardCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemCell:BagCell;
      
      private var _countBg:Bitmap;
      
      private var _itemCountTxt:FilterFrameText;
      
      private var _itemNameTxt:FilterFrameText;
      
      public function YYVipAwardCell(info:Object)
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.yyvip.awardCell.bg");
         _itemCell = new BagCell(1,null,true,null,false);
         _itemCell.setBgVisible(false);
         _itemCell.info = info.itemInfo;
         PositionUtils.setPos(_itemCell,"yyvip.awardCell.itemCellPos");
         _countBg = ComponentFactory.Instance.creatBitmap("asset.yyvip.awardCount.bg");
         _itemCountTxt = ComponentFactory.Instance.creatComponentByStylename("yyvip.awardCell.itemCountTxt");
         _itemCountTxt.text = info.itemCount;
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("yyvip.awardCell.itemNameTxt");
         _itemNameTxt.text = info.itemInfo.Name;
         addChild(_bg);
         addChild(_itemCell);
         addChild(_countBg);
         addChild(_itemCountTxt);
         addChild(_itemNameTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _itemCell = null;
         _countBg = null;
         _itemCountTxt = null;
         _itemNameTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
