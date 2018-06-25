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
      
      public function HasGetGoodsList()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _model = DDQiYuanManager.instance.model;
         var bg:Image = ComponentFactory.Instance.creat("ddQiYuan.HasGetGoodsScrollPanelBg");
         addChild(bg);
         _itemContainer = new Sprite();
         _scroll = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.HasGetGoodsScrollPanel");
         _scroll.setView(_itemContainer);
         addChild(_scroll);
      }
      
      public function update() : void
      {
         var i:int = 0;
         var bagCellBg:* = null;
         var templeteInfo:* = null;
         var inventoryItemInfo:* = null;
         var bagCell:* = null;
         for(i = _itemContainer.numChildren - 1; i > -1; )
         {
            _itemContainer.removeChildAt(i);
            i--;
         }
         for(i = 0; i < _model.hasGetGoodArr.length; )
         {
            bagCellBg = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
            templeteInfo = ItemManager.Instance.getTemplateById(_model.hasGetGoodArr[i]["goodId"]);
            inventoryItemInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(inventoryItemInfo,templeteInfo);
            inventoryItemInfo.Count = _model.hasGetGoodArr[i]["goodCount"];
            inventoryItemInfo.IsBinds = true;
            bagCell = new BagCell(1,inventoryItemInfo,true,bagCellBg,false);
            bagCell.PicPos = new Point(2,2);
            bagCell.setContentSize(40,40);
            bagCell.x = i % 2 * 44;
            bagCell.y = int(i / 2) * 44;
            bagCell.setCount(inventoryItemInfo.Count);
            _itemContainer.addChild(bagCell);
            i++;
         }
         _scroll.invalidateViewport();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _scroll = null;
         _itemContainer = null;
         _model = null;
      }
   }
}
