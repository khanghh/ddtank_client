package horse.amulet
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
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
      
      private var _alertFrame:BaseAlerFrame;
      
      private var _markPlace:int;
      
      public function HorseAmuletCell(index:int, info:ItemTemplateInfo = null, bg:DisplayObject = null)
      {
         super(index,info,false,bg,true);
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
         var isQuality:Boolean = HorseAmuletManager.instance.isHighQuality(this.itemInfo.TemplateID);
         var frame:HorseAmuletSmashAlert = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashFrame");
         frame.show([this.place],isQuality);
         frame.addEventListener("response",__onConfirmResponse);
      }
      
      private function __onConfirmResponse(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var alertInfo:HorseAmuletSmashAlert = event.currentTarget as HorseAmuletSmashAlert;
         alertInfo.removeEventListener("response",__onConfirmResponse);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            SocketManager.Instance.out.sendAmuletSmash(alertInfo.placeList);
         }
         ObjectUtils.disposeObject(alertInfo);
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
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var info:* = null;
         var type1:int = 0;
         var type2:int = 0;
         if(effect && effect.action == "move" && effect.data)
         {
            info = effect.data as InventoryItemInfo;
            if(effect.source is HorseAmuletActivateCell)
            {
               if(HorseAmuletManager.instance.isActivate)
               {
                  _markPlace = (effect.source as HorseAmuletCell).place;
                  _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.horseAmulet.replaceTips"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true);
                  _alertFrame.addEventListener("response",__onClickFrame);
               }
               else
               {
                  SocketManager.Instance.out.sendAmuletMove((effect.source as HorseAmuletCell).place,19);
               }
            }
            else if(effect.source is HorseAmuletEquipCell)
            {
               if(this.info)
               {
                  type1 = HorseAmuletManager.instance.getHorseAmuletVo(info.TemplateID).ExtendType1;
                  type2 = HorseAmuletManager.instance.getHorseAmuletVo(this.info.TemplateID).ExtendType1;
                  if(type1 != type2 && !HorseAmuletManager.instance.canEquipAmulet(this.info.TemplateID))
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.typeTips"));
                     DragManager.acceptDrag(null,"none");
                     return;
                  }
               }
               SocketManager.Instance.out.sendAmuletMove((effect.source as HorseAmuletEquipCell).place,this.place);
            }
            else if(effect.source is HorseAmuletCell)
            {
               SocketManager.Instance.out.sendAmuletMove((effect.source as HorseAmuletCell).place,this.place);
            }
            DragManager.acceptDrag(this,"move");
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
         DragManager.acceptDrag(this,"none");
      }
      
      private function __onClickFrame(e:FrameEvent) : void
      {
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            SocketManager.Instance.out.sendAmuletMove(_markPlace,19);
         }
         disposeAlertFrame();
      }
      
      private function disposeAlertFrame() : void
      {
         if(_alertFrame)
         {
            _alertFrame.removeEventListener("response",__onClickFrame);
            ObjectUtils.disposeObject(_alertFrame);
            _alertFrame = null;
         }
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         SoundManager.instance.playButtonSound();
         if(effect.target != null)
         {
            if(effect.action == "none")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
            }
            else if(effect.action == "move")
            {
            }
         }
         locked = false;
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
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
         disposeAlertFrame();
         super.dispose();
      }
   }
}
