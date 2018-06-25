package yyvip.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class YYVipLevelAwardItemCell extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:BagCell;
      
      private var _itemCountTxt:FilterFrameText;
      
      public function YYVipLevelAwardItemCell(info:Object)
      {
         super();
         _itemCell = new BagCell(1,null,true,null,false);
         _itemCell.setBgVisible(false);
         _itemCell.info = info.itemInfo;
         _itemCountTxt = ComponentFactory.Instance.creatComponentByStylename("yyvip.levelAwardCell.tipTxt");
         _itemCountTxt.text = "X " + info.itemCount;
         PositionUtils.setPos(_itemCountTxt,"yyvip.levelAwardCell.itemCellCountTxtPos");
         addChild(_itemCell);
         addChild(_itemCountTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _itemCell = null;
         _itemCountTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
