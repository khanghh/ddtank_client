package morn.core.ex
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
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
      
      public function GroupEx(param1:String = null, param2:String = null)
      {
         super();
         this.skin = param2;
         this.imageLabels = param1;
      }
      
      public function addItem(param1:ISelect, param2:Boolean = true) : int
      {
         var _loc5_:DisplayObject = null;
         var _loc3_:DisplayObject = param1 as DisplayObject;
         var _loc4_:int = this._items.length;
         _loc3_.name = "item" + _loc4_;
         addChild(_loc3_);
         this.initItems();
         if(param2 && _loc4_ > 0)
         {
            _loc5_ = this._items[_loc4_ - 1] as DisplayObject;
            if(this._direction == "horizontal")
            {
               _loc3_.x = _loc5_.x + _loc5_.width + this._space;
            }
            else
            {
               _loc3_.y = _loc5_.y + _loc5_.height + this._space;
            }
         }
         return _loc4_;
      }
      
      public function delItem(param1:ISelect, param2:Boolean = true) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:DisplayObject = null;
         var _loc3_:int = this._items.indexOf(param1);
         if(_loc3_ != -1)
         {
            _loc4_ = param1 as DisplayObject;
            removeChild(_loc4_);
            _loc5_ = _loc3_ + 1;
            _loc6_ = this._items.length;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = this._items[_loc5_] as DisplayObject;
               _loc7_.name = "item" + (_loc5_ - 1);
               if(param2)
               {
                  if(this._direction == "horizontal")
                  {
                     _loc7_.x = _loc7_.x - (_loc4_.width + this._space);
                  }
                  else
                  {
                     _loc7_.y = _loc7_.y - (_loc4_.height + this._space);
                  }
               }
               _loc5_++;
            }
            this.initItems();
            if(this._selectedIndex > -1)
            {
               this.selectedIndex = this._selectedIndex < this._items.length?int(this._selectedIndex):int(this._selectedIndex - 1);
            }
         }
      }
      
      public function initItems() : void
      {
         var _loc2_:ISelect = null;
         this._items = new Vector.<ISelect>();
         var _loc1_:int = 0;
         while(_loc1_ < int.MAX_VALUE)
         {
            _loc2_ = getChildByName("item" + _loc1_) as ISelect;
            if(_loc2_ != null)
            {
               this._items.push(_loc2_);
               _loc2_.selected = _loc1_ == this._selectedIndex;
               _loc2_.clickHandler = new Handler(this.itemClick,[_loc1_]);
               _loc1_++;
               continue;
            }
            break;
         }
      }
      
      protected function itemClick(param1:int) : void
      {
         this.selectedIndex = param1;
      }
      
      public function resetSelect() : void
      {
         this.setSelect(this._selectedIndex,false);
         this._selectedIndex = -1;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(this._selectedIndex != param1)
         {
            this.setSelect(this._selectedIndex,false);
            this._selectedIndex = param1;
            this.setSelect(this._selectedIndex,true);
            sendEvent(Event.CHANGE);
            sendEvent(Event.SELECT);
            if(this._selectHandler != null)
            {
               this._selectHandler.executeWith([this._selectedIndex]);
            }
         }
      }
      
      public function set selectedIndexWithoutEvent(param1:int) : void
      {
         if(this._selectedIndex != param1)
         {
            this.setSelect(this._selectedIndex,false);
            this._selectedIndex = param1;
            this.setSelect(this._selectedIndex,true);
            sendEvent(Event.CHANGE);
         }
      }
      
      protected function setSelect(param1:int, param2:Boolean) : void
      {
         if(this._items && param1 > -1 && param1 < this._items.length)
         {
            this._items[param1].selected = param2;
         }
      }
      
      public function get selectHandler() : Handler
      {
         return this._selectHandler;
      }
      
      public function set selectHandler(param1:Handler) : void
      {
         this._selectHandler = param1;
      }
      
      public function get skin() : String
      {
         return this._skin;
      }
      
      public function set skin(param1:String) : void
      {
         if(this._skin != param1)
         {
            this._skin = param1;
            callLater(this.changeImageLabels);
         }
      }
      
      public function get imageLabels() : String
      {
         return this._imageLabels;
      }
      
      public function set imageLabels(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         if(this._imageLabels != param1)
         {
            this._imageLabels = param1;
            removeAllChild();
            callLater(this.changeImageLabels);
            if(Boolean(this.imageLabels))
            {
               _loc2_ = this._imageLabels.split(",");
               _loc3_ = this._skin.split(",");
               _loc4_ = 0;
               _loc5_ = _loc2_.length;
               while(_loc4_ < _loc5_)
               {
                  _loc6_ = this.createItem(_loc3_.length <= _loc4_?this._skin:_loc3_[_loc4_],_loc2_[_loc4_]);
                  _loc6_.name = "item" + _loc4_;
                  addChild(_loc6_);
                  _loc4_++;
               }
            }
            this.initItems();
         }
      }
      
      protected function createItem(param1:String, param2:String) : DisplayObject
      {
         return null;
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function set direction(param1:String) : void
      {
         this._direction = param1;
         callLater(this.changeImageLabels);
      }
      
      public function get space() : Number
      {
         return this._space;
      }
      
      public function set space(param1:Number) : void
      {
         this._space = param1;
         callLater(this.changeImageLabels);
      }
      
      protected function changeImageLabels() : void
      {
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(this.changeImageLabels);
      }
      
      public function get items() : Vector.<ISelect>
      {
         return this._items;
      }
      
      public function get selection() : ISelect
      {
         return this._selectedIndex > -1 && this._selectedIndex < this._items.length?this._items[this._selectedIndex]:null;
      }
      
      public function set selection(param1:ISelect) : void
      {
         this.selectedIndex = this._items.indexOf(param1);
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is int || param1 is String)
         {
            this.selectedIndex = int(param1);
         }
         else if(param1 is Array)
         {
            this.imageLabels = (param1 as Array).join(",");
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         while(this._items && this._items.length)
         {
            ObjectUtils.disposeObject(this._items.pop());
         }
         this._items = null;
         this._selectHandler = null;
      }
   }
}
