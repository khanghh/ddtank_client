package playerDress.views
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.DraftManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.tips.OneLineTip;
   import draft.data.DraftModel;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import playerDress.PlayerDressControl;
   import playerDress.PlayerDressManager;
   import playerDress.components.DressCell;
   import playerDress.components.DressModel;
   import playerDress.components.DressUtils;
   import playerDress.data.DressVo;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   import trainer.view.NewHandContainer;
   
   public class PlayerDressView extends Sprite implements Disposeable
   {
      
      public static const CELLS_LENGTH:uint = 8;
      
      public static const NEED_GOLD:int = 5000;
       
      
      private var _BG:ScaleFrameImage;
      
      private var _character:RoomCharacter;
      
      private var _hidePanel:MovieImage;
      
      private var _uploadBtn:SimpleBitmapButton;
      
      private var _saveBtn:SimpleBitmapButton;
      
      private var _selectedBox:ComboBox;
      
      private var _okBtn:SimpleBitmapButton;
      
      private var _okBtnSprite:Sprite;
      
      private var _okBtnTip:OneLineTip;
      
      private var _descTxt:FilterFrameText;
      
      private var _hideSprite:Sprite;
      
      private var _hideHatBtn:SelectedCheckButton;
      
      private var _hideGlassBtn:SelectedCheckButton;
      
      private var _hideSuitBtn:SelectedCheckButton;
      
      private var _hideWingBtn:SelectedCheckButton;
      
      private var _dressCells:Vector.<BagCell>;
      
      private var _helpBtn:BaseButton;
      
      private var _currentModel:DressModel;
      
      private var _currentIndex:int;
      
      private var _comboBoxArr:Array;
      
      private var _self:PlayerInfo;
      
      private var _bodyThings:DictionaryData;
      
      private var _stylePrice:int;
      
      private var _money:int = 100;
      
      private var saveBtnClick:Boolean = false;
      
      public function PlayerDressView()
      {
         _comboBoxArr = [];
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         var i:int = 0;
         _currentIndex = PlayerDressManager.instance.currentIndex;
         _currentModel = new DressModel();
         _dressCells = new Vector.<BagCell>();
         for(i = 1; i <= PlayerDressManager.instance.currentModelNum; )
         {
            _comboBoxArr.push(LanguageMgr.GetTranslation("playerDress.model" + i));
            i++;
         }
         if(PlayerDressManager.instance.currentModelNum < 6)
         {
            _comboBoxArr.push(LanguageMgr.GetTranslation("playerDress.add"));
         }
         PlayerDressManager.instance.currentModel = _currentModel;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var cell:* = null;
         _BG = ComponentFactory.Instance.creatComponentByStylename("playerDress.bg");
         addChild(_BG);
         _hidePanel = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.view.ddtbg");
         PositionUtils.setPos(_hidePanel,"playerDress.hidePanelPos");
         addChild(_hidePanel);
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.saveBtn");
         addChild(_saveBtn);
         _saveBtn.enable = false;
         _uploadBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.uploadBtn");
         addChild(_uploadBtn);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.okBtn");
         addChild(_okBtn);
         enableOKBtn(false);
         _okBtn.tipData = LanguageMgr.GetTranslation("playerDress.okBtnTip");
         ComponentSetting.COMBOX_LIST_LAYER = LayerManager.Instance.getLayerByType(2);
         _selectedBox = ComponentFactory.Instance.creatComponentByStylename("playerDress.modelCombo");
         _selectedBox.selctedPropName = "text";
         _selectedBox.textField.text = _comboBoxArr[_currentIndex];
         addChild(_selectedBox);
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("playerDress.decTxt");
         _descTxt.text = LanguageMgr.GetTranslation("playerDress.descTxt");
         addChild(_descTxt);
         _hideSprite = new Sprite();
         PositionUtils.setPos(_hideSprite,"playerDress.hidePos");
         addChild(_hideSprite);
         _hideHatBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.hideHatCheckBox");
         _hideSprite.addChild(_hideHatBtn);
         _hideGlassBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.hideGlassCheckBox");
         _hideSprite.addChild(_hideGlassBtn);
         _hideSuitBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.hideSuitCheckBox");
         _hideSprite.addChild(_hideSuitBtn);
         _hideWingBtn = ComponentFactory.Instance.creatComponentByStylename("playerDress.hideWingCheckBox");
         _hideSprite.addChild(_hideWingBtn);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"playerDress.helpBtn",null,LanguageMgr.GetTranslation("playerDress.dressReadMe"),"playerDress.readMe",404,484);
         for(i = 0; i <= 8 - 1; )
         {
            cell = new DressCell();
            CellFactory.instance.fillTipProp(cell);
            cell.doubleClickEnabled = true;
            cell.addEventListener("doubleclick",__cellDoubleClick);
            PositionUtils.setPos(cell,"playerDress.cellPos" + i);
            _dressCells.push(cell);
            addChild(cell);
            i++;
         }
         updateComboBox(_comboBoxArr[_currentIndex]);
         updateModel();
         updateView();
      }
      
      private function updateView() : void
      {
         if(DraftManager.instance.showDraft)
         {
            _BG.setFrame(2);
            enableOKBtn(true);
            var _loc1_:* = false;
            _saveBtn.visible = _loc1_;
            _loc1_ = _loc1_;
            _selectedBox.visible = _loc1_;
            _okBtn.visible = _loc1_;
            _uploadBtn.visible = true;
            PositionUtils.setPos(_hidePanel,"playerDress.hidePanelPos2");
            PositionUtils.setPos(_hideSprite,"playerDress.hidePos2");
         }
         else
         {
            _BG.setFrame(1);
            _loc1_ = true;
            _saveBtn.visible = _loc1_;
            _loc1_ = _loc1_;
            _selectedBox.visible = _loc1_;
            _okBtn.visible = _loc1_;
            _uploadBtn.visible = false;
         }
      }
      
      public function updateModel() : void
      {
         var sItem:* = null;
         var tItem:* = null;
         var i:int = 0;
         var templateId:int = 0;
         var itemId:int = 0;
         var key:int = 0;
         _self = PlayerManager.Instance.Self;
         if(_self.Sex)
         {
            _currentModel.model.updateStyle(_self.Sex,_self.Hide,DressModel.DEFAULT_MAN_STYLE,",,,,,,","");
         }
         else
         {
            _currentModel.model.updateStyle(_self.Sex,_self.Hide,DressModel.DEFAULT_WOMAN_STYLE,",,,,,,","");
         }
         _bodyThings = new DictionaryData();
         var dressArr:Array = PlayerDressManager.instance.modelArr[_currentIndex];
         var reSave:Boolean = false;
         if(dressArr)
         {
            for(i = 0; i <= dressArr.length - 1; )
            {
               templateId = (dressArr[i] as DressVo).templateId;
               itemId = (dressArr[i] as DressVo).itemId;
               tItem = new InventoryItemInfo();
               sItem = _self.Bag.getItemByItemId(itemId);
               if(!sItem)
               {
                  sItem = _self.Bag.getItemByTemplateId(templateId);
                  reSave = true;
               }
               if(sItem)
               {
                  tItem.setIsUsed(sItem.IsUsed);
                  ObjectUtils.copyProperties(tItem,sItem);
                  key = DressUtils.findItemPlace(tItem);
                  _bodyThings.add(key,tItem);
                  if(tItem.CategoryID == 6)
                  {
                     _currentModel.model.Skin = tItem.Skin;
                  }
                  _currentModel.model.setPartStyle(tItem.CategoryID,tItem.NeedSex,tItem.TemplateID,tItem.Color);
               }
               i++;
            }
         }
         _currentModel.model.Bag.items = _bodyThings;
         if(reSave)
         {
            saveModel();
         }
         setBtnsStatus();
         updateCharacter();
         updateHideCheckBox();
      }
      
      public function putOnDress(item:InventoryItemInfo) : void
      {
         var tItem:InventoryItemInfo = new InventoryItemInfo();
         tItem.setIsUsed(item.IsUsed);
         ObjectUtils.copyProperties(tItem,item);
         var key:int = DressUtils.findItemPlace(tItem);
         _currentModel.model.Bag.items.add(key,tItem);
         if(tItem.CategoryID == 6)
         {
            _currentModel.model.Skin = tItem.Skin;
         }
         _currentModel.model.setPartStyle(tItem.CategoryID,tItem.NeedSex,tItem.TemplateID,tItem.Color);
         updateCharacter();
         setBtnsStatus();
      }
      
      private function initEvent() : void
      {
         _self.Bag.addEventListener("update",__updateGoods);
         _hideHatBtn.addEventListener("select",__hideHatChange);
         _hideGlassBtn.addEventListener("select",__hideGlassChange);
         _hideSuitBtn.addEventListener("select",__hideSuitesChange);
         _hideWingBtn.addEventListener("select",__hideWingClickHandler);
         _selectedBox.listPanel.list.addEventListener("listItemClick",__onListClick);
         _saveBtn.addEventListener("click",__saveBtnClick);
         _okBtn.addEventListener("click",__okBtnClick);
         _uploadBtn.addEventListener("click",__onUpLoadClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(237,8),__onAddIsSuccess);
      }
      
      private function __onAddIsSuccess(e:PkgEvent) : void
      {
         var msg:* = null;
         var pkg:PackageIn = e.pkg;
         var result:int = pkg.readInt();
         if(result)
         {
            msg = LanguageMgr.GetTranslation("playerDress.add.success");
            MessageTipManager.getInstance().show(msg,0,true,1);
            PlayerDressManager.instance.currentModelNum = PlayerDressManager.instance.currentModelNum + 1;
            _comboBoxArr.splice(PlayerDressManager.instance.currentModelNum - 1,PlayerDressManager.instance.currentModelNum == 6?1:0,LanguageMgr.GetTranslation("playerDress.model" + PlayerDressManager.instance.currentModelNum));
            _selectedBox.textField.text = _comboBoxArr[_currentIndex];
            updateComboBox(_comboBoxArr[_currentIndex]);
            updateModel();
         }
      }
      
      protected function __onUpLoadClick(event:MouseEvent) : void
      {
         var frame:* = null;
         SoundManager.instance.playButtonSound();
         _currentModel.model.setSuiteHide(true);
         _currentModel.model.wingHide = true;
         if(DraftModel.UploadNum < 1)
         {
            SocketManager.Instance.out.uploadDraftStyle(_currentModel.model.Style,_currentModel.model.Colors + "#" + _currentModel.model.Skin);
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _stylePrice = 2000 * Math.pow(2,DraftModel.UploadNum - 1);
            frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("draftView.uploadStyle.info",DraftModel.UploadNum,_stylePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false);
            frame.addEventListener("response",onBuyConfirmResponse);
         }
      }
      
      private function onBuyConfirmResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",onBuyConfirmResponse);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,_stylePrice,onCheckComplete);
         }
         frame.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.uploadDraftStyle(_currentModel.model.Style,_currentModel.model.Colors + "#" + _currentModel.model.Skin);
      }
      
      protected function __updateGoods(event:BagEvent) : void
      {
         var item:* = null;
         var changeItem:* = null;
         var tItem:* = null;
         var index:int = 0;
         var changeSlots:Dictionary = event.changedSlots;
         var _loc12_:int = 0;
         var _loc11_:* = _currentModel.model.Bag.items;
         for(var key in _currentModel.model.Bag.items)
         {
            item = _currentModel.model.Bag.items[key];
            if(item)
            {
               var _loc10_:int = 0;
               var _loc9_:* = changeSlots;
               for(var slot in changeSlots)
               {
                  changeItem = changeSlots[slot];
                  if(_self.Bag.items[slot])
                  {
                     if(item.ItemID != 0 && item.ItemID == changeItem.ItemID || item.ItemID == 0 && item.TemplateID == changeItem.TemplateID)
                     {
                        tItem = new InventoryItemInfo();
                        tItem.setIsUsed(changeItem.IsUsed);
                        ObjectUtils.copyProperties(tItem,changeItem);
                        _currentModel.model.Bag.items[key] = tItem;
                        index = DressUtils.getBagItems(int(key),true);
                        if(_dressCells[index])
                        {
                           _dressCells[index].info = tItem;
                        }
                     }
                  }
               }
               continue;
            }
         }
         setBtnsStatus();
      }
      
      protected function __cellDoubleClick(event:CellEvent) : void
      {
         var i:int = 0;
         var index:int = 0;
         var item:* = null;
         var sex:int = 0;
         for(i = 0; i <= 8 - 1; )
         {
            if(_dressCells[i] == event.target)
            {
               index = DressUtils.getBagItems(i);
               item = _currentModel.model.Bag.items[index];
               sex = !!_self.Sex?1:2;
               _currentModel.model.setPartStyle(item.CategoryID,sex);
               if(item.CategoryID == 6)
               {
                  _currentModel.model.Skin = "";
               }
               _currentModel.model.Bag.items[index] = null;
               _dressCells[i].info = null;
            }
            i++;
         }
         setBtnsStatus();
      }
      
      protected function __okBtnClick(event:MouseEvent) : void
      {
         var j:int = 0;
         var cell:* = null;
         var alert:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         enableOKBtn(false);
         saveBtnClick = false;
         for(j = 0; j <= 8 - 1; )
         {
            cell = _dressCells[j] as BagCell;
            if(cell.info && (cell.info.BindType == 1 || cell.info.BindType == 2 || cell.info.BindType == 3) && cell.itemInfo.IsBinds == false)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               alert.addEventListener("response",__onResponse);
               return;
            }
            j++;
         }
         save();
         exchangeProperty();
      }
      
      private function exchangeProperty() : void
      {
         var i:int = 0;
         var index:int = 0;
         var sourceItem:* = null;
         var targetItem:* = null;
         var sourcePlace:int = 0;
         var targetPlace:int = 0;
         PlayerDressControl.instance.lockDressBag();
         var equipBag:BagInfo = PlayerManager.Instance.Self.Bag;
         var goldNotEnough:Boolean = false;
         for(i = 0; i <= 8 - 1; )
         {
            index = DressUtils.getBagItems(i);
            sourceItem = _currentModel.model.Bag.items[index];
            targetItem = _self.Bag.items[index];
            if(sourceItem && checkOverDue(sourceItem))
            {
               sourceItem = null;
            }
            if(sourceItem && targetItem)
            {
               sourcePlace = sourceItem.Place;
               targetPlace = targetItem.Place;
               if(sourcePlace != targetPlace)
               {
                  if(DressUtils.hasNoAddition(targetItem))
                  {
                     SocketManager.Instance.out.sendMoveGoods(0,sourcePlace,0,targetPlace,1,true);
                  }
                  else if(PlayerManager.Instance.Self.Gold < 5000)
                  {
                     goldNotEnough = true;
                     SocketManager.Instance.out.sendMoveGoods(0,sourcePlace,0,targetPlace,1,true);
                  }
                  else
                  {
                     SocketManager.Instance.out.sendItemTransfer(true,true,0,sourcePlace,0,targetPlace);
                     SocketManager.Instance.out.sendMoveGoods(0,sourcePlace,0,targetPlace,1,true);
                  }
               }
            }
            else if(!sourceItem && targetItem)
            {
               SocketManager.Instance.out.sendMoveGoods(0,targetItem.Place,0,-1,1,true);
            }
            else if(sourceItem && !targetItem)
            {
               SocketManager.Instance.out.sendMoveGoods(0,sourceItem.Place,0,index,1,true);
            }
            i++;
         }
         SocketManager.Instance.out.setCurrentModel(_currentIndex);
         SocketManager.Instance.out.lockDressBag();
         if(goldNotEnough)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.goldNotEnough"));
         }
         if(NewHandContainer.Instance.hasArrow(122))
         {
            SocketManager.Instance.out.syncWeakStep(107);
            NewHandContainer.Instance.clearArrowByID(122);
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.changeDressSuccess"));
      }
      
      protected function __saveBtnClick(event:MouseEvent) : void
      {
         var i:int = 0;
         var cell:* = null;
         var alert:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         saveBtnClick = true;
         for(i = 0; i <= 8 - 1; )
         {
            cell = _dressCells[i] as BagCell;
            if(cell.info && (cell.info.BindType == 1 || cell.info.BindType == 2 || cell.info.BindType == 3) && cell.itemInfo.IsBinds == false)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               alert.addEventListener("response",__onResponse);
               return;
            }
            i++;
         }
         save();
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               enableOKBtn(true);
               break;
            case 2:
            case 3:
            case 4:
               save();
               if(!saveBtnClick)
               {
                  exchangeProperty();
               }
         }
      }
      
      private function save() : void
      {
         saveModel();
         setBtnsStatus();
         if(saveBtnClick)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.saveModelSuccess"));
         }
      }
      
      private function saveModel() : void
      {
         var i:int = 0;
         var index:int = 0;
         var item:* = null;
         var dressPlaceArr:Array = [];
         for(i = 0; i <= 8 - 1; )
         {
            index = DressUtils.getBagItems(i);
            item = _currentModel.model.Bag.items[index];
            if(item)
            {
               dressPlaceArr.push(item.Place);
            }
            i++;
         }
         SocketManager.Instance.out.saveDressModel(_currentIndex,dressPlaceArr);
      }
      
      protected function __onListClick(event:ListItemEvent) : void
      {
         var alertAsk:* = null;
         SoundManager.instance.play("008");
         if(_currentIndex == _comboBoxArr.indexOf(event.cellValue))
         {
            return;
         }
         if(event.cellValue == LanguageMgr.GetTranslation("playerDress.add"))
         {
            _selectedBox.textField.text = _comboBoxArr[_currentIndex];
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _money = PlayerDressManager.instance.additionModel[_comboBoxArr.length - 3];
            alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.game.GameView.gypsyRMBTicketConfirm",_money),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,0);
            alertAsk.addEventListener("response",__alertAllBack);
            return;
         }
         _currentIndex = _comboBoxArr.indexOf(event.cellValue);
         PlayerDressManager.instance.currentIndex = _currentIndex;
         updateModel();
         updateComboBox(event.cellValue);
      }
      
      private function __alertAllBack(event:FrameEvent) : void
      {
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertAllBack);
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(frame.isBand,_money,SocketManager.Instance.out.addPlayerDressPay);
         }
         frame.dispose();
      }
      
      private function updateComboBox(obj:*) : void
      {
         var comboxModel:VectorListModel = _selectedBox.listPanel.vectorListModel;
         comboxModel.clear();
         comboxModel.appendAll(_comboBoxArr);
         comboxModel.remove(obj);
      }
      
      private function updateHideCheckBox() : void
      {
         _hideHatBtn.selected = _currentModel.model.getHatHide();
         _hideGlassBtn.selected = _currentModel.model.getGlassHide();
         _hideSuitBtn.selected = _currentModel.model.getSuitesHide();
         _hideWingBtn.selected = _currentModel.model.wingHide;
      }
      
      private function updateCharacter() : void
      {
         var i:int = 0;
         var itemId:int = 0;
         if(_currentModel.model)
         {
            if(!_character)
            {
               _character = CharactoryFactory.createCharacter(_currentModel.model,"room") as RoomCharacter;
               PositionUtils.setPos(_character,"playerDress.characterPos");
               _character.showGun = false;
               _character.show(false,-1);
               addChild(_character);
            }
         }
         i = 0;
         while(i < _dressCells.length)
         {
            itemId = DressUtils.getBagItems(i);
            if(_currentModel.model.Bag.items[itemId])
            {
               _dressCells[i].info = _currentModel.model.Bag.items[itemId];
            }
            else
            {
               _dressCells[i].info = null;
            }
            i++;
         }
      }
      
      public function setBtnsStatus() : void
      {
         if(_saveBtn)
         {
            _saveBtn.enable = canSaveBtnClick();
         }
         var enable:Boolean = canOKBtnClick();
         if(_okBtn)
         {
            enableOKBtn(enable);
         }
      }
      
      private function canSaveBtnClick() : Boolean
      {
         var i:int = 0;
         var c:int = 0;
         var item:* = null;
         var flag:Boolean = false;
         var j:int = 0;
         var vo:* = null;
         var dressArr:Array = PlayerDressManager.instance.modelArr[_currentIndex];
         if(!dressArr)
         {
            if(_currentModel.model.Bag.items.length == 0)
            {
               return false;
            }
            return true;
         }
         var arr:Array = dressArr.concat();
         i = 0;
         while(true)
         {
            if(i > 8 - 1)
            {
               if(arr.length == 0)
               {
                  return false;
               }
               return true;
            }
            c = DressUtils.getBagItems(i);
            item = _currentModel.model.Bag.items[c];
            if(item)
            {
               flag = true;
               for(j = 0; j <= arr.length - 1; )
               {
                  vo = arr[j];
                  if(item.ItemID == vo.itemId)
                  {
                     arr.splice(j,1);
                     flag = false;
                     break;
                  }
                  j++;
               }
               if(flag)
               {
                  break;
               }
            }
            i++;
         }
         return true;
      }
      
      private function canOKBtnClick() : Boolean
      {
         var i:int = 0;
         var index:int = 0;
         var modelItem:* = null;
         var bodyItem:* = null;
         for(i = 0; i <= 8 - 1; )
         {
            index = DressUtils.getBagItems(i);
            modelItem = _currentModel.model.Bag.items[index];
            bodyItem = _self.Bag.items[index];
            if(modelItem && !bodyItem && !checkOverDue(modelItem) || !modelItem && bodyItem || modelItem && bodyItem && modelItem.ItemID != bodyItem.ItemID)
            {
               if(PlayerManager.Instance.Self.Grade >= 3 && !PlayerManager.Instance.Self.IsWeakGuildFinish(107))
               {
                  NewHandContainer.Instance.showArrow(122,180,"playerDress.dressTipPos","","",this,0,true);
               }
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function checkOverDue(item:InventoryItemInfo) : Boolean
      {
         var d:* = 0;
         var nowDate:Date = TimeManager.Instance.Now();
         var begin:Date = DateUtils.getDateByStr(item.BeginDate);
         var diff:Number = Math.round((nowDate.getTime() - begin.getTime()) / 1000);
         if(diff >= 0)
         {
            d = uint(Math.floor(diff / 60 / 60 / 24));
         }
         if(diff < 0 || item.IsUsed == true && item.ValidDate > 0 && d >= item.ValidDate)
         {
            return true;
         }
         return false;
      }
      
      private function __hideWingClickHandler(event:Event) : void
      {
         _currentModel.model.wingHide = _hideWingBtn.selected;
      }
      
      private function __hideSuitesChange(event:Event) : void
      {
         _currentModel.model.setSuiteHide(_hideSuitBtn.selected);
      }
      
      private function __hideGlassChange(event:Event) : void
      {
         _currentModel.model.setGlassHide(_hideGlassBtn.selected);
      }
      
      private function __hideHatChange(event:Event) : void
      {
         _currentModel.model.setHatHide(_hideHatBtn.selected);
      }
      
      private function enableOKBtn(enable:Boolean) : void
      {
         _okBtn.enable = enable;
         if(enable)
         {
            if(_okBtnSprite)
            {
               _okBtnSprite.removeEventListener("mouseOver",__okBtnOverHandler);
               _okBtnSprite.removeEventListener("mouseOut",__okBtnOutHandler);
               ObjectUtils.disposeObject(_okBtnSprite);
               _okBtnSprite = null;
            }
         }
         else if(!_okBtnSprite)
         {
            _okBtnSprite = new Sprite();
            _okBtnSprite.addEventListener("mouseOver",__okBtnOverHandler);
            _okBtnSprite.addEventListener("mouseOut",__okBtnOutHandler);
            _okBtnSprite.graphics.beginFill(0,0);
            _okBtnSprite.graphics.drawRect(0,0,_okBtn.displayWidth,_okBtn.displayHeight);
            _okBtnSprite.graphics.endFill();
            _okBtnSprite.x = _okBtn.x - 1;
            _okBtnSprite.y = _okBtn.y + 3;
            addChild(_okBtnSprite);
            _okBtnTip = new OneLineTip();
            _okBtnTip.tipData = LanguageMgr.GetTranslation("playerDress.okBtnTip");
            _okBtnTip.visible = false;
         }
      }
      
      protected function __okBtnOverHandler(event:MouseEvent) : void
      {
         _okBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_okBtnTip,2);
         var pos:Point = _okBtn.localToGlobal(new Point(0,0));
         _okBtnTip.x = pos.x - 64;
         _okBtnTip.y = pos.y + _okBtn.height;
      }
      
      protected function __okBtnOutHandler(event:MouseEvent) : void
      {
         _okBtnTip.visible = false;
      }
      
      private function removeEvent() : void
      {
         _self.Bag.removeEventListener("update",__updateGoods);
         _hideHatBtn.removeEventListener("select",__hideHatChange);
         _hideGlassBtn.removeEventListener("select",__hideGlassChange);
         _hideSuitBtn.removeEventListener("select",__hideSuitesChange);
         _hideWingBtn.removeEventListener("select",__hideWingClickHandler);
         _selectedBox.listPanel.list.removeEventListener("listItemClick",__onListClick);
         _saveBtn.removeEventListener("click",__saveBtnClick);
         _okBtn.removeEventListener("click",__okBtnClick);
         if(_okBtnSprite)
         {
            _okBtnSprite.removeEventListener("mouseOver",__okBtnOverHandler);
            _okBtnSprite.removeEventListener("mouseOut",__okBtnOutHandler);
         }
         _uploadBtn.removeEventListener("click",__onUpLoadClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(237,8),__onAddIsSuccess);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         ComponentSetting.COMBOX_LIST_LAYER = LayerManager.Instance.getLayerByType(0);
         NewHandContainer.Instance.clearArrowByID(122);
         ObjectUtils.disposeObject(_BG);
         _BG = null;
         ObjectUtils.disposeObject(_hidePanel);
         _hidePanel = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         ObjectUtils.disposeObject(_okBtn);
         _okBtn = null;
         ObjectUtils.disposeObject(_okBtnSprite);
         _okBtnSprite = null;
         ObjectUtils.disposeObject(_okBtnTip);
         _okBtnTip = null;
         ObjectUtils.disposeObject(_selectedBox);
         _selectedBox = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_hideGlassBtn);
         _hideGlassBtn = null;
         ObjectUtils.disposeObject(_hideHatBtn);
         _hideHatBtn = null;
         ObjectUtils.disposeObject(_hideSuitBtn);
         _hideSuitBtn = null;
         ObjectUtils.disposeObject(_hideWingBtn);
         _hideWingBtn = null;
         ObjectUtils.disposeObject(_hideSprite);
         _hideSprite = null;
         ObjectUtils.disposeObject(_character);
         _character = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         for(i = 0; i <= 8 - 1; )
         {
            _dressCells[i].removeEventListener("doubleclick",__cellDoubleClick);
            ObjectUtils.disposeObject(_dressCells[i]);
            _dressCells[i] = null;
            i++;
         }
      }
   }
}
