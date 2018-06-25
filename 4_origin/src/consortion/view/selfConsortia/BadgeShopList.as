package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import consortion.data.BadgeInfo;
   import flash.display.Sprite;
   
   public class BadgeShopList extends Sprite implements Disposeable
   {
       
      
      private var _items:Array;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      public function BadgeShopList()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _items = [];
         _list = ComponentFactory.Instance.creat("consortion.badgeShop.list");
         _panel = ComponentFactory.Instance.creat("consortion.badgeShop.panel");
         _panel.setView(_list);
         addChild(_panel);
      }
      
      public function setList(arr:Array) : void
      {
         var item1:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var item in _items)
         {
            item.dispose();
         }
         _items = [];
         var _loc8_:int = 0;
         var _loc7_:* = arr;
         for each(var info in arr)
         {
            item1 = new BadgeShopItem(info);
            _list.addChild(item1);
            _items.push(item1);
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var item in _items)
         {
            item.dispose();
         }
         _items = null;
         _list.dispose();
         _list = null;
         _panel.dispose();
         _panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
