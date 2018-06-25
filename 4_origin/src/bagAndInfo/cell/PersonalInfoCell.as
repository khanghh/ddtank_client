package bagAndInfo.cell
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gemstone.info.GemstoneInfo;
   import petsBag.PetsBagManager;
   
   public class PersonalInfoCell extends BagCell
   {
       
      
      public var gemstoneList:Vector.<GemstoneInfo>;
      
      private var _isGemstone:Boolean = false;
      
      private var _shineObject:MovieClip;
      
      public function PersonalInfoCell(index:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true)
      {
         super(index,info,showLoading);
         _bg.visible = false;
         _picPos = new Point(2,0);
         initEvents();
      }
      
      private function initEvents() : void
      {
         addEventListener("interactive_click",onClick);
         addEventListener("interactive_double_click",onDoubleClick);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("interactive_click",onClick);
         removeEventListener("interactive_double_click",onDoubleClick);
         DoubleClickManager.Instance.disableDoubleClick(this);
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         if(_tipData && _tipData is GoodTipInfo)
         {
            GoodTipInfo(_tipData).suitIcon = true;
         }
      }
      
      override public function dragStart() : void
      {
         if(_info && !locked && stage && allowDrag)
         {
            if(DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move"))
            {
               SoundManager.instance.play("008");
               locked = true;
            }
         }
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseClick(evt:MouseEvent) : void
      {
      }
      
      protected function onClick(evt:InteractiveEvent) : void
      {
         dispatchEvent(new CellEvent("itemclick",this));
      }
      
      protected function onDoubleClick(evt:InteractiveEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(info)
         {
            dispatchEvent(new CellEvent("doubleclick",this));
         }
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var alert:* = null;
         var toPlace:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            effect.action = "none";
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               return;
            }
            if(info.Place < 29 && info.BagType != 1)
            {
               return;
            }
            if((info.BindType == 1 || info.BindType == 2 || info.BindType == 3) && info.IsBinds == false && info.TemplateID != 11560 && info.TemplateID != 11561 && info.TemplateID != 11562)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               alert.addEventListener("response",__onBindResponse);
               temInfo = info;
               DragManager.acceptDrag(this,"none");
               return;
            }
            if(PlayerManager.Instance.Self.canEquip(info))
            {
               if(getCellIndex(info).indexOf(place) != -1)
               {
                  toPlace = place;
               }
               else
               {
                  toPlace = PlayerManager.Instance.getDressEquipPlace(info);
               }
               if(!PetsBagManager.instance().petModel.currentPetInfo)
               {
                  if(EquipType.isArmShell(info))
                  {
                     DragManager.acceptDrag(this,"none");
                     return;
                  }
                  SocketManager.Instance.out.sendMoveGoods(0,info.Place,0,toPlace,info.Count);
                  effect.action = "none";
                  DragManager.acceptDrag(this,"move");
                  return;
               }
               if(info.CategoryID == 50 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && info.Place == 0)
               {
                  SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else if(info.CategoryID == 51 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && info.Place == 1)
               {
                  SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,1);
               }
               else if(info.CategoryID == 52 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && info.Place == 2)
               {
                  SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,2);
               }
               else
               {
                  SocketManager.Instance.out.sendMoveGoods(0,info.Place,0,toPlace,info.Count);
               }
               DragManager.acceptDrag(this,"move");
            }
            else
            {
               DragManager.acceptDrag(this,"none");
            }
         }
      }
      
      override protected function createLoading() : void
      {
         super.createLoading();
         PositionUtils.setPos(_loadingasset,"ddt.personalInfocell.loadingPos");
      }
      
      override public function checkOverDate() : void
      {
         if(_bgOverDate)
         {
            _bgOverDate.visible = false;
         }
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            sendDefy();
         }
      }
      
      private function __onBindResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onBindResponse);
         alert.dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            sendBindDefy();
         }
      }
      
      private function sendDefy() : void
      {
         var toPlace:int = 0;
         if(PlayerManager.Instance.Self.canEquip(temInfo))
         {
            toPlace = PlayerManager.Instance.getDressEquipPlace(temInfo);
            SocketManager.Instance.out.sendMoveGoods(0,temInfo.Place,0,toPlace);
         }
      }
      
      private function sendBindDefy() : void
      {
         if(PlayerManager.Instance.Self.canEquip(temInfo))
         {
            SocketManager.Instance.out.sendMoveGoods(0,temInfo.Place,0,_place,temInfo.Count);
         }
      }
      
      private function getCellIndex(info:ItemTemplateInfo) : Array
      {
         if(EquipType.isWeddingRing(info))
         {
            return [9,10,16];
         }
         var _loc2_:* = info.CategoryID;
         if(1 !== _loc2_)
         {
            if(2 !== _loc2_)
            {
               if(3 !== _loc2_)
               {
                  if(4 !== _loc2_)
                  {
                     if(5 !== _loc2_)
                     {
                        if(6 !== _loc2_)
                        {
                           if(7 !== _loc2_)
                           {
                              if(8 !== _loc2_)
                              {
                                 if(28 !== _loc2_)
                                 {
                                    if(9 !== _loc2_)
                                    {
                                       if(29 !== _loc2_)
                                       {
                                          if(13 !== _loc2_)
                                          {
                                             if(14 !== _loc2_)
                                             {
                                                if(15 !== _loc2_)
                                                {
                                                   if(16 !== _loc2_)
                                                   {
                                                      if(17 !== _loc2_)
                                                      {
                                                         if(70 !== _loc2_)
                                                         {
                                                            return [-1];
                                                         }
                                                         return [18];
                                                      }
                                                      return [15];
                                                   }
                                                   return [14];
                                                }
                                                return [13];
                                             }
                                             return [12];
                                          }
                                          return [11];
                                       }
                                    }
                                    return [9,10];
                                 }
                              }
                              return [7,8];
                           }
                           return [6];
                        }
                        return [5];
                     }
                     return [4];
                  }
                  return [3];
               }
               return [2];
            }
            return [1];
         }
         return [0];
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            effect.action = "none";
            super.dragStop(effect);
         }
         locked = false;
         dispatchEvent(new CellEvent("dragStop",null,true));
      }
      
      public function shine() : void
      {
         if(_shineObject == null)
         {
            _shineObject = ComponentFactory.Instance.creatCustomObject("asset.core.playerInfoCellShine") as MovieClip;
         }
         addChild(_shineObject);
         _shineObject.gotoAndPlay(1);
      }
      
      public function stopShine() : void
      {
         if(_shineObject != null && this.contains(_shineObject))
         {
            removeChild(_shineObject);
         }
         if(_shineObject != null)
         {
            _shineObject.gotoAndStop(1);
         }
      }
      
      override public function updateCount() : void
      {
         if(_tbxCount)
         {
            if(_info && itemInfo && itemInfo.Count > 1)
            {
               _tbxCount.text = String(itemInfo.Count);
               _tbxCount.visible = true;
               addChild(_tbxCount);
            }
            else
            {
               _tbxCount.visible = false;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_shineObject != null)
         {
            ObjectUtils.disposeAllChildren(_shineObject);
         }
         _shineObject = null;
         super.dispose();
      }
   }
}
