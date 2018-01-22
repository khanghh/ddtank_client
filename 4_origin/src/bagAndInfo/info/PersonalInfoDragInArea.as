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
      
      public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         var _loc3_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if((_loc3_.BindType == 1 || _loc3_.BindType == 2 || _loc3_.BindType == 3) && _loc3_.IsBinds == false && _loc3_.TemplateID != 11560 && _loc3_.TemplateID != 11561 && _loc3_.TemplateID != 11562)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
            _loc2_.addEventListener("response",__onResponse);
            temInfo = _loc3_;
            temEffect = param1;
            return;
         }
         if(_loc3_)
         {
            param1.action = "none";
            if(_loc3_.Place < 31)
            {
               DragManager.acceptDrag(this);
            }
            else if(PlayerManager.Instance.Self.canEquip(_loc3_))
            {
               if(_loc3_.CategoryID == 50 && int(_loc3_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level)
               {
                  SocketManager.Instance.out.addPetEquip(_loc3_.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else if(_loc3_.CategoryID == 51 && int(_loc3_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level)
               {
                  SocketManager.Instance.out.addPetEquip(_loc3_.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else if(_loc3_.CategoryID == 52 && int(_loc3_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level)
               {
                  SocketManager.Instance.out.addPetEquip(_loc3_.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else
               {
                  if(_loc3_.CategoryID == 52 || _loc3_.CategoryID == 51 || _loc3_.CategoryID == 50)
                  {
                     DragManager.acceptDrag(this);
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petEquipLevelNo"));
                     return;
                  }
                  if(EquipType.isArmShell(_loc3_))
                  {
                     DragManager.acceptDrag(this,"none");
                     return;
                  }
                  SocketManager.Instance.out.sendMoveGoods(0,_loc3_.Place,0,PlayerManager.Instance.getDressEquipPlace(_loc3_),_loc3_.Count);
               }
               DragManager.acceptDrag(this,"move");
            }
            else
            {
               DragManager.acceptDrag(this);
            }
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",__onResponse);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _loc2_.dispose();
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
