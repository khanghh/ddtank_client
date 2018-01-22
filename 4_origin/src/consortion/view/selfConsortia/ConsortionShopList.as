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
      
      public function list(param1:Vector.<ShopItemInfo>, param2:int, param3:int, param4:Boolean = false) : void
      {
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         clearList();
         _shopId = param2 + 10;
         _loc9_ = 0;
         while(_loc9_ < param1.length)
         {
            _loc6_ = new ConsortionShopItem(param4);
            _list.addChild(_loc6_);
            _loc6_.info = param1[_loc9_];
            _loc6_.neededRich = param3;
            _items.push(_loc6_);
            _loc9_++;
         }
         if(param1.length < 6)
         {
            _loc7_ = 6 - param1.length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc5_ = new ConsortionShopItem(param4);
               _list.addChild(_loc5_);
               _items.push(_loc5_);
               _loc8_++;
            }
         }
      }
      
      private function clearList() : void
      {
         var _loc1_:int = 0;
         if(_items && _list)
         {
            _loc1_ = 0;
            while(_loc1_ < _items.length)
            {
               _items[_loc1_].dispose();
               _loc1_++;
            }
            _list.disposeAllChildren();
         }
         _items = [];
      }
   }
}
