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
      
      public function SelectedButtonGroup(canUnSelect:Boolean = false, mutiSelectCount:int = 1)
      {
         super();
         _mutiSelectCount = mutiSelectCount;
         _canUnSelect = canUnSelect;
         _items = new Vector.<ISelectable>();
      }
      
      public function addSelectItem(item:ISelectable) : void
      {
         item.addEventListener("click",__onItemClicked);
         item.autoSelect = false;
         _items.push(item);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
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
      
      public function getSelectIndexByItem(item:ISelectable) : int
      {
         return _items.indexOf(item);
      }
      
      public function getItemByIndex($index:int) : ISelectable
      {
         return _items[$index];
      }
      
      public function removeItemByIndex(index:int) : void
      {
         if(index != -1)
         {
            _items[index].removeEventListener("click",__onItemClicked);
            ObjectUtils.disposeObject(_items[index]);
            _items.splice(index,1);
         }
      }
      
      public function removeSelectItem(item:ISelectable) : void
      {
         var index:int = _items.indexOf(item);
         removeItemByIndex(index);
      }
      
      public function get selectIndex() : int
      {
         return _items.indexOf(_lastSelectedButton);
      }
      
      public function set selectIndex(index:int) : void
      {
         if(index == -1)
         {
            _currentSelecetdIndex = index;
            var _loc6_:int = 0;
            var _loc5_:* = _items;
            for each(var item in _items)
            {
               item.selected = false;
            }
            return;
         }
         var changed:* = _currentSelecetdIndex != index;
         var target:ISelectable = _items[index];
         if(!target.selected)
         {
            if(_lastSelectedButton && selectedCount == _mutiSelectCount)
            {
               _lastSelectedButton.selected = false;
            }
            target.selected = true;
            _currentSelecetdIndex = index;
            _lastSelectedButton = target;
         }
         else if(_canUnSelect)
         {
            target.selected = false;
         }
         if(changed)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get selectedCount() : int
      {
         var i:int = 0;
         var result:int = 0;
         for(i = 0; i < _items.length; )
         {
            if(_items[i].selected)
            {
               result++;
            }
            i++;
         }
         return result;
      }
      
      public function set selectedCount(value:int) : void
      {
         _mutiSelectCount = value;
      }
      
      private function __onItemClicked(event:MouseEvent) : void
      {
         var target:ISelectable = event.currentTarget as ISelectable;
         selectIndex = _items.indexOf(target);
      }
   }
}
