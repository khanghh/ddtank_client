package gameCommon.view.propContainer
{
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import ddt.data.PropInfo;
   import ddt.events.ItemEvent;
   import ddt.view.PropItemView;
   import flash.display.DisplayObject;
   import gameCommon.view.ItemCellView;
   
   [Event(name="itemClick",type="ddt.events.ItemEvent")]
   [Event(name="itemOver",type="ddt.events.ItemEvent")]
   [Event(name="itemOut",type="ddt.events.ItemEvent")]
   [Event(name="itemMove",type="ddt.events.ItemEvent")]
   public class ItemContainer extends SimpleTileList
   {
      
      public static var USE_THREE:String = "use_threeSkill";
      
      public static var PLANE:int = 1;
      
      public static var THREE_SKILL:int = 2;
      
      public static var BOTH:int = 3;
       
      
      private var list:Array;
      
      private var _ordinal:Boolean;
      
      private var _clickAble:Boolean;
      
      public function ItemContainer(param1:Number, param2:Number = 1, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false, param6:String = ""){super(null);}
      
      public function setState(param1:Boolean, param2:Boolean) : void{}
      
      public function get clickAble() : Boolean{return false;}
      
      public function appendItem(param1:DisplayObject) : void{}
      
      public function get blankItems() : Array{return null;}
      
      public function mouseClickAt(param1:int) : void{}
      
      private function __itemClick(param1:ItemEvent) : void{}
      
      private function __itemOver(param1:ItemEvent) : void{}
      
      private function __itemOut(param1:ItemEvent) : void{}
      
      private function __itemMove(param1:ItemEvent) : void{}
      
      public function appendItemAt(param1:DisplayObject, param2:int) : void{}
      
      public function removeItem(param1:DisplayObject) : void{}
      
      public function removeItemAt(param1:int) : void{}
      
      public function clear() : void{}
      
      public function setItemClickAt(param1:int, param2:Boolean, param3:Boolean) : void{}
      
      public function disableCellIndex(param1:int) : void{}
      
      public function disableSelfProp(param1:int) : void{}
      
      public function disableCellArr() : void{}
      
      public function setNoClickAt(param1:int) : void{}
      
      private function setItemState(param1:Boolean, param2:Boolean) : void{}
      
      public function setClickByEnergy(param1:int) : void{}
      
      public function setVisible(param1:int, param2:Boolean) : void{}
      
      override public function dispose() : void{}
   }
}
