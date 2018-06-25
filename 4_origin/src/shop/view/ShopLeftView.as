package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import shop.ShopController;
   import shop.ShopEvent;
   import shop.ShopModel;
   
   public class ShopLeftView extends Sprite implements Disposeable
   {
      
      public static const SHOW_CART:uint = 1;
      
      public static const SHOW_COLOR:uint = 1;
      
      public static const SHOW_DRESS:uint = 0;
      
      public static const SHOW_WEALTH:uint = 0;
      
      public static const COLOR:uint = 1;
      
      public static const SKIN:uint = 2;
      
      private static const MALE:uint = 1;
      
      private static const FEMALE:uint = 2;
       
      
      private var _controller:ShopController;
      
      private var _model:ShopModel;
      
      private var prop:ShopLeftViewPropCollection;
      
      private var _isUsed:Boolean = false;
      
      private var latestRandom:int = 0;
      
      private var _isVisible:Boolean = false;
      
      public function ShopLeftView()
      {
         super();
         prop = new ShopLeftViewPropCollection();
         prop.setup();
         prop.addChildrenTo(this);
      }
      
      public function adjustBottomView(idx:uint) : void
      {
         prop.middlePanelBg.setFrame(idx + 1);
         prop.panelBtnGroup.selectIndex = idx;
         if(idx == 0)
         {
            _isVisible = false;
            prop.purchaseView.visible = true;
            prop.colorEditor.visible = false;
            var _loc4_:int = 0;
            var _loc3_:* = prop.playerCells;
            for each(var temp in prop.playerCells)
            {
               temp.hideLight();
            }
         }
         if(idx == 1)
         {
            _isVisible = true;
            prop.purchaseView.visible = false;
            prop.colorEditor.visible = true;
            __updateColorEditor();
            showShine();
         }
      }
      
      public function getColorEditorVisble() : Boolean
      {
         return prop.colorEditor.visible;
      }
      
      public function adjustUpperView(idx:uint) : void
      {
         if(idx == 0)
         {
            if(prop.middlePanelBg.getFrame == 0 + 1)
            {
               prop.purchaseView.visible = true;
            }
            prop.dressView.visible = true;
            prop.cartScroll.visible = false;
         }
         if(idx == 1)
         {
            ObjectUtils.modifyVisibility(true,prop.cartScroll);
            ObjectUtils.modifyVisibility(false,prop.dressView);
            adjustBottomView(0);
         }
      }
      
      public function refreshCharater() : void
      {
         if(!prop.maleCharacter)
         {
            prop.maleCharacter = CharactoryFactory.createCharacter(_model.manModelInfo,"room") as RoomCharacter;
            prop.maleCharacter.show(false,-1);
            prop.maleCharacter.showGun = false;
            PositionUtils.setPos(prop.maleCharacter,"ddtshop.PlayerCharacterPos");
            prop.dressView.addChild(prop.maleCharacter);
         }
         if(!prop.femaleCharacter)
         {
            prop.femaleCharacter = CharactoryFactory.createCharacter(_model.womanModelInfo,"room") as RoomCharacter;
            prop.femaleCharacter.show(false,-1);
            prop.femaleCharacter.showGun = false;
            PositionUtils.setPos(prop.femaleCharacter,"ddtshop.PlayerCharacterPos");
            prop.dressView.addChild(prop.femaleCharacter);
         }
         __fittingSexChanged();
      }
      
      public function setup(controller:ShopController, model:ShopModel) : void
      {
         _controller = controller;
         _model = model;
         initEvent();
         refreshCharater();
      }
      
      private function __addCarEquip(evt:ShopEvent) : void
      {
         addCarEquip(evt.param as ShopCarItemInfo);
      }
      
      private function __clearClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _controller.revertToDefault();
      }
      
      private function __clearLastClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.removeLatestItem();
         clearHighLight();
         __fittingSexChanged();
      }
      
      private function clearHighLight() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = prop.playerCells;
         for each(var temp in prop.playerCells)
         {
            temp.hideLight();
         }
      }
      
      private function __conditionChange(evt:Event) : void
      {
         _controller.updateCost();
      }
      
      private function __deleteItem(evt:Event) : void
      {
         var item:ShopCartItem = evt.currentTarget as ShopCartItem;
         _controller.removeFromCar(item.shopItemInfo as ShopCarItemInfo);
         if(prop.cartList.contains(item))
         {
            prop.cartList.removeChild(item);
         }
      }
      
      private function __addTempEquip(evt:ShopEvent) : void
      {
         var place:int = 0;
         var itemId:int = 0;
         var info:ShopCarItemInfo = evt.param as ShopCarItemInfo;
         if(EquipType.isProp(info.TemplateInfo))
         {
            return;
         }
         if(EquipType.dressAble(info.TemplateInfo) && info.CategoryID != 16)
         {
            place = EquipType.CategeryIdToPlace(info.CategoryID)[0];
            itemId = _model.getBagItems(place,true);
            prop.playerCells[itemId].shopItemInfo = info;
            info.place = place;
            _model.currentModel.setPartStyle(info.CategoryID,info.TemplateInfo.NeedSex,info.TemplateID,info.Color);
         }
         __updateCar(evt);
         updateButtons();
         prop.lastItem.shopItemInfo = info;
         __updateColorEditor();
         if(prop.panelBtnGroup.selectIndex != 1)
         {
            if(info.TemplateInfo.NeedSex == 1)
            {
               prop.addedManNewEquip++;
            }
            else if(info.TemplateInfo.NeedSex == 2)
            {
               prop.addedWomanNewEquip++;
            }
         }
      }
      
      private function __fittingSexChanged(event:ShopEvent = null) : void
      {
         var i:int = 0;
         var itemId:int = 0;
         var evt:* = null;
         prop.femaleCharacter.visible = !!_model.fittingSex?false:true;
         prop.maleCharacter.visible = !!_model.fittingSex?true:false;
         prop.muteLock = true;
         prop.cbHideGlasses.selected = _model.currentModel.getGlassHide();
         prop.cbHideHat.selected = _model.currentModel.getHatHide();
         prop.cbHideSuit.selected = _model.currentModel.getSuitesHide();
         prop.cbHideWings.selected = _model.currentModel.wingHide;
         prop.muteLock = false;
         for(i = 0; i < prop.playerCells.length; )
         {
            itemId = _model.getBagItems(i);
            if(_model.currentModel.Bag.items[itemId])
            {
               prop.playerCells[i].info = _model.currentModel.Bag.items[itemId];
               prop.playerCells[i].locked = true;
            }
            else
            {
               prop.playerCells[i].shopItemInfo = null;
            }
            i++;
         }
         var _loc8_:int = 0;
         var _loc7_:* = _model.currentTempList;
         for each(var item in _model.currentTempList)
         {
            evt = new ShopEvent("shop",item);
            __addTempEquip(evt);
         }
         updateButtons();
         var list:Array = _model.currentTempList;
         if(list.length > 0)
         {
            prop.lastItem.shopItemInfo = list[list.length - 1];
         }
         else
         {
            prop.lastItem.shopItemInfo = null;
         }
      }
      
      private function __hideGlassChange(evt:Event) : void
      {
         _model.currentModel.setGlassHide(prop.cbHideGlasses.selected);
      }
      
      private function __hideHatChange(evt:Event) : void
      {
         _model.currentModel.setHatHide(prop.cbHideHat.selected);
      }
      
      private function __hideSuitesChange(evt:Event) : void
      {
         _model.currentModel.setSuiteHide(prop.cbHideSuit.selected);
      }
      
      private function __hideWingClickHandler(event:Event) : void
      {
         _model.currentModel.wingHide = prop.cbHideWings.selected;
      }
      
      private function __originClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _controller.restoreAllItemsOnBody();
      }
      
      private function __panelBtnClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         adjustBottomView(prop.panelBtnGroup.selectIndex);
         __update(null);
      }
      
      private function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["Money"] || evt.changedProperties["Money"] || evt.changedProperties["BandMoney"])
         {
            prop.playerMoneyTxt.text = String(_model.Self.Money);
            prop.playerGiftTxt.text = String(_model.Self.BandMoney);
            prop.oderGiftTxt.text = String(_model.Self.DDTMoney);
         }
      }
      
      private function __removeCarEquip(evt:ShopEvent) : void
      {
         var si:* = null;
         var item:ShopCarItemInfo = evt.param as ShopCarItemInfo;
         var i:uint = 0;
         while(prop.cartList.numChildren > 0)
         {
            si = prop.cartList.getChildAt(i) as ShopCartItem;
            if(si.shopItemInfo == item)
            {
               break;
            }
            i++;
         }
         if(si)
         {
            si.removeEventListener("deleteitem",__deleteItem);
            prop.cartList.removeChild(si);
         }
         prop.cartScroll.invalidateViewport();
      }
      
      private function __selectedColorChanged(event:*) : void
      {
         var obj:Object = {};
         if(prop.colorEditor.selectedType == 1)
         {
            setColorLayer(prop.colorEditor.selectedColor);
            obj.color = prop.colorEditor.selectedColor;
         }
         else
         {
            setSkinColor(String(prop.colorEditor.selectedSkin));
            obj.color = prop.colorEditor.selectedSkin;
         }
         obj.item = prop.lastItem.shopItemInfo;
         obj.type = prop.colorEditor.selectedType;
         dispatchEvent(new ShopEvent("colorSelected",obj));
      }
      
      private function __topBtnClick(event:MouseEvent = null) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __update(evt:ShopEvent) : void
      {
         prop.leftMoneyPanelBuyBtn.enable = _model.allItemsCount > 0;
         prop.purchaseBtn.enable = _model.allItemsCount > 0;
         !!prop.purchaseBtn.enable?prop.purchaseEffet.play():prop.purchaseEffet.stop();
         if(!_model.checkPoint())
         {
            var _loc2_:* = _model.allItemsCount > 0;
            prop.askBtn.enable = _loc2_;
            prop.presentBtn.enable = _loc2_;
            !!prop.presentBtn.enable?prop.presentEffet.play():prop.presentEffet.stop();
            !!prop.askBtn.enable?prop.askBtnEffet.play():prop.askBtnEffet.stop();
         }
         if(prop.presentBtn.enable)
         {
            if(_model.checkPoint())
            {
               prop.presentBtn.enable = false;
               prop.askBtn.enable = false;
               prop.presentEffet.stop();
               prop.askBtnEffet.stop();
            }
         }
      }
      
      private function __updateColorEditor(e:ShopEvent = null) : void
      {
         prop.colorEditor.skinEditable = false;
         if(_model.canChangSkin())
         {
            prop.colorEditor.selectedType = 2;
            if(prop.lastItem.shopItemInfo && prop.lastItem.shopItemInfo.CategoryID == 6)
            {
               prop.colorEditor.skinEditable = true;
            }
            setSkinColor(_model.currentSkin);
            prop.colorEditor.editSkin(prop.colorEditor.selectedSkin);
         }
         else
         {
            prop.colorEditor.skinEditable = false;
            prop.colorEditor.resetSkin();
         }
         if(prop.lastItem.shopItemInfo && EquipType.isEditable(prop.lastItem.shopItemInfo.TemplateInfo))
         {
            prop.colorEditor.selectedType = 1;
            prop.colorEditor.colorEditable = true;
            prop.colorEditor.editColor(int(prop.lastItem.shopItemInfo.colorValue));
         }
         else
         {
            prop.colorEditor.colorEditable = false;
         }
      }
      
      private function addCarEquip(info:ShopCarItemInfo) : void
      {
         var item:ShopCartItem = new ShopCartItem();
         item.setShopItemInfo(info);
         prop.addItemToList(item);
         item.addEventListener("deleteitem",__deleteItem);
         item.addEventListener("conditionchange",__conditionChange);
         prop.cartScroll.invalidateViewport(true);
      }
      
      private function checkShiner(e:Event = null) : void
      {
         if((prop.colorEditor.colorEditable || prop.colorEditor.skinEditable) && prop.lastItem.info != null)
         {
            prop.panelColorBtn.enable = true;
            _isUsed = true;
            if(prop.panelBtnGroup.selectIndex == 0 && prop.canShine)
            {
               prop.canShine = false;
            }
         }
         else
         {
            prop.panelColorBtn.enable = false;
            _isUsed = false;
         }
      }
      
      private function initEvent() : void
      {
         var i:int = 0;
         addEventListener("enterFrame",checkShiner);
         _controller.rightView.addEventListener("SHOW_LIGHT",_showLight);
         prop.colorEditor.addEventListener("change",__selectedColorChanged);
         prop.colorEditor.addEventListener("reductiveColor",__reductiveColor);
         prop.colorEditor.addEventListener("change_color",_changeColor);
         prop.lastItem.addEventListener("itemInfoChange",__updateColorEditor);
         prop.btnClearLastEquip.addEventListener("click",__clearLastClick);
         prop.cbHideHat.addEventListener("select",__hideHatChange);
         prop.cbHideGlasses.addEventListener("select",__hideGlassChange);
         prop.cbHideSuit.addEventListener("select",__hideSuitesChange);
         prop.cbHideWings.addEventListener("select",__hideWingClickHandler);
         _model.addEventListener("addTempEquip",__addTempEquip);
         _model.addEventListener("costChange",__update);
         _model.addEventListener("addcarequip",__addCarEquip);
         _model.addEventListener("fittingmodelchange",__fittingSexChanged);
         _model.addEventListener("removecarequip",__removeCarEquip);
         _model.addEventListener("selectedequipchange",__selectedEquipChange);
         _model.Self.addEventListener("propertychange",__propertyChange);
         _model.addEventListener("removetempequip",__removeTempEquip);
         prop.lastItem.addEventListener("itemInfoChange",__itemInfoChange);
         prop.panelCartBtn.addEventListener("click",__panelBtnClickHandler);
         prop.panelColorBtn.addEventListener("click",__panelBtnClickHandler);
         prop.presentBtn.addEventListener("click",__presentClick);
         prop.purchaseBtn.addEventListener("click",__purchaseClick);
         prop.askBtn.addEventListener("click",askHander);
         prop.leftMoneyPanelBuyBtn.addEventListener("click",__purchaseClick);
         prop.randomBtn.addEventListener("click",__random);
         prop.saveFigureBtn.addEventListener("click",__saveFigureClick);
         _model.addEventListener("updateCar",__updateCar);
         for(i = 0; i < prop.playerCells.length; )
         {
            prop.playerCells[i].addEventListener("click",__cellClick);
            i++;
         }
      }
      
      private function __cellClick(evt:MouseEvent) : void
      {
         var item:* = null;
         SoundManager.instance.play("047");
         var cell:ShopPlayerCell = evt.currentTarget as ShopPlayerCell;
         if(cell.locked)
         {
            return;
         }
         if(cell.shopItemInfo != null)
         {
            if(cell.shopItemInfo.CategoryID == 1 || cell.shopItemInfo.CategoryID == 2 || cell.shopItemInfo.CategoryID == 3 || cell.shopItemInfo.CategoryID == 4 || cell.shopItemInfo.CategoryID == 5 || cell.shopItemInfo.CategoryID == 6)
            {
               item = cell.shopItemInfo;
               var _loc6_:int = 0;
               var _loc5_:* = prop.playerCells;
               for each(var temp in prop.playerCells)
               {
                  if(temp.shopItemInfo == item)
                  {
                     temp.showLight();
                  }
                  else
                  {
                     temp.hideLight();
                  }
               }
            }
         }
         _controller.setSelectedEquip(cell.shopItemInfo);
         prop.lastItem.shopItemInfo = cell.shopItemInfo;
      }
      
      private function __updateCar(e:ShopEvent) : void
      {
         var item:* = null;
         var i:int = 0;
         var t:* = 0;
         var info:ShopCarItemInfo = e.param as ShopCarItemInfo;
         var list:Array = _model.allItems;
         var listOrigin:Array = [];
         for(i = 0; i < prop.cartList.numChildren; )
         {
            item = prop.cartList.getChildAt(i) as ShopCartItem;
            listOrigin.push(item.shopItemInfo);
            i++;
         }
         if(listOrigin.length < list.length)
         {
            addCarEquip(info);
         }
         else if(listOrigin.length == list.length)
         {
            for(t = uint(0); t < listOrigin.length; )
            {
               if(list.indexOf(listOrigin[t]) < 0)
               {
                  (prop.cartList.getChildAt(t) as ShopCartItem).setShopItemInfo(info);
                  break;
               }
               t++;
            }
         }
         else if(listOrigin.length > list.length)
         {
            for(t = uint(0); t < listOrigin.length; )
            {
               if(list.indexOf(listOrigin[t]) < 0)
               {
                  for(i = 0; i < prop.cartList.numChildren; )
                  {
                     item = prop.cartList.getChildAt(i) as ShopCartItem;
                     if(item.shopItemInfo == listOrigin[t])
                     {
                        item.removeEventListener("deleteitem",__deleteItem);
                        item.removeEventListener("conditionchange",__conditionChange);
                        item.dispose();
                        break;
                     }
                     i++;
                  }
               }
               t++;
            }
         }
         prop.cartScroll.invalidateViewport();
      }
      
      private function removeEvents() : void
      {
         removeEventListener("enterFrame",checkShiner);
         _controller.rightView.removeEventListener("SHOW_LIGHT",_showLight);
         prop.colorEditor.removeEventListener("change",__selectedColorChanged);
         prop.colorEditor.removeEventListener("reductiveColor",__reductiveColor);
         prop.colorEditor.removeEventListener("change_color",_changeColor);
         prop.lastItem.removeEventListener("itemInfoChange",__updateColorEditor);
         prop.btnClearLastEquip.removeEventListener("click",__clearLastClick);
         prop.cbHideHat.removeEventListener("select",__hideHatChange);
         prop.cbHideGlasses.removeEventListener("select",__hideGlassChange);
         prop.cbHideSuit.removeEventListener("select",__hideSuitesChange);
         prop.cbHideWings.removeEventListener("select",__hideWingClickHandler);
         _model.removeEventListener("addTempEquip",__addTempEquip);
         _model.removeEventListener("costChange",__update);
         _model.removeEventListener("addcarequip",__addCarEquip);
         _model.removeEventListener("fittingmodelchange",__fittingSexChanged);
         _model.removeEventListener("removecarequip",__removeCarEquip);
         _model.removeEventListener("selectedequipchange",__selectedEquipChange);
         _model.Self.removeEventListener("propertychange",__propertyChange);
         _model.removeEventListener("removetempequip",__removeTempEquip);
         prop.lastItem.removeEventListener("itemInfoChange",__itemInfoChange);
         prop.panelCartBtn.removeEventListener("click",__panelBtnClickHandler);
         prop.panelColorBtn.removeEventListener("click",__panelBtnClickHandler);
         prop.presentBtn.removeEventListener("click",__presentClick);
         prop.purchaseBtn.removeEventListener("click",__purchaseClick);
         prop.leftMoneyPanelBuyBtn.removeEventListener("click",__purchaseClick);
         prop.saveFigureBtn.removeEventListener("click",__saveFigureClick);
         _model.removeEventListener("updateCar",__updateCar);
         prop.randomBtn.removeEventListener("click",__random);
         prop.askBtn.removeEventListener("click",askHander);
      }
      
      private function __purchaseClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if((_model.totalMoney > 0 || _model.totalGift > 0 || _model.totalMedal > 0) && PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         clearHighLight();
         prop.checkOutPanel.setup(_controller,_model,_model.allItems,1);
         LayerManager.Instance.addToLayer(prop.checkOutPanel,3,true,1);
      }
      
      private function askHander(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if((_model.totalMoney > 0 || _model.totalGift > 0 || _model.totalMedal > 0) && PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         clearHighLight();
         prop.checkOutPanel.setup(_controller,_model,_model.allItems,4);
         LayerManager.Instance.addToLayer(prop.checkOutPanel,3,true,1);
      }
      
      private function __random(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - latestRandom < 1500)
         {
            return;
         }
         latestRandom = getTimer();
         var _loc4_:int = 0;
         var _loc3_:* = prop.playerCells;
         for each(var temp in prop.playerCells)
         {
            temp.hideLight();
         }
         prop.cbHideGlasses.selected = false;
         prop.cbHideHat.selected = false;
         prop.cbHideWings.selected = false;
         prop.cbHideSuit.selected = true;
         _controller.model.random();
      }
      
      private function __saveFigureClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         clearHighLight();
         prop.checkOutPanel.setup(_controller,_model,_model.currentTempList,3);
         LayerManager.Instance.addToLayer(prop.checkOutPanel,3,true,1);
      }
      
      private function __presentClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var giveList:Array = ShopManager.Instance.moneyGoods(_model.allItems,_model.Self);
         if(giveList.length > 0)
         {
            prop.checkOutPanel.setup(_controller,_model,giveList,2);
            LayerManager.Instance.addToLayer(prop.checkOutPanel,3,true,1);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.cantPresent"));
         }
      }
      
      private function __itemInfoChange(evt:Event) : void
      {
         prop.canShine = true;
         __updateColorEditor();
      }
      
      private function __removeTempEquip(evt:ShopEvent) : void
      {
         var place:int = 0;
         var itemId:int = 0;
         var orientItem:* = null;
         var item:ShopCarItemInfo = evt.param as ShopCarItemInfo;
         if(prop.lastItem.shopItemInfo == item)
         {
            prop.lastItem.shopItemInfo = null;
         }
         __updateColorEditor();
         if(item.TemplateInfo.NeedSex == 1)
         {
            if(prop.addedManNewEquip > 0)
            {
               var _loc6_:* = Number(prop.addedManNewEquip);
               prop.addedManNewEquip--;
               §§push(_loc6_);
            }
            else
            {
               _loc6_ = 0;
               prop.addedManNewEquip = _loc6_;
               §§push(int(_loc6_));
            }
            §§pop();
         }
         else if(item.TemplateInfo.NeedSex == 2)
         {
            if(prop.addedWomanNewEquip > 0)
            {
               _loc6_ = Number(prop.addedWomanNewEquip);
               prop.addedWomanNewEquip--;
               §§push(_loc6_);
            }
            else
            {
               _loc6_ = 0;
               prop.addedWomanNewEquip = _loc6_;
               §§push(int(_loc6_));
            }
            §§pop();
         }
         if(evt.model == _model.currentModel)
         {
            place = item.place;
            itemId = _model.getBagItems(place,true);
            orientItem = _model.currentModel.Bag.items[place];
            if(orientItem)
            {
               prop.playerCells[itemId].info = orientItem;
               prop.playerCells[itemId].locked = true;
            }
            else
            {
               prop.playerCells[itemId].info = null;
            }
            updateButtons();
         }
         __updateCar(evt);
      }
      
      private function __selectedEquipChange(evt:ShopEvent) : void
      {
         prop.lastItem.shopItemInfo = evt.param as ShopCarItemInfo;
         updateButtons();
         __updateColorEditor();
      }
      
      private function setColorLayer(color:int) : void
      {
         var editlayer:int = 0;
         var place:int = 0;
         var temp:* = null;
         var item:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         if(item && EquipType.isEditable(item.TemplateInfo) && int(item.colorValue) != color)
         {
            editlayer = prop.lastItem.editLayer - 1;
            place = EquipType.CategeryIdToPlace(item.CategoryID)[0];
            temp = item.Color.split("|");
            temp[editlayer] = String(color);
            item.Color = temp.join("|");
            prop.lastItem.setColor(item.Color);
            _model.currentModel.setPartColor(item.CategoryID,item.Color);
         }
      }
      
      private function setSkinColor(color:String) : void
      {
         var item:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         if(item && item.CategoryID == 6)
         {
            item.skin = color;
         }
         prop.lastItem.setSkinColor(color);
         _model.currentModel.Skin = color;
      }
      
      protected function __reductiveColor(event:Event) : void
      {
         var item:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         if(prop.colorEditor.selectedType == 1)
         {
            if(item && EquipType.isEditable(item.TemplateInfo))
            {
               item.Color = "";
               _model.currentModel.setPartColor(item.CategoryID,null);
            }
         }
         else
         {
            item.skin = "";
            _model.currentModel.setSkinColor("");
         }
      }
      
      private function _changeColor(event:Event) : void
      {
         showShine();
      }
      
      private function _showLight(event:Event) : void
      {
         if(_isVisible)
         {
            showShine();
         }
      }
      
      private function showShine() : void
      {
         var item:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         var _loc4_:int = 0;
         var _loc3_:* = prop.playerCells;
         for each(var temp in prop.playerCells)
         {
            if(temp.shopItemInfo == item)
            {
               temp.showLight();
            }
            else
            {
               temp.hideLight();
            }
         }
      }
      
      public function hideLight() : void
      {
         var item:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         var _loc4_:int = 0;
         var _loc3_:* = prop.playerCells;
         for each(var temp in prop.playerCells)
         {
            temp.hideLight();
         }
      }
      
      private function updateButtons() : void
      {
         prop.saveFigureBtn.enable = _model.isSelfModel && _model.currentTempList.length != 0;
      }
      
      public function dispose() : void
      {
         removeEvents();
         prop.disposeAllChildrenFrom(this);
         prop = null;
         _controller = null;
         _model = null;
      }
   }
}
