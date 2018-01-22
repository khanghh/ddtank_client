package ddQiYuan.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.DDQiYuanManager;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class HasGetGoodsList extends Sprite implements Disposeable
   {
       
      
      private var _scroll:ScrollPanel;
      
      private var _itemContainer:Sprite;
      
      private var _model:DDQiYuanModel;
      
      public function HasGetGoodsList(){super();}
      
      private function initView() : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
