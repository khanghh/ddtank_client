package treasureHunting.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class TreasureItem extends Component implements Disposeable
   {
      
      private static const LIGHT_OFFSET:int = -3;
       
      
      private var _itemIcon:Bitmap;
      
      public var selectedLight:ScaleBitmapImage;
      
      private var _index:int;
      
      public function TreasureItem()
      {
         super();
      }
      
      public function initView(param1:int) : void
      {
         _index = param1;
         _itemIcon = ComponentFactory.Instance.creat("treasureHunting.treasure.item" + _index);
         addChild(_itemIcon);
         selectedLight = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.ItemLight");
         selectedLight.x = selectedLight.x + -3;
         selectedLight.y = selectedLight.y + -3;
         selectedLight.visible = false;
         addChild(selectedLight);
      }
      
      override public function dispose() : void
      {
         if(_itemIcon != null)
         {
            ObjectUtils.disposeObject(_itemIcon);
         }
         _itemIcon = null;
         if(selectedLight != null)
         {
            ObjectUtils.disposeObject(selectedLight);
         }
         selectedLight = null;
         super.dispose();
      }
      
      public function get itemIcon() : Bitmap
      {
         return _itemIcon;
      }
      
      public function set itemIcon(param1:Bitmap) : void
      {
         _itemIcon = param1;
      }
   }
}
