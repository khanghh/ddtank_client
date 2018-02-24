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
      
      public function TreasureItem(){super();}
      
      public function initView(param1:int) : void{}
      
      override public function dispose() : void{}
      
      public function get itemIcon() : Bitmap{return null;}
      
      public function set itemIcon(param1:Bitmap) : void{}
   }
}
