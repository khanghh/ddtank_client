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
         var _loc1_:Image = ComponentFactory.Instance.creat("ddQiYuan.HasGetGoodsScrollPanelBg");
         addChild(_loc1_);
         _itemContainer = new Sprite();
         _scroll = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.HasGetGoodsScrollPanel");
         _scroll.setView(_itemContainer);
         addChild(_scroll);
      }
      
      public function update() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         _loc5_ = _itemContainer.numChildren - 1;
         while(_loc5_ > -1)
         {
            _itemContainer.removeChildAt(_loc5_);
            _loc5_--;
         }
         _loc5_ = 0;
         while(_loc5_ < _model.hasGetGoodArr.length)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
            _loc4_ = ItemManager.Instance.getTemplateById(_model.hasGetGoodArr[_loc5_]["goodId"]);
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc4_);
            _loc3_.Count = _model.hasGetGoodArr[_loc5_]["goodCount"];
            _loc3_.IsBinds = true;
            _loc1_ = new BagCell(1,_loc3_,true,_loc2_,false);
            _loc1_.PicPos = new Point(2,2);
            _loc1_.setContentSize(40,40);
            _loc1_.x = _loc5_ % 2 * 44;
            _loc1_.y = int(_loc5_ / 2) * 44;
            _loc1_.setCount(_loc3_.Count);
            _itemContainer.addChild(_loc1_);
            _loc5_++;
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
