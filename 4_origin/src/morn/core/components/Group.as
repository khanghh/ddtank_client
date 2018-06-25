package morn.core.components
{
   import flash.display.DisplayObject;
   import morn.core.handlers.Handler;
   
   [Event(name="change",type="flash.events.Event")]
   public class Group extends Box implements IItem
   {
       
      
      protected var _items:Vector.<ISelect>;
      
      protected var _selectHandler:Handler;
      
      protected var _selectedIndex:int = -1;
      
      protected var _skin:String;
      
      protected var _labels:String;
      
      protected var _labelColors:String;
      
      protected var _labelStroke:String;
      
      protected var _labelSize:Object;
      
      protected var _labelBold:Object;
      
      protected var _labelMargin:String;
      
      protected var _direction:String;
      
      protected var _space:Number = 0;
      
      public function Group(labels:String = null, skin:String = null)
      {
         super();
         this.skin = skin;
         this.labels = labels;
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
            callLater(changeLabels);
         }
      }
      
      public function get labels() : String
      {
         return _labels;
      }
      
      public function set labels(value:String) : void
      {
         var a:* = null;
         var i:int = 0;
         var n:int = 0;
         var item:* = null;
         if(_labels != value)
         {
            _labels = value;
            removeAllChild();
            callLater(changeLabels);
            if(_labels)
            {
               a = _labels.split(",");
               for(i = 0,n = a.length; i < n; )
               {
                  item = createItem(_skin,a[i]);
                  item.name = "item" + i;
                  addChild(item);
                  i++;
               }
            }
            initItems();
         }
      }
      
      protected function createItem(skin:String, label:String) : DisplayObject
      {
         return null;
      }
      
      public function get labelColors() : String
      {
         return _labelColors;
      }
      
      public function set labelColors(value:String) : void
      {
         if(_labelColors != value)
         {
            _labelColors = value;
            callLater(changeLabels);
         }
      }
      
      public function get labelStroke() : String
      {
         return _labelStroke;
      }
      
      public function set labelStroke(value:String) : void
      {
         if(_labelStroke != value)
         {
            _labelStroke = value;
            callLater(changeLabels);
         }
      }
      
      public function get labelSize() : Object
      {
         return _labelSize;
      }
      
      public function set labelSize(value:Object) : void
      {
         if(_labelSize != value)
         {
            _labelSize = value;
            callLater(changeLabels);
         }
      }
      
      public function get labelBold() : Object
      {
         return _labelBold;
      }
      
      public function set labelBold(value:Object) : void
      {
         if(_labelBold != value)
         {
            _labelBold = value;
            callLater(changeLabels);
         }
      }
      
      public function get labelMargin() : String
      {
         return _labelMargin;
      }
      
      public function set labelMargin(value:String) : void
      {
         if(_labelMargin != value)
         {
            _labelMargin = value;
            callLater(changeLabels);
         }
      }
      
      public function get direction() : String
      {
         return _direction;
      }
      
      public function set direction(value:String) : void
      {
         _direction = value;
         callLater(changeLabels);
      }
      
      public function get space() : Number
      {
         return _space;
      }
      
      public function set space(value:Number) : void
      {
         _space = value;
         callLater(changeLabels);
      }
      
      protected function changeLabels() : void
      {
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeLabels);
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
            labels = (value as Array).join(",");
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
         _selectHandler = null;
      }
   }
}
