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
      
      public function ItemContainer(param1:Number, param2:Number = 1, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false, param6:String = "")
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         super(param2);
         vSpace = 4;
         hSpace = 6;
         list = [];
         _loc8_ = 0;
         while(_loc8_ < param1)
         {
            _loc7_ = new ItemCellView(_loc8_,null,false,param6);
            _loc7_.addEventListener("itemClick",__itemClick);
            _loc7_.addEventListener("itemOver",__itemOver);
            _loc7_.addEventListener("itemOut",__itemOut);
            _loc7_.addEventListener("itemMove",__itemMove);
            addChild(_loc7_);
            list.push(_loc7_);
            _loc8_++;
         }
         _clickAble = param5;
         _ordinal = param4;
      }
      
      public function setState(param1:Boolean, param2:Boolean) : void
      {
         _clickAble = param1;
         setItemState(param1,param2);
      }
      
      public function get clickAble() : Boolean
      {
         return _clickAble;
      }
      
      public function appendItem(param1:DisplayObject) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = list;
         for each(var _loc2_ in list)
         {
            if(_loc2_.item == null)
            {
               _loc2_.setItem(param1,false);
               return;
            }
         }
      }
      
      public function get blankItems() : Array
      {
         var _loc3_:Array = [];
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var _loc2_ in list)
         {
            if(_loc2_.item == null)
            {
               _loc3_.push(_loc1_);
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function mouseClickAt(param1:int) : void
      {
         list[param1].mouseClick();
      }
      
      private function __itemClick(param1:ItemEvent) : void
      {
         this.dispatchEvent(new ItemEvent("itemClick",param1.item,param1.index));
      }
      
      private function __itemOver(param1:ItemEvent) : void
      {
         this.dispatchEvent(new ItemEvent("itemOver",param1.item,param1.index));
      }
      
      private function __itemOut(param1:ItemEvent) : void
      {
         this.dispatchEvent(new ItemEvent("itemOut",param1.item,param1.index));
      }
      
      private function __itemMove(param1:ItemEvent) : void
      {
         this.dispatchEvent(new ItemEvent("itemMove",param1.item,param1.index));
      }
      
      public function appendItemAt(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = 0;
         if(_ordinal)
         {
            _loc3_ = list[list.length - 1] as ItemCellView;
            _loc4_ = param2;
            while(_loc4_ < list.length - 1)
            {
               list[_loc4_ + 1] = list[_loc4_];
               _loc4_++;
            }
            list[param2] = _loc3_;
            _loc3_.setItem(param1,false);
         }
         else
         {
            _loc3_ = list[param2];
            _loc3_.setItem(param1,false);
         }
      }
      
      public function removeItem(param1:DisplayObject) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < list.length)
         {
            _loc2_ = list[_loc3_];
            if(_loc2_.item == param1)
            {
               removeChild(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function removeItemAt(param1:int) : void
      {
         var _loc2_:ItemCellView = list[param1];
         _loc2_.setItem(null,false);
         if(_ordinal)
         {
            list.splice(param1,1);
            removeChild(_loc2_);
            list.push(_loc2_);
         }
      }
      
      public function clear() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = list;
         for each(var _loc1_ in list)
         {
            _loc1_.setItem(null,false);
         }
      }
      
      public function setItemClickAt(param1:int, param2:Boolean, param3:Boolean) : void
      {
         list[param1].setClick(param2,param3,false);
      }
      
      public function disableCellIndex(param1:int) : void
      {
         list[param1].disable();
      }
      
      public function disableSelfProp(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var _loc2_ in list)
         {
            if(_loc2_.item)
            {
               _loc3_ = PropItemView(_loc2_.item).info;
               if(_loc3_.Template.TemplateID == 10016 && (param1 == 1 || param1 == 3))
               {
                  _loc2_.disable();
               }
               else if(_loc3_.Template.TemplateID == 10003 && (param1 == 2 || param1 == 3))
               {
                  _loc2_.disable();
               }
            }
         }
      }
      
      public function disableCellArr() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = list;
         for each(var _loc1_ in list)
         {
            _loc1_.disable();
         }
      }
      
      public function setNoClickAt(param1:int) : void
      {
         list[param1].setNoEnergyAsset();
      }
      
      private function setItemState(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:* = list;
         for each(var _loc4_ in list)
         {
            _loc3_ = false;
            if(PropItemView(_loc4_.item) != null)
            {
               _loc3_ = PropItemView(_loc4_.item).isExist;
            }
            _loc4_.setClick(param1,param2,_loc3_);
         }
      }
      
      public function setClickByEnergy(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var _loc2_ in list)
         {
            if(_loc2_.item)
            {
               _loc3_ = PropItemView(_loc2_.item).info;
               if(_loc3_)
               {
                  if(param1 < _loc3_.needEnergy)
                  {
                     _loc2_.setClick(true,true,PropItemView(_loc2_.item).isExist);
                  }
               }
            }
         }
      }
      
      public function setVisible(param1:int, param2:Boolean) : void
      {
         list[param1].visible = param2;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         super.dispose();
         while(list.length > 0)
         {
            _loc1_ = list.shift() as ItemCellView;
            _loc1_.dispose();
         }
         list = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
