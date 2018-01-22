package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class SelectedButtonGroup extends EventDispatcher implements Disposeable
   {
       
      
      private var _canUnSelect:Boolean;
      
      private var _currentSelecetdIndex:int = -1;
      
      private var _items:Vector.<ISelectable>;
      
      private var _lastSelectedButton:ISelectable;
      
      private var _mutiSelectCount:int;
      
      public function SelectedButtonGroup(param1:Boolean = false, param2:int = 1)
      {
         super();
         _mutiSelectCount = param2;
         _canUnSelect = param1;
         _items = new Vector.<ISelectable>();
      }
      
      public function addSelectItem(param1:ISelectable) : void
      {
         param1.addEventListener("click",__onItemClicked);
         param1.autoSelect = false;
         _items.push(param1);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            removeItemByIndex(0);
         }
         _lastSelectedButton = null;
         _items = null;
      }
      
      public function length() : int
      {
         return _items.length;
      }
      
      public function getSelectIndexByItem(param1:ISelectable) : int
      {
         return _items.indexOf(param1);
      }
      
      public function getItemByIndex(param1:int) : ISelectable
      {
         return _items[param1];
      }
      
      public function removeItemByIndex(param1:int) : void
      {
         if(param1 != -1)
         {
            _items[param1].removeEventListener("click",__onItemClicked);
            ObjectUtils.disposeObject(_items[param1]);
            _items.splice(param1,1);
         }
      }
      
      public function removeSelectItem(param1:ISelectable) : void
      {
         var _loc2_:int = _items.indexOf(param1);
         removeItemByIndex(_loc2_);
      }
      
      public function get selectIndex() : int
      {
         return _items.indexOf(_lastSelectedButton);
      }
      
      public function set selectIndex(param1:int) : void
      {
         if(param1 == -1)
         {
            _currentSelecetdIndex = param1;
            var _loc6_:int = 0;
            var _loc5_:* = _items;
            for each(var _loc2_ in _items)
            {
               _loc2_.selected = false;
            }
            return;
         }
         var _loc4_:* = _currentSelecetdIndex != param1;
         var _loc3_:ISelectable = _items[param1];
         if(!_loc3_.selected)
         {
            if(_lastSelectedButton && selectedCount == _mutiSelectCount)
            {
               _lastSelectedButton.selected = false;
            }
            _loc3_.selected = true;
            _currentSelecetdIndex = param1;
            _lastSelectedButton = _loc3_;
         }
         else if(_canUnSelect)
         {
            _loc3_.selected = false;
         }
         if(_loc4_)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get selectedCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            if(_items[_loc2_].selected)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function set selectedCount(param1:int) : void
      {
         _mutiSelectCount = param1;
      }
      
      private function __onItemClicked(param1:MouseEvent) : void
      {
         var _loc2_:ISelectable = param1.currentTarget as ISelectable;
         selectIndex = _items.indexOf(_loc2_);
      }
   }
}
