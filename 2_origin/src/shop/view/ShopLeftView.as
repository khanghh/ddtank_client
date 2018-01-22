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
      
      public function adjustBottomView(param1:uint) : void
      {
         prop.middlePanelBg.setFrame(param1 + 1);
         prop.panelBtnGroup.selectIndex = param1;
         if(param1 == 0)
         {
            _isVisible = false;
            prop.purchaseView.visible = true;
            prop.colorEditor.visible = false;
            var _loc4_:int = 0;
            var _loc3_:* = prop.playerCells;
            for each(var _loc2_ in prop.playerCells)
            {
               _loc2_.hideLight();
            }
         }
         if(param1 == 1)
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
      
      public function adjustUpperView(param1:uint) : void
      {
         if(param1 == 0)
         {
            if(prop.middlePanelBg.getFrame == 0 + 1)
            {
               prop.purchaseView.visible = true;
            }
            prop.dressView.visible = true;
            prop.cartScroll.visible = false;
         }
         if(param1 == 1)
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
      
      public function setup(param1:ShopController, param2:ShopModel) : void
      {
         _controller = param1;
         _model = param2;
         initEvent();
         refreshCharater();
      }
      
      private function __addCarEquip(param1:ShopEvent) : void
      {
         addCarEquip(param1.param as ShopCarItemInfo);
      }
      
      private function __clearClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _controller.revertToDefault();
      }
      
      private function __clearLastClick(param1:MouseEvent) : void
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
         for each(var _loc1_ in prop.playerCells)
         {
            _loc1_.hideLight();
         }
      }
      
      private function __conditionChange(param1:Event) : void
      {
         _controller.updateCost();
      }
      
      private function __deleteItem(param1:Event) : void
      {
         var _loc2_:ShopCartItem = param1.currentTarget as ShopCartItem;
         _controller.removeFromCar(_loc2_.shopItemInfo as ShopCarItemInfo);
         if(prop.cartList.contains(_loc2_))
         {
            prop.cartList.removeChild(_loc2_);
         }
      }
      
      private function __addTempEquip(param1:ShopEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:ShopCarItemInfo = param1.param as ShopCarItemInfo;
         if(EquipType.isProp(_loc4_.TemplateInfo))
         {
            return;
         }
         if(EquipType.dressAble(_loc4_.TemplateInfo) && _loc4_.CategoryID != 16)
         {
            _loc3_ = EquipType.CategeryIdToPlace(_loc4_.CategoryID)[0];
            _loc2_ = _model.getBagItems(_loc3_,true);
            prop.playerCells[_loc2_].shopItemInfo = _loc4_;
            _loc4_.place = _loc3_;
            _model.currentModel.setPartStyle(_loc4_.CategoryID,_loc4_.TemplateInfo.NeedSex,_loc4_.TemplateID,_loc4_.Color);
         }
         __updateCar(param1);
         updateButtons();
         prop.lastItem.shopItemInfo = _loc4_;
         __updateColorEditor();
         if(prop.panelBtnGroup.selectIndex != 1)
         {
            if(_loc4_.TemplateInfo.NeedSex == 1)
            {
               prop.addedManNewEquip++;
            }
            else if(_loc4_.TemplateInfo.NeedSex == 2)
            {
               prop.addedWomanNewEquip++;
            }
         }
      }
      
      private function __fittingSexChanged(param1:ShopEvent = null) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         prop.femaleCharacter.visible = !!_model.fittingSex?false:true;
         prop.maleCharacter.visible = !!_model.fittingSex?true:false;
         prop.muteLock = true;
         prop.cbHideGlasses.selected = _model.currentModel.getGlassHide();
         prop.cbHideHat.selected = _model.currentModel.getHatHide();
         prop.cbHideSuit.selected = _model.currentModel.getSuitesHide();
         prop.cbHideWings.selected = _model.currentModel.wingHide;
         prop.muteLock = false;
         _loc6_ = 0;
         while(_loc6_ < prop.playerCells.length)
         {
            _loc5_ = _model.getBagItems(_loc6_);
            if(_model.currentModel.Bag.items[_loc5_])
            {
               prop.playerCells[_loc6_].info = _model.currentModel.Bag.items[_loc5_];
               prop.playerCells[_loc6_].locked = true;
            }
            else
            {
               prop.playerCells[_loc6_].shopItemInfo = null;
            }
            _loc6_++;
         }
         var _loc8_:int = 0;
         var _loc7_:* = _model.currentTempList;
         for each(var _loc3_ in _model.currentTempList)
         {
            _loc2_ = new ShopEvent("shop",_loc3_);
            __addTempEquip(_loc2_);
         }
         updateButtons();
         var _loc4_:Array = _model.currentTempList;
         if(_loc4_.length > 0)
         {
            prop.lastItem.shopItemInfo = _loc4_[_loc4_.length - 1];
         }
         else
         {
            prop.lastItem.shopItemInfo = null;
         }
      }
      
      private function __hideGlassChange(param1:Event) : void
      {
         _model.currentModel.setGlassHide(prop.cbHideGlasses.selected);
      }
      
      private function __hideHatChange(param1:Event) : void
      {
         _model.currentModel.setHatHide(prop.cbHideHat.selected);
      }
      
      private function __hideSuitesChange(param1:Event) : void
      {
         _model.currentModel.setSuiteHide(prop.cbHideSuit.selected);
      }
      
      private function __hideWingClickHandler(param1:Event) : void
      {
         _model.currentModel.wingHide = prop.cbHideWings.selected;
      }
      
      private function __originClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _controller.restoreAllItemsOnBody();
      }
      
      private function __panelBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         adjustBottomView(prop.panelBtnGroup.selectIndex);
         __update(null);
      }
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Money"] || param1.changedProperties["Money"] || param1.changedProperties["BandMoney"])
         {
            prop.playerMoneyTxt.text = String(_model.Self.Money);
            prop.playerGiftTxt.text = String(_model.Self.BandMoney);
            prop.oderGiftTxt.text = String(_model.Self.DDTMoney);
         }
      }
      
      private function __removeCarEquip(param1:ShopEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:ShopCarItemInfo = param1.param as ShopCarItemInfo;
         var _loc3_:uint = 0;
         while(prop.cartList.numChildren > 0)
         {
            _loc4_ = prop.cartList.getChildAt(_loc3_) as ShopCartItem;
            if(_loc4_.shopItemInfo != _loc2_)
            {
               _loc3_++;
               continue;
            }
            break;
         }
         if(_loc4_)
         {
            _loc4_.removeEventListener("deleteitem",__deleteItem);
            prop.cartList.removeChild(_loc4_);
         }
         prop.cartScroll.invalidateViewport();
      }
      
      private function __selectedColorChanged(param1:*) : void
      {
         var _loc2_:Object = {};
         if(prop.colorEditor.selectedType == 1)
         {
            setColorLayer(prop.colorEditor.selectedColor);
            _loc2_.color = prop.colorEditor.selectedColor;
         }
         else
         {
            setSkinColor(String(prop.colorEditor.selectedSkin));
            _loc2_.color = prop.colorEditor.selectedSkin;
         }
         _loc2_.item = prop.lastItem.shopItemInfo;
         _loc2_.type = prop.colorEditor.selectedType;
         dispatchEvent(new ShopEvent("colorSelected",_loc2_));
      }
      
      private function __topBtnClick(param1:MouseEvent = null) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __update(param1:ShopEvent) : void
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
      
      private function __updateColorEditor(param1:ShopEvent = null) : void
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
      
      private function addCarEquip(param1:ShopCarItemInfo) : void
      {
         var _loc2_:ShopCartItem = new ShopCartItem();
         _loc2_.setShopItemInfo(param1);
         prop.addItemToList(_loc2_);
         _loc2_.addEventListener("deleteitem",__deleteItem);
         _loc2_.addEventListener("conditionchange",__conditionChange);
         prop.cartScroll.invalidateViewport(true);
      }
      
      private function checkShiner(param1:Event = null) : void
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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < prop.playerCells.length)
         {
            prop.playerCells[_loc1_].addEventListener("click",__cellClick);
            _loc1_++;
         }
      }
      
      private function __cellClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("047");
         var _loc3_:ShopPlayerCell = param1.currentTarget as ShopPlayerCell;
         if(_loc3_.locked)
         {
            return;
         }
         if(_loc3_.shopItemInfo != null)
         {
            if(_loc3_.shopItemInfo.CategoryID == 1 || _loc3_.shopItemInfo.CategoryID == 2 || _loc3_.shopItemInfo.CategoryID == 3 || _loc3_.shopItemInfo.CategoryID == 4 || _loc3_.shopItemInfo.CategoryID == 5 || _loc3_.shopItemInfo.CategoryID == 6)
            {
               _loc2_ = _loc3_.shopItemInfo;
               var _loc6_:int = 0;
               var _loc5_:* = prop.playerCells;
               for each(var _loc4_ in prop.playerCells)
               {
                  if(_loc4_.shopItemInfo == _loc2_)
                  {
                     _loc4_.showLight();
                  }
                  else
                  {
                     _loc4_.hideLight();
                  }
               }
            }
         }
         _controller.setSelectedEquip(_loc3_.shopItemInfo);
         prop.lastItem.shopItemInfo = _loc3_.shopItemInfo;
      }
      
      private function __updateCar(param1:ShopEvent) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = 0;
         var _loc7_:ShopCarItemInfo = param1.param as ShopCarItemInfo;
         var _loc5_:Array = _model.allItems;
         var _loc2_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < prop.cartList.numChildren)
         {
            _loc4_ = prop.cartList.getChildAt(_loc6_) as ShopCartItem;
            _loc2_.push(_loc4_.shopItemInfo);
            _loc6_++;
         }
         if(_loc2_.length < _loc5_.length)
         {
            addCarEquip(_loc7_);
         }
         else if(_loc2_.length == _loc5_.length)
         {
            _loc3_ = uint(0);
            while(_loc3_ < _loc2_.length)
            {
               if(_loc5_.indexOf(_loc2_[_loc3_]) < 0)
               {
                  (prop.cartList.getChildAt(_loc3_) as ShopCartItem).setShopItemInfo(_loc7_);
                  break;
               }
               _loc3_++;
            }
         }
         else if(_loc2_.length > _loc5_.length)
         {
            _loc3_ = uint(0);
            while(_loc3_ < _loc2_.length)
            {
               if(_loc5_.indexOf(_loc2_[_loc3_]) < 0)
               {
                  _loc6_ = 0;
                  while(_loc6_ < prop.cartList.numChildren)
                  {
                     _loc4_ = prop.cartList.getChildAt(_loc6_) as ShopCartItem;
                     if(_loc4_.shopItemInfo == _loc2_[_loc3_])
                     {
                        _loc4_.removeEventListener("deleteitem",__deleteItem);
                        _loc4_.removeEventListener("conditionchange",__conditionChange);
                        _loc4_.dispose();
                        break;
                     }
                     _loc6_++;
                  }
               }
               _loc3_++;
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
      
      private function __purchaseClick(param1:MouseEvent) : void
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
      
      private function askHander(param1:MouseEvent) : void
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
      
      private function __random(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - latestRandom < 1500)
         {
            return;
         }
         latestRandom = getTimer();
         var _loc4_:int = 0;
         var _loc3_:* = prop.playerCells;
         for each(var _loc2_ in prop.playerCells)
         {
            _loc2_.hideLight();
         }
         prop.cbHideGlasses.selected = false;
         prop.cbHideHat.selected = false;
         prop.cbHideWings.selected = false;
         prop.cbHideSuit.selected = true;
         _controller.model.random();
      }
      
      private function __saveFigureClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         clearHighLight();
         prop.checkOutPanel.setup(_controller,_model,_model.currentTempList,3);
         LayerManager.Instance.addToLayer(prop.checkOutPanel,3,true,1);
      }
      
      private function __presentClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Array = ShopManager.Instance.moneyGoods(_model.allItems,_model.Self);
         if(_loc2_.length > 0)
         {
            prop.checkOutPanel.setup(_controller,_model,_loc2_,2);
            LayerManager.Instance.addToLayer(prop.checkOutPanel,3,true,1);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.cantPresent"));
         }
      }
      
      private function __itemInfoChange(param1:Event) : void
      {
         prop.canShine = true;
         __updateColorEditor();
      }
      
      private function __removeTempEquip(param1:ShopEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:ShopCarItemInfo = param1.param as ShopCarItemInfo;
         if(prop.lastItem.shopItemInfo == _loc2_)
         {
            prop.lastItem.shopItemInfo = null;
         }
         __updateColorEditor();
         if(_loc2_.TemplateInfo.NeedSex == 1)
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
         else if(_loc2_.TemplateInfo.NeedSex == 2)
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
         if(param1.model == _model.currentModel)
         {
            _loc5_ = _loc2_.place;
            _loc4_ = _model.getBagItems(_loc5_,true);
            _loc3_ = _model.currentModel.Bag.items[_loc5_];
            if(_loc3_)
            {
               prop.playerCells[_loc4_].info = _loc3_;
               prop.playerCells[_loc4_].locked = true;
            }
            else
            {
               prop.playerCells[_loc4_].info = null;
            }
            updateButtons();
         }
         __updateCar(param1);
      }
      
      private function __selectedEquipChange(param1:ShopEvent) : void
      {
         prop.lastItem.shopItemInfo = param1.param as ShopCarItemInfo;
         updateButtons();
         __updateColorEditor();
      }
      
      private function setColorLayer(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         if(_loc3_ && EquipType.isEditable(_loc3_.TemplateInfo) && int(_loc3_.colorValue) != param1)
         {
            _loc2_ = prop.lastItem.editLayer - 1;
            _loc5_ = EquipType.CategeryIdToPlace(_loc3_.CategoryID)[0];
            _loc4_ = _loc3_.Color.split("|");
            _loc4_[_loc2_] = String(param1);
            _loc3_.Color = _loc4_.join("|");
            prop.lastItem.setColor(_loc3_.Color);
            _model.currentModel.setPartColor(_loc3_.CategoryID,_loc3_.Color);
         }
      }
      
      private function setSkinColor(param1:String) : void
      {
         var _loc2_:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         if(_loc2_ && _loc2_.CategoryID == 6)
         {
            _loc2_.skin = param1;
         }
         prop.lastItem.setSkinColor(param1);
         _model.currentModel.Skin = param1;
      }
      
      protected function __reductiveColor(param1:Event) : void
      {
         var _loc2_:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         if(prop.colorEditor.selectedType == 1)
         {
            if(_loc2_ && EquipType.isEditable(_loc2_.TemplateInfo))
            {
               _loc2_.Color = "";
               _model.currentModel.setPartColor(_loc2_.CategoryID,null);
            }
         }
         else
         {
            _loc2_.skin = "";
            _model.currentModel.setSkinColor("");
         }
      }
      
      private function _changeColor(param1:Event) : void
      {
         showShine();
      }
      
      private function _showLight(param1:Event) : void
      {
         if(_isVisible)
         {
            showShine();
         }
      }
      
      private function showShine() : void
      {
         var _loc1_:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         var _loc4_:int = 0;
         var _loc3_:* = prop.playerCells;
         for each(var _loc2_ in prop.playerCells)
         {
            if(_loc2_.shopItemInfo == _loc1_)
            {
               _loc2_.showLight();
            }
            else
            {
               _loc2_.hideLight();
            }
         }
      }
      
      public function hideLight() : void
      {
         var _loc1_:ShopCarItemInfo = prop.lastItem.shopItemInfo;
         var _loc4_:int = 0;
         var _loc3_:* = prop.playerCells;
         for each(var _loc2_ in prop.playerCells)
         {
            _loc2_.hideLight();
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
