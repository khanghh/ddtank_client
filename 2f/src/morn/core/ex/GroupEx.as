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
      
      public function GroupEx(param1:String = null, param2:String = null){super();}
      
      public function addItem(param1:ISelect, param2:Boolean = true) : int{return 0;}
      
      public function delItem(param1:ISelect, param2:Boolean = true) : void{}
      
      public function initItems() : void{}
      
      protected function itemClick(param1:int) : void{}
      
      public function resetSelect() : void{}
      
      public function get selectedIndex() : int{return 0;}
      
      public function set selectedIndex(param1:int) : void{}
      
      public function set selectedIndexWithoutEvent(param1:int) : void{}
      
      protected function setSelect(param1:int, param2:Boolean) : void{}
      
      public function get selectHandler() : Handler{return null;}
      
      public function set selectHandler(param1:Handler) : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      public function get imageLabels() : String{return null;}
      
      public function set imageLabels(param1:String) : void{}
      
      protected function createItem(param1:String, param2:String) : DisplayObject{return null;}
      
      public function get direction() : String{return null;}
      
      public function set direction(param1:String) : void{}
      
      public function get space() : Number{return 0;}
      
      public function set space(param1:Number) : void{}
      
      protected function changeImageLabels() : void{}
      
      override public function commitMeasure() : void{}
      
      public function get items() : Vector.<ISelect>{return null;}
      
      public function get selection() : ISelect{return null;}
      
      public function set selection(param1:ISelect) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      override public function dispose() : void{}
   }
}
