package ddtKingWay.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Sprite;
   
   public class DDTKingWayRewardCell extends Sprite implements Disposeable
   {
       
      
      private var _item:Image;
      
      private var _cell:BagCell;
      
      public function DDTKingWayRewardCell()
      {
         super();
         _item = ComponentFactory.Instance.creatComponentByStylename("ddtKingWay.receiveItem");
         _cell = new BagCell(0);
         addChild(_cell);
         addChild(_item);
      }
      
      public function set showitem(value:Boolean) : void
      {
         _item.visible = value;
      }
      
      public function set info(value:ItemTemplateInfo) : void
      {
         _cell.info = value;
      }
      
      public function setCount(num:*) : void
      {
         _cell.setCount(num);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_item);
         ObjectUtils.disposeObject(_cell);
         _item = null;
         _cell = null;
      }
   }
}
