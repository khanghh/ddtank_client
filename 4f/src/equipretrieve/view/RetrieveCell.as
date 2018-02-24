package equipretrieve.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import equipretrieve.RetrieveController;
   import equipretrieve.RetrieveModel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   
   public class RetrieveCell extends StoreCell
   {
      
      public static const SHINE_XY:int = 1;
      
      public static const SHINE_SIZE:int = 96;
       
      
      private var bg:Sprite;
      
      private var bgBit:Bitmap;
      
      private var _text:FilterFrameText;
      
      public function RetrieveCell(param1:int){super(null,null);}
      
      override public function startShine() : void{}
      
      override protected function createChildren() : void{}
      
      override protected function addEnchantMc() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override public function dispose() : void{}
   }
}
