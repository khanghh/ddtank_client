package horse.amulet
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import horse.HorseAmuletManager;
   
   public class HorseAmuletCell extends BagCell
   {
       
      
      private var _isLock:Boolean;
      
      private var _lockIcon:Bitmap;
      
      public function HorseAmuletCell(param1:int, param2:ItemTemplateInfo = null, param3:DisplayObject = null)
      {
         super(param1,param2,false,param3,true);
      }
      
      public function Lock() : Boolean
      {
         if(!this.itemInfo)
         {
            return false;
         }
         if(!this.itemInfo.cellLocked)
         {
            if(_lockIcon)
            {
               _lockIcon.visible = true;
               setChildIndex(_lockIcon,numChildren - 1);
            }
            else
            {
               _lockIcon = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon1");
               var _loc1_:* = 0.7;
               _lockIcon.scaleY = _loc1_;
               _lockIcon.scaleX = _loc1_;
               this.addChild(_lockIcon);
               setChildIndex(_lockIcon,numChildren - 1);
            }
            this.itemInfo.cellLocked = true;
            SocketManager.Instance.out.sendAmuletLock(this.place);
         }
         else
         {
            if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
            SocketManager.Instance.out.sendAmuletLock(this.place);
            this.itemInfo.cellLocked = false;
         }
         return true;
      }
      
      public function smash() : void
      {
         if(!this.itemInfo)
         {
            return;
         }
         if(this.itemInfo.cellLocked)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.smashLockTips"));
            return;
         }
         var _loc2_:Boolean = HorseAmuletManager.instance.isHighQuality(this.itemInfo.TemplateID);
         var _loc1_:HorseAmuletSmashAlert = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashFrame");
         _loc1_.show([this.place],_loc2_);
         _loc1_.addEventListener("response",__onConfirmResponse);
      }
      
      private function __onConfirmResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:HorseAmuletSmashAlert = param1.currentTarget as HorseAmuletSmashAlert;
         _loc2_.removeEventListener("response",__onConfirmResponse);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            SocketManager.Instance.out.sendAmuletSmash(_loc2_.placeList);
         }
         ObjectUtils.disposeObject(_loc2_);
      }
      
      override public function dragStart() : void
      {
         SoundManager.instance.playButtonSound();
         if(info && PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         super.dragStart();
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 && param1.action == "move" && param1.data)
         {
            _loc4_ = param1.data as InventoryItemInfo;
            if(param1.source is HorseAmuletActivateCell)
            {
               SocketManager.Instance.out.sendAmuletMove((param1.source as HorseAmuletCell).place,19);
            }
            else if(param1.source is HorseAmuletEquipCell)
            {
               if(this.info)
               {
                  _loc2_ = HorseAmuletManager.instance.getHorseAmuletVo(_loc4_.TemplateID).ExtendType1;
                  _loc3_ = HorseAmuletManager.instance.getHorseAmuletVo(this.info.TemplateID).ExtendType1;
                  if(_loc2_ != _loc3_ && !HorseAmuletManager.instance.canEquipAmulet(this.info.TemplateID))
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.typeTips"));
                     DragManager.acceptDrag(null,"none");
                     return;
                  }
               }
               SocketManager.Instance.out.sendAmuletMove((param1.source as HorseAmuletEquipCell).place,this.place);
            }
            else if(param1.source is HorseAmuletCell)
            {
               SocketManager.Instance.out.sendAmuletMove((param1.source as HorseAmuletCell).place,this.place);
            }
            DragManager.acceptDrag(this,"move");
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
         DragManager.acceptDrag(this,"none");
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.target != null)
         {
            if(param1.action == "none")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
            }
            else if(param1.action == "move")
            {
            }
         }
         locked = false;
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(_info)
         {
            if(this.itemInfo.cellLocked)
            {
               if(_lockIcon)
               {
                  _lockIcon.visible = true;
                  setChildIndex(_lockIcon,numChildren - 1);
               }
               else
               {
                  _lockIcon = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon1");
                  var _loc2_:* = 0.7;
                  _lockIcon.scaleY = _loc2_;
                  _lockIcon.scaleX = _loc2_;
                  this.addChild(_lockIcon);
               }
            }
            else if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
         }
         else if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
