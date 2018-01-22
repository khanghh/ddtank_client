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
      
      public function PersonalInfoCell(param1:int = 0, param2:ItemTemplateInfo = null, param3:Boolean = true)
      {
         super(param1,param2,param3);
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
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
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
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
      }
      
      protected function onClick(param1:InteractiveEvent) : void
      {
         dispatchEvent(new CellEvent("itemclick",this));
      }
      
      protected function onDoubleClick(param1:InteractiveEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(info)
         {
            dispatchEvent(new CellEvent("doubleclick",this));
         }
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            param1.action = "none";
            return;
         }
         var _loc4_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc4_)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               return;
            }
            if(_loc4_.Place < 29 && _loc4_.BagType != 1)
            {
               return;
            }
            if((_loc4_.BindType == 1 || _loc4_.BindType == 2 || _loc4_.BindType == 3) && _loc4_.IsBinds == false && _loc4_.TemplateID != 11560 && _loc4_.TemplateID != 11561 && _loc4_.TemplateID != 11562)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               _loc2_.addEventListener("response",__onBindResponse);
               temInfo = _loc4_;
               DragManager.acceptDrag(this,"none");
               return;
            }
            if(PlayerManager.Instance.Self.canEquip(_loc4_))
            {
               if(getCellIndex(_loc4_).indexOf(place) != -1)
               {
                  _loc3_ = place;
               }
               else
               {
                  _loc3_ = PlayerManager.Instance.getDressEquipPlace(_loc4_);
               }
               if(!PetsBagManager.instance().petModel.currentPetInfo)
               {
                  if(EquipType.isArmShell(_loc4_))
                  {
                     DragManager.acceptDrag(this,"none");
                     return;
                  }
                  SocketManager.Instance.out.sendMoveGoods(0,_loc4_.Place,0,_loc3_,_loc4_.Count);
                  param1.action = "none";
                  DragManager.acceptDrag(this,"move");
                  return;
               }
               if(_loc4_.CategoryID == 50 && int(_loc4_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && _loc4_.Place == 0)
               {
                  SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               else if(_loc4_.CategoryID == 51 && int(_loc4_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && _loc4_.Place == 1)
               {
                  SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,1);
               }
               else if(_loc4_.CategoryID == 52 && int(_loc4_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && _loc4_.Place == 2)
               {
                  SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,2);
               }
               else
               {
                  SocketManager.Instance.out.sendMoveGoods(0,_loc4_.Place,0,_loc3_,_loc4_.Count);
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
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            sendDefy();
         }
      }
      
      private function __onBindResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onBindResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            sendBindDefy();
         }
      }
      
      private function sendDefy() : void
      {
         var _loc1_:int = 0;
         if(PlayerManager.Instance.Self.canEquip(temInfo))
         {
            _loc1_ = PlayerManager.Instance.getDressEquipPlace(temInfo);
            SocketManager.Instance.out.sendMoveGoods(0,temInfo.Place,0,_loc1_);
         }
      }
      
      private function sendBindDefy() : void
      {
         if(PlayerManager.Instance.Self.canEquip(temInfo))
         {
            SocketManager.Instance.out.sendMoveGoods(0,temInfo.Place,0,_place,temInfo.Count);
         }
      }
      
      private function getCellIndex(param1:ItemTemplateInfo) : Array
      {
         if(EquipType.isWeddingRing(param1))
         {
            return [9,10,16];
         }
         var _loc2_:* = param1.CategoryID;
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
      
      override public function dragStop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            param1.action = "none";
            super.dragStop(param1);
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
