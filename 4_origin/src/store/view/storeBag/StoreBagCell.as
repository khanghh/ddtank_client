package store.view.storeBag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import store.StrengthDataManager;
   import store.equipGhost.EquipGhostManager;
   import store.events.StoreDargEvent;
   
   public class StoreBagCell extends BagCell
   {
       
      
      private var _light:Boolean;
      
      private var _lockDisplayObject:DisplayObject;
      
      private var _cellLocked:Boolean = false;
      
      public var showLock:Boolean = false;
      
      public function StoreBagCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:Sprite = null)
      {
         super(index,info,showLoading,bg);
         _isShowIsUsedBitmap = true;
      }
      
      public function get lockDisplayObject() : DisplayObject
      {
         return _lockDisplayObject;
      }
      
      public function set lockDisplayObject(value:DisplayObject) : void
      {
         _lockDisplayObject = value;
      }
      
      public function get cellLocked() : Boolean
      {
         return _cellLocked;
      }
      
      public function set cellLocked(value:Boolean) : void
      {
         _cellLocked = value;
         if(_lockDisplayObject == null)
         {
            return;
         }
         if(value == true)
         {
            addChild(_lockDisplayObject);
         }
         else
         {
            _lockDisplayObject.parent && removeChild(_lockDisplayObject);
         }
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         var dragItemInfo:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(!checkBagType(dragItemInfo))
         {
            return;
         }
         if(StrengthDataManager.instance.autoFusion)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.fusion.donMoveGoods"));
            effect.action = "none";
            DragManager.acceptDrag(this);
            return;
         }
         var place:int = getPlace(dragItemInfo);
         if(EquipGhostManager.getInstance().isGhostEquip(dragItemInfo.ItemID))
         {
            place = EquipGhostManager.getInstance().getGhostEquipPlace();
            EquipGhostManager.getInstance().clearEquip();
         }
         SocketManager.Instance.out.sendMoveGoods(dragItemInfo.BagType,dragItemInfo.Place,bagType,place,1);
         effect.action = "none";
         DragManager.acceptDrag(this);
      }
      
      override public function dragStart() : void
      {
         if(_info && !locked && stage)
         {
            if(DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move",true,false,true))
            {
               locked = true;
               dispatchEvent(new StoreDargEvent(this.info,"startDarg",true));
            }
         }
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         var $info:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            effect.action = "none";
            super.dragStop(effect);
            BaglockedManager.Instance.show();
            dispatchEvent(new StoreDargEvent(this.info,"stopDarg",true));
            return;
         }
         if(effect.action == "move" && effect.target == null)
         {
            locked = false;
            $info = effect.data as InventoryItemInfo;
            sellItem($info);
         }
         else if(effect.action == "split" && effect.target == null)
         {
            locked = false;
         }
         else
         {
            super.dragStop(effect);
         }
         dispatchEvent(new StoreDargEvent(this.info,"stopDarg",true));
      }
      
      private function getPlace(dragItemInfo:InventoryItemInfo) : int
      {
         return -1;
      }
      
      private function checkBagType(info:InventoryItemInfo) : Boolean
      {
         if(info == null)
         {
            return false;
         }
         if(info.BagType == bagType)
         {
            return false;
         }
         if(info.CategoryID == 10 || info.CategoryID == 11 || info.CategoryID == 12)
         {
            if(bagType == 0)
            {
               return false;
            }
            return true;
         }
         if(bagType == 0)
         {
            return true;
         }
         return false;
      }
      
      public function set light(value:Boolean) : void
      {
         if(_light == value)
         {
            return;
         }
         _light = value;
         return;
         §§push(!!value?showEffect():hideEffect());
      }
      
      private function showEffect() : void
      {
         TweenMax.to(this,0.5,{
            "repeat":-1,
            "yoyo":true,
            "glowFilter":{
               "color":16777011,
               "alpha":1,
               "blurX":8,
               "blurY":8,
               "strength":3,
               "inner":true
            }
         });
      }
      
      private function hideEffect() : void
      {
         TweenMax.killChildTweensOf(this.parent,false);
         this.filters = null;
      }
      
      override public function dispose() : void
      {
         TweenMax.killChildTweensOf(this.parent,false);
         this.filters = null;
         super.dispose();
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         if(value == null)
         {
            cellLocked = false;
         }
         else if(showLock)
         {
            cellLocked = (value as InventoryItemInfo).cellLocked;
         }
      }
   }
}
