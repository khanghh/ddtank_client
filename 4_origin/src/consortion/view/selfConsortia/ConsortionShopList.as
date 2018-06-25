package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import flash.display.Sprite;
   
   public class ConsortionShopList extends Sprite implements Disposeable
   {
       
      
      private var _shopId:int;
      
      private var _items:Array;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      public function ConsortionShopList()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _items = [];
         _list = ComponentFactory.Instance.creat("consortion.shop.list");
         _panel = ComponentFactory.Instance.creat("consortion.shop.panel");
         _panel.setView(_list);
         addChild(_panel);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         clearList();
         ObjectUtils.disposeAllChildren(this);
         _panel = null;
         _list = null;
         _items = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function list($list:Vector.<ShopItemInfo>, shopId:int, richNum:int, enable:Boolean = false) : void
      {
         var i:int = 0;
         var item:* = null;
         var len:int = 0;
         var j:int = 0;
         var item2:* = null;
         clearList();
         _shopId = shopId + 10;
         for(i = 0; i < $list.length; )
         {
            item = new ConsortionShopItem(enable);
            _list.addChild(item);
            item.info = $list[i];
            item.neededRich = richNum;
            _items.push(item);
            i++;
         }
         if($list.length < 6)
         {
            len = 6 - $list.length;
            for(j = 0; j < len; )
            {
               item2 = new ConsortionShopItem(enable);
               _list.addChild(item2);
               _items.push(item2);
               j++;
            }
         }
      }
      
      private function clearList() : void
      {
         var i:int = 0;
         if(_items && _list)
         {
            for(i = 0; i < _items.length; )
            {
               _items[i].dispose();
               i++;
            }
            _list.disposeAllChildren();
         }
         _items = [];
      }
   }
}
