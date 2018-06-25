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
      
      public function ItemContainer(count:Number, column:Number = 1, bgvisible:Boolean = true, ordinal:Boolean = false, clickable:Boolean = false, EffectType:String = "")
      {
         var i:int = 0;
         var item:* = null;
         super(column);
         vSpace = 4;
         hSpace = 6;
         list = [];
         for(i = 0; i < count; )
         {
            item = new ItemCellView(i,null,false,EffectType);
            item.addEventListener("itemClick",__itemClick);
            item.addEventListener("itemOver",__itemOver);
            item.addEventListener("itemOut",__itemOut);
            item.addEventListener("itemMove",__itemMove);
            addChild(item);
            list.push(item);
            i++;
         }
         _clickAble = clickable;
         _ordinal = ordinal;
      }
      
      public function setState(clickable:Boolean, isGray:Boolean) : void
      {
         _clickAble = clickable;
         setItemState(clickable,isGray);
      }
      
      public function get clickAble() : Boolean
      {
         return _clickAble;
      }
      
      public function appendItem(item:DisplayObject) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = list;
         for each(var cell in list)
         {
            if(cell.item == null)
            {
               cell.setItem(item,false);
               return;
            }
         }
      }
      
      public function get blankItems() : Array
      {
         var ar:Array = [];
         var index:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var cell in list)
         {
            if(cell.item == null)
            {
               ar.push(index);
            }
            index++;
         }
         return ar;
      }
      
      public function mouseClickAt(index:int) : void
      {
         list[index].mouseClick();
      }
      
      private function __itemClick(event:ItemEvent) : void
      {
         this.dispatchEvent(new ItemEvent("itemClick",event.item,event.index));
      }
      
      private function __itemOver(event:ItemEvent) : void
      {
         this.dispatchEvent(new ItemEvent("itemOver",event.item,event.index));
      }
      
      private function __itemOut(event:ItemEvent) : void
      {
         this.dispatchEvent(new ItemEvent("itemOut",event.item,event.index));
      }
      
      private function __itemMove(event:ItemEvent) : void
      {
         this.dispatchEvent(new ItemEvent("itemMove",event.item,event.index));
      }
      
      public function appendItemAt(item:DisplayObject, index:int) : void
      {
         var cell:* = null;
         var i:* = 0;
         if(_ordinal)
         {
            cell = list[list.length - 1] as ItemCellView;
            for(i = index; i < list.length - 1; )
            {
               list[i + 1] = list[i];
               i++;
            }
            list[index] = cell;
            cell.setItem(item,false);
         }
         else
         {
            cell = list[index];
            cell.setItem(item,false);
         }
      }
      
      public function removeItem(item:DisplayObject) : void
      {
         var i:int = 0;
         var cell:* = null;
         for(i = 0; i < list.length; )
         {
            cell = list[i];
            if(cell.item == item)
            {
               removeChild(cell);
            }
            i++;
         }
      }
      
      public function removeItemAt(index:int) : void
      {
         var cell:ItemCellView = list[index];
         cell.setItem(null,false);
         if(_ordinal)
         {
            list.splice(index,1);
            removeChild(cell);
            list.push(cell);
         }
      }
      
      public function clear() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = list;
         for each(var cell in list)
         {
            cell.setItem(null,false);
         }
      }
      
      public function setItemClickAt(index:int, isClick:Boolean, isGray:Boolean) : void
      {
         list[index].setClick(isClick,isGray,false);
      }
      
      public function disableCellIndex(index:int) : void
      {
         list[index].disable();
      }
      
      public function disableSelfProp(value:int) : void
      {
         var info:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var cell in list)
         {
            if(cell.item)
            {
               info = PropItemView(cell.item).info;
               if(info.Template.TemplateID == 10016 && (value == 1 || value == 3))
               {
                  cell.disable();
               }
               else if(info.Template.TemplateID == 10003 && (value == 2 || value == 3))
               {
                  cell.disable();
               }
            }
         }
      }
      
      public function disableCellArr() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = list;
         for each(var cell in list)
         {
            cell.disable();
         }
      }
      
      public function setNoClickAt(index:int) : void
      {
         list[index].setNoEnergyAsset();
      }
      
      private function setItemState(isClick:Boolean, isGray:Boolean) : void
      {
         var isExist:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:* = list;
         for each(var cell in list)
         {
            isExist = false;
            if(PropItemView(cell.item) != null)
            {
               isExist = PropItemView(cell.item).isExist;
            }
            cell.setClick(isClick,isGray,isExist);
         }
      }
      
      public function setClickByEnergy(energy:int) : void
      {
         var info:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var cell in list)
         {
            if(cell.item)
            {
               info = PropItemView(cell.item).info;
               if(info)
               {
                  if(energy < info.needEnergy)
                  {
                     cell.setClick(true,true,PropItemView(cell.item).isExist);
                  }
               }
            }
         }
      }
      
      public function setVisible(index:int, v:Boolean) : void
      {
         list[index].visible = v;
      }
      
      override public function dispose() : void
      {
         var item:* = null;
         super.dispose();
         while(list.length > 0)
         {
            item = list.shift() as ItemCellView;
            item.dispose();
         }
         list = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
