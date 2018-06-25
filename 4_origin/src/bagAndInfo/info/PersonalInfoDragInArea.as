package bagAndInfo.info
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import petsBag.PetsBagManager;
   
   public class PersonalInfoDragInArea extends Sprite implements IAcceptDrag
   {
       
      
      private var temInfo:InventoryItemInfo;
      
      private var temEffect:DragEffect;
      
      public function PersonalInfoDragInArea()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,450,310);
         graphics.endFill();
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         var alert:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if((info.BindType == 1 || info.BindType == 2 || info.BindType == 3) && info.IsBinds == false && info.TemplateID != 11560 && info.TemplateID != 11561 && info.TemplateID != 11562)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
            alert.addEventListener("response",__onResponse);
            temInfo = info;
            temEffect = effect;
            return;
         }
         if(info)
         {
            effect.action = "none";
            if(info.Place < 31)
            {
               DragManager.acceptDrag(this);
            }
            else if(PlayerManager.Instance.Self.canEquip(info))
            {
               if(info.CategoryID == 50 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level)
               {
                  SocketManager.Instance.out.addPetEquip(info.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else if(info.CategoryID == 51 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level)
               {
                  SocketManager.Instance.out.addPetEquip(info.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else if(info.CategoryID == 52 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level)
               {
                  SocketManager.Instance.out.addPetEquip(info.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else
               {
                  if(info.CategoryID == 52 || info.CategoryID == 51 || info.CategoryID == 50)
                  {
                     DragManager.acceptDrag(this);
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petEquipLevelNo"));
                     return;
                  }
                  if(EquipType.isArmShell(info))
                  {
                     DragManager.acceptDrag(this,"none");
                     return;
                  }
                  SocketManager.Instance.out.sendMoveGoods(0,info.Place,0,PlayerManager.Instance.getDressEquipPlace(info),info.Count);
               }
               DragManager.acceptDrag(this,"move");
            }
            else
            {
               DragManager.acceptDrag(this);
            }
         }
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         var alert:BaseAlerFrame = BaseAlerFrame(evt.currentTarget);
         alert.removeEventListener("response",__onResponse);
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               alert.dispose();
               break;
            case 2:
            case 3:
            case 4:
               sendDefy();
         }
      }
      
      private function sendDefy() : void
      {
         if(temInfo)
         {
            temEffect.action = "none";
            if(temInfo.Place < 31)
            {
               DragManager.acceptDrag(this);
            }
            else if(PlayerManager.Instance.Self.canEquip(temInfo))
            {
               if(!PetsBagManager.instance().petModel.currentPetInfo)
               {
                  SocketManager.Instance.out.sendMoveGoods(0,temInfo.Place,0,PlayerManager.Instance.getDressEquipPlace(temInfo),temInfo.Count);
                  return;
               }
               if(temInfo.CategoryID == 50)
               {
                  SocketManager.Instance.out.addPetEquip(temInfo.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else if(temInfo.CategoryID == 51)
               {
                  SocketManager.Instance.out.addPetEquip(temInfo.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else if(temInfo.CategoryID == 52)
               {
                  SocketManager.Instance.out.addPetEquip(temInfo.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else
               {
                  SocketManager.Instance.out.sendMoveGoods(0,temInfo.Place,0,PlayerManager.Instance.getDressEquipPlace(temInfo),temInfo.Count);
               }
               DragManager.acceptDrag(this,"move");
            }
            else
            {
               DragManager.acceptDrag(this);
            }
         }
      }
   }
}
