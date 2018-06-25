package morn.core.components
{
   import flash.display.DisplayObject;
   import morn.core.handlers.Handler;
   
   public class ViewStack extends Box implements IItem
   {
       
      
      protected var _items:Vector.<DisplayObject>;
      
      protected var _setIndexHandler:Handler;
      
      protected var _selectedIndex:int;
      
      public function ViewStack()
      {
         _setIndexHandler = new Handler(setIndex);
         super();
      }
      
      public function setItems(views:Array) : void
      {
         var i:int = 0;
         var n:int = 0;
         var item:* = null;
         removeAllChild();
         var index:int = 0;
         for(i = 0,n = views.length; i < n; )
         {
            item = views[i];
            if(item)
            {
               item.name = "item" + index;
               addChild(item);
               index++;
            }
            i++;
         }
         initItems();
      }
      
      public function addItem(view:DisplayObject) : void
      {
         view.name = "item" + _items.length;
         addChild(view);
         initItems();
      }
      
      public function initItems() : void
      {
         var i:int = 0;
         var item:* = null;
         _items = new Vector.<DisplayObject>();
         for(i = 0; i < 2147483647; )
         {
            item = getChildByName("item" + i);
            if(item != null)
            {
               _items.push(item);
               item.visible = i == _selectedIndex;
               i++;
               continue;
            }
            break;
         }
      }
      
      public function get selectedIndex() : int
      {
         return _selectedIndex;
      }
      
      public function set selectedIndex(value:int) : void
      {
         if(_selectedIndex != value)
         {
            setSelect(_selectedIndex,false);
            _selectedIndex = value;
            setSelect(_selectedIndex,true);
         }
      }
      
      protected function setSelect(index:int, selected:Boolean) : void
      {
         if(_items && index > -1 && index < _items.length)
         {
            _items[index].visible = selected;
         }
      }
      
      public function get selection() : DisplayObject
      {
         return _selectedIndex > -1 && _selectedIndex < _items.length?_items[_selectedIndex]:null;
      }
      
      public function set selection(value:DisplayObject) : void
      {
         selectedIndex = _items.indexOf(value);
      }
      
      public function get setIndexHandler() : Handler
      {
         return _setIndexHandler;
      }
      
      public function set setIndexHandler(value:Handler) : void
      {
         _setIndexHandler = value;
      }
      
      protected function setIndex(index:int) : void
      {
         selectedIndex = index;
      }
      
      public function get items() : Vector.<DisplayObject>
      {
         return _items;
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is int || value is String)
         {
            selectedIndex = int(value);
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_items)
         {
            _items.length = 0;
         }
         _items = null;
         _setIndexHandler = null;
      }
   }
}
