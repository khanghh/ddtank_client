package bagAndInfo.cell
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.interfaces.IDragable;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class LinkedBagCell extends BagCell
   {
       
      
      protected var _bagCell:BagCell;
      
      public var DoubleClickEnabled:Boolean = true;
      
      public function LinkedBagCell(bg:Sprite)
      {
         super(0,null,true,bg);
      }
      
      override protected function init() : void
      {
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
         super.init();
      }
      
      private function __clickHandler(evt:InteractiveEvent) : void
      {
         if(_info && !locked && stage && allowDrag)
         {
            SoundManager.instance.play("008");
         }
         dragStart();
      }
      
      public function get bagCell() : BagCell
      {
         return _bagCell;
      }
      
      public function set bagCell(value:BagCell) : void
      {
         if(_bagCell)
         {
            _bagCell.removeEventListener("change",__changed);
            if(_bagCell.itemInfo && _bagCell.itemInfo.BagType == 0)
            {
               PlayerManager.Instance.Self.Bag.unlockItem(_bagCell.itemInfo);
            }
            else if(_bagCell.itemInfo)
            {
               PlayerManager.Instance.Self.PropBag.unlockItem(_bagCell.itemInfo);
            }
            _bagCell.locked = false;
            info = null;
         }
         _bagCell = value;
         if(_bagCell)
         {
            _bagCell.addEventListener("change",__changed);
            this.info = _bagCell.info;
            if(_info && _info.CategoryID == 74)
            {
               tipData = _bagCell.tipData;
               updateCellStar();
            }
         }
      }
      
      override public function get place() : int
      {
         if(_bagCell)
         {
            return _bagCell.itemInfo.Place;
         }
         return -1;
      }
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(!DoubleClickEnabled)
         {
            return;
         }
         if((evt.currentTarget as BagCell).info != null)
         {
            if((evt.currentTarget as BagCell).info != null)
            {
               dispatchEvent(new CellEvent("doubleclick",this,true));
            }
         }
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         if(_bagCell)
         {
            if(effect.action != "none" || effect.target)
            {
               _bagCell.dragStop(effect);
               _bagCell.removeEventListener("change",__changed);
               _bagCell = null;
               info = null;
            }
            else
            {
               locked = false;
            }
         }
      }
      
      private function __changed(event:Event) : void
      {
         this.info = _bagCell == null?null:_bagCell.info;
         if(_bagCell == null || _bagCell.info == null)
         {
            clearLinkCell();
         }
         else
         {
            _bagCell.locked = true;
         }
      }
      
      override public function getSource() : IDragable
      {
         return _bagCell;
      }
      
      public function clearLinkCell() : void
      {
         if(_bagCell)
         {
            _bagCell.removeEventListener("change",__changed);
            if(_bagCell.itemInfo && _bagCell.itemInfo.lock)
            {
               if(_bagCell.itemInfo && _bagCell.itemInfo.BagType == 0)
               {
                  PlayerManager.Instance.Self.Bag.unlockItem(_bagCell.itemInfo);
               }
               else
               {
                  PlayerManager.Instance.Self.PropBag.unlockItem(_bagCell.itemInfo);
               }
            }
            _bagCell.locked = false;
         }
         bagCell = null;
      }
      
      override public function set locked(b:Boolean) : void
      {
      }
      
      override public function dispose() : void
      {
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
         clearLinkCell();
         if(info is InventoryItemInfo)
         {
            info["lock"] = false;
         }
         super.dispose();
         bagCell = null;
      }
   }
}
