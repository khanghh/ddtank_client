package com.pickgliss.events
{
   import com.pickgliss.ui.controls.cell.IListCell;
   import flash.events.Event;
   
   public class ListItemEvent extends Event
   {
      
      public static const LIST_ITEM_CLICK:String = "listItemClick";
      
      public static const LIST_ITEM_DOUBLE_CLICK:String = "listItemDoubleclick";
      
      public static const LIST_ITEM_MOUSE_DOWN:String = "listItemMouseDown";
      
      public static const LIST_ITEM_MOUSE_UP:String = "listItemMouseUp";
      
      public static const LIST_ITEM_ROLL_OVER:String = "listItemRollOver";
      
      public static const LIST_ITEM_ROLL_OUT:String = "listItemRollOut";
       
      
      public var cell:IListCell;
      
      public var cellValue;
      
      public var index:int;
      
      public function ListItemEvent($cell:IListCell, $cellValue:*, type:String, $index:int)
      {
         cell = $cell;
         cellValue = $cellValue;
         index = $index;
         super(type);
      }
   }
}
