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
      
      public function StoreBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Sprite = null)
      {
         super(param1,param2,param3,param4);
         _isShowIsUsedBitmap = true;
      }
      
      public function get lockDisplayObject() : DisplayObject
      {
         return _lockDisplayObject;
      }
      
      public function set lockDisplayObject(param1:DisplayObject) : void
      {
         _lockDisplayObject = param1;
      }
      
      public function get cellLocked() : Boolean
      {
         return _cellLocked;
      }
      
      public function set cellLocked(param1:Boolean) : void
      {
         _cellLocked = param1;
         if(_lockDisplayObject == null)
         {
            return;
         }
         if(param1 == true)
         {
            addChild(_lockDisplayObject);
         }
         else
         {
            _lockDisplayObject.parent && removeChild(_lockDisplayObject);
         }
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(!checkBagType(_loc2_))
         {
            return;
         }
         if(StrengthDataManager.instance.autoFusion)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.fusion.donMoveGoods"));
            param1.action = "none";
            DragManager.acceptDrag(this);
            return;
         }
         var _loc3_:int = getPlace(_loc2_);
         if(EquipGhostManager.getInstance().isGhostEquip(_loc2_.ItemID))
         {
            _loc3_ = EquipGhostManager.getInstance().getGhostEquipPlace();
            EquipGhostManager.getInstance().clearEquip();
         }
         SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,bagType,_loc3_,1);
         param1.action = "none";
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
      
      override public function dragStop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            param1.action = "none";
            super.dragStop(param1);
            BaglockedManager.Instance.show();
            dispatchEvent(new StoreDargEvent(this.info,"stopDarg",true));
            return;
         }
         if(param1.action == "move" && param1.target == null)
         {
            locked = false;
            _loc2_ = param1.data as InventoryItemInfo;
            sellItem(_loc2_);
         }
         else if(param1.action == "split" && param1.target == null)
         {
            locked = false;
         }
         else
         {
            super.dragStop(param1);
         }
         dispatchEvent(new StoreDargEvent(this.info,"stopDarg",true));
      }
      
      private function getPlace(param1:InventoryItemInfo) : int
      {
         return -1;
      }
      
      private function checkBagType(param1:InventoryItemInfo) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1.BagType == bagType)
         {
            return false;
         }
         if(param1.CategoryID == 10 || param1.CategoryID == 11 || param1.CategoryID == 12)
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
      
      public function set light(param1:Boolean) : void
      {
         if(_light == param1)
         {
            return;
         }
         _light = param1;
         return;
         §§push(!!param1?showEffect():hideEffect());
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
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(param1 == null)
         {
            cellLocked = false;
         }
         else if(showLock)
         {
            cellLocked = (param1 as InventoryItemInfo).cellLocked;
         }
      }
   }
}
