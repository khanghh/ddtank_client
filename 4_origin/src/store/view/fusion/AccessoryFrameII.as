package store.view.fusion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.Event;
   import store.events.StoreIIEvent;
   
   public class AccessoryFrameII extends Frame
   {
       
      
      private var _list:SimpleTileList;
      
      private var _bg:Shape;
      
      private var _items:Array;
      
      private var _area:AccessoryDragInArea;
      
      public function AccessoryFrameII()
      {
         super();
         initII();
      }
      
      private function initII() : void
      {
         titleText = LanguageMgr.GetTranslation("store.view.fusion.AccessoryFrame.add");
         _bg = new Shape();
         _bg.graphics.lineStyle(1,16777215);
         _bg.graphics.beginFill(7760227,1);
         _bg.graphics.drawRect(0,0,224,172);
         _bg.graphics.endFill();
         addToContent(_bg);
         _list = new SimpleTileList(3);
         addToContent(_list);
         _items = [];
         initList();
      }
      
      private function initList() : void
      {
         var i:int = 0;
         var item:* = null;
         var cell:* = null;
         clearList();
         for(i = 5; i < 11; )
         {
            item = ComponentFactory.Instance.creatBitmap("asset.ddtstore.FusionGoodsiBG");
            cell = new AccessoryItemCell(i);
            cell.addEventListener("change",__itemInfoChange);
            _items.push(cell);
            _list.addChild(item);
            i++;
         }
         _area = new AccessoryDragInArea(_items);
         _list.parent.addChildAt(_area,0);
      }
      
      private function __itemInfoChange(evt:Event) : void
      {
         dispatchEvent(new StoreIIEvent("itemclick"));
      }
      
      public function clearList() : void
      {
         var i:int = 0;
         var cell:* = null;
         _list.disposeAllChildren();
         for(i = 0; i < _items.length; )
         {
            cell = _items[i] as AccessoryItemCell;
            cell.removeEventListener("change",__itemInfoChange);
            cell.dispose();
            i++;
         }
         _items = [];
      }
      
      public function get isBinds() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            if(_items[i] && _items[i].info && _items[i].info.IsBinds)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function setItemInfo(index:int, info:ItemTemplateInfo) : void
      {
         _items[index - 5].info = info;
      }
      
      public function listEmpty() : void
      {
         var i:int = 0;
         var cell:* = null;
         for(i = 0; i < _items.length; )
         {
            cell = _items[i] as AccessoryItemCell;
            i++;
         }
      }
      
      public function show() : void
      {
      }
      
      public function hide() : void
      {
      }
      
      public function getCount() : Number
      {
         var i:int = 0;
         var count:* = 0;
         for(i = 0; i < _items.length; )
         {
            if(_items[i] != null && _items[i].info != null)
            {
               count++;
            }
            i++;
         }
         return count;
      }
      
      public function containsItem(item:InventoryItemInfo) : Boolean
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            if(_items[i] != null && _items[i].itemInfo == item)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function getAllAccessory() : Array
      {
         var i:int = 0;
         var data1:* = null;
         var data:Array = [];
         for(i = 0; i < _items.length; )
         {
            if(_items[i] != null && _items[i].info != null)
            {
               data1 = [];
               data1.push(_items[i].info.BagType);
               data1.push(_items[i].place);
               data.push(data1);
            }
            i++;
         }
         return data;
      }
      
      override public function dispose() : void
      {
         clearList();
         if(_area)
         {
            ObjectUtils.disposeObject(_area);
         }
         _area = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
