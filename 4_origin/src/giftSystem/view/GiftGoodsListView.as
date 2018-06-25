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
      
      public function setList(list:Vector.<ShopItemInfo>) : void
      {
         var i:int = 0;
         var item:* = null;
         clear();
         _container = new Vector.<HBox>();
         var k:int = 0;
         var sum:int = list.length < 6?list.length:6;
         for(i = 0; i < 6; )
         {
            if(i % 2 == 0)
            {
               k = i / 2;
               _container[k] = ComponentFactory.Instance.creatComponentByStylename("GiftGoodsListView.container");
               _containerAll.addChild(_container[k]);
            }
            item = new GiftGoodItem();
            if(i < sum)
            {
               item.info = list[i];
            }
            _container[k].addChild(item);
            i++;
         }
      }
      
      private function clear() : void
      {
         var i:int = 0;
         ObjectUtils.disposeAllChildren(_containerAll);
         if(_container.length > 0)
         {
            for(i = 0; i < 3; )
            {
               _container[i] = null;
               i++;
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
