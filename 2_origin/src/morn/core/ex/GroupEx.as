package morn.core.ex
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import morn.core.components.Box;
   import morn.core.components.IItem;
   import morn.core.components.ISelect;
   import morn.core.handlers.Handler;
   
   public class GroupEx extends Box implements IItem
   {
       
      
      protected var _items:Vector.<ISelect>;
      
      protected var _selectHandler:Handler;
      
      protected var _selectedIndex:int = -1;
      
      protected var _skin:String;
      
      protected var _imageLabels:String;
      
      protected var _direction:String;
      
      protected var _space:Number = 0;
      
      public function GroupEx(imageLabels:String = null, skin:String = null)
      {
         super();
         this.skin = skin;
         this.imageLabels = imageLabels;
      }
      
      public function addItem(item:ISelect, autoLayOut:Boolean = true) : int
      {
         var preItem:* = null;
         var display:DisplayObject = item as DisplayObject;
         var index:int = _items.length;
         display.name = "item" + index;
         addChild(display);
         initItems();
         if(autoLayOut && index > 0)
         {
            preItem = _items[index - 1] as DisplayObject;
            if(_direction == "horizontal")
            {
               display.x = preItem.x + preItem.width + _space;
            }
            else
            {
               display.y = preItem.y + preItem.height + _space;
            }
         }
         return index;
      }
      
      public function delItem(item:ISelect, autoLayOut:Boolean = true) : void
      {
         var display:* = null;
         var i:int = 0;
         var n:int = 0;
         var child:* = null;
         var index:int = _items.indexOf(item);
         if(index != -1)
         {
            display = item as DisplayObject;
            removeChild(display);
            for(i = index + 1,n = _items.length; i < n; )
            {
               child = _items[i] as DisplayObject;
               child.name = "item" + (i - 1);
               if(autoLayOut)
               {
                  if(_direction == "horizontal")
                  {
                     child.x = child.x - (display.width + _space);
                  }
                  else
                  {
                     child.y = child.y - (display.height + _space);
                  }
               }
               i++;
            }
            initItems();
            if(_selectedIndex > -1)
            {
               selectedIndex = _selectedIndex < _items.length?_selectedIndex:_selectedIndex - 1;
            }
         }
      }
      
      public function initItems() : void
      {
         var i:int = 0;
         var item:* = null;
         _items = new Vector.<ISelect>();
         for(i = 0; i < 2147483647; )
         {
            item = getChildByName("item" + i) as ISelect;
            if(item != null)
            {
               _items.push(item);
               item.selected = i == _selectedIndex;
               item.clickHandler = new Handler(itemClick,[i]);
               i++;
               continue;
            }
            break;
         }
      }
      
      protected function itemClick(index:int) : void
      {
         selectedIndex = index;
      }
      
      public function resetSelect() : void
      {
         setSelect(_selectedIndex,false);
         _selectedIndex = -1;
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
            sendEvent("change");
            sendEvent("select");
            if(_selectHandler != null)
            {
               _selectHandler.executeWith([_selectedIndex]);
            }
         }
      }
      
      public function set selectedIndexWithoutEvent(value:int) : void
      {
         if(_selectedIndex != value)
         {
            setSelect(_selectedIndex,false);
            _selectedIndex = value;
            setSelect(_selectedIndex,true);
            sendEvent("change");
         }
      }
      
      protected function setSelect(index:int, selected:Boolean) : void
      {
         if(_items && index > -1 && index < _items.length)
         {
            _items[index].selected = selected;
         }
      }
      
      public function get selectHandler() : Handler
      {
         return _selectHandler;
      }
      
      public function set selectHandler(value:Handler) : void
      {
         _selectHandler = value;
      }
      
      public function get skin() : String
      {
         return _skin;
      }
      
      public function set skin(value:String) : void
      {
         if(_skin != value)
         {
            _skin = value;
            callLater(changeImageLabels);
         }
      }
      
      public function get imageLabels() : String
      {
         return _imageLabels;
      }
      
      public function set imageLabels(value:String) : void
      {
         var a:* = null;
         var b:* = null;
         var i:int = 0;
         var n:int = 0;
         var item:* = null;
         if(_imageLabels != value)
         {
            _imageLabels = value;
            removeAllChild();
            callLater(changeImageLabels);
            if(imageLabels)
            {
               a = _imageLabels.split(",");
               b = _skin.split(",");
               for(i = 0,n = a.length; i < n; )
               {
                  item = createItem(b.length <= i?_skin:b[i],a[i]);
                  item.name = "item" + i;
                  addChild(item);
                  i++;
               }
            }
            initItems();
         }
      }
      
      protected function createItem(skin:String, imageLabel:String) : DisplayObject
      {
         return null;
      }
      
      public function get direction() : String
      {
         return _direction;
      }
      
      public function set direction(value:String) : void
      {
         _direction = value;
         callLater(changeImageLabels);
      }
      
      public function get space() : Number
      {
         return _space;
      }
      
      public function set space(value:Number) : void
      {
         _space = value;
         callLater(changeImageLabels);
      }
      
      protected function changeImageLabels() : void
      {
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeImageLabels);
      }
      
      public function get items() : Vector.<ISelect>
      {
         return _items;
      }
      
      public function get selection() : ISelect
      {
         return _selectedIndex > -1 && _selectedIndex < _items.length?_items[_selectedIndex]:null;
      }
      
      public function set selection(value:ISelect) : void
      {
         selectedIndex = _items.indexOf(value);
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is int || value is String)
         {
            selectedIndex = int(value);
         }
         else if(value is Array)
         {
            imageLabels = (value as Array).join(",");
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         while(_items && _items.length)
         {
            ObjectUtils.disposeObject(_items.pop());
         }
         _items = null;
         _selectHandler = null;
      }
   }
}
