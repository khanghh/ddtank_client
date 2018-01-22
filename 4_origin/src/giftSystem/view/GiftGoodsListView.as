package giftSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import flash.display.Sprite;
   import giftSystem.element.GiftGoodItem;
   
   public class GiftGoodsListView extends Sprite implements Disposeable
   {
       
      
      private var _containerAll:VBox;
      
      private var _container:Vector.<HBox>;
      
      public function GiftGoodsListView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _container = new Vector.<HBox>();
         _containerAll = ComponentFactory.Instance.creatComponentByStylename("GiftGoodsListView.containerAll");
         addChild(_containerAll);
      }
      
      public function setList(param1:Vector.<ShopItemInfo>) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         clear();
         _container = new Vector.<HBox>();
         var _loc4_:int = 0;
         var _loc3_:int = param1.length < 6?param1.length:6;
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            if(_loc5_ % 2 == 0)
            {
               _loc4_ = _loc5_ / 2;
               _container[_loc4_] = ComponentFactory.Instance.creatComponentByStylename("GiftGoodsListView.container");
               _containerAll.addChild(_container[_loc4_]);
            }
            _loc2_ = new GiftGoodItem();
            if(_loc5_ < _loc3_)
            {
               _loc2_.info = param1[_loc5_];
            }
            _container[_loc4_].addChild(_loc2_);
            _loc5_++;
         }
      }
      
      private function clear() : void
      {
         var _loc1_:int = 0;
         ObjectUtils.disposeAllChildren(_containerAll);
         if(_container.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               _container[_loc1_] = null;
               _loc1_++;
            }
         }
         _container = null;
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         clear();
         if(_containerAll)
         {
            ObjectUtils.disposeObject(_containerAll);
         }
         _containerAll = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
