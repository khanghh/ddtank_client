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
      
      public function setList(param1:Array) : void
      {
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var _loc3_ in _items)
         {
            _loc3_.dispose();
         }
         _items = [];
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(var _loc4_ in param1)
         {
            _loc2_ = new BadgeShopItem(_loc4_);
            _list.addChild(_loc2_);
            _items.push(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc1_.dispose();
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
