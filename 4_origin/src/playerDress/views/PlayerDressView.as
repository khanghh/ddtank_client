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
         var _loc1_:int = 0;
         _currentIndex = PlayerDressManager.instance.currentIndex;
         _currentModel = new DressModel();
         _dressCells = new Vector.<BagCell>();
         _loc1_ = 1;
         while(_loc1_ <= PlayerDressManager.instance.currentModelNum)
         {
            _comboBoxArr.push(LanguageMgr.GetTranslation("playerDress.model" + _loc1_));
            _loc1_++;
         }
         if(PlayerDressManager.instance.currentModelNum < 6)
         {
            _comboBoxArr.push(LanguageMgr.GetTranslation("playerDress.add"));
         }
         PlayerDressManager.instance.currentModel = _currentModel;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ <= 8 - 1)
         {
            _loc1_ = new DressCell();
            CellFactory.instance.fillTipProp(_loc1_);
            _loc1_.doubleClickEnabled = true;
            _loc1_.addEventListener("doubleclick",__cellDoubleClick);
            PositionUtils.setPos(_loc1_,"playerDress.cellPos" + _loc2_);
            _dressCells.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
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
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc8_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
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
         var _loc6_:Array = PlayerDressManager.instance.modelArr[_currentIndex];
         var _loc3_:Boolean = false;
         if(_loc6_)
         {
            _loc8_ = 0;
            while(_loc8_ <= _loc6_.length - 1)
            {
               _loc1_ = (_loc6_[_loc8_] as DressVo).templateId;
               _loc5_ = (_loc6_[_loc8_] as DressVo).itemId;
               _loc2_ = new InventoryItemInfo();
               _loc4_ = _self.Bag.getItemByItemId(_loc5_);
               if(!_loc4_)
               {
                  _loc4_ = _self.Bag.getItemByTemplateId(_loc1_);
                  _loc3_ = true;
               }
               if(_loc4_)
               {
                  _loc2_.setIsUsed(_loc4_.IsUsed);
                  ObjectUtils.copyProperties(_loc2_,_loc4_);
                  _loc7_ = DressUtils.findItemPlace(_loc2_);
                  _bodyThings.add(_loc7_,_loc2_);
                  if(_loc2_.CategoryID == 6)
                  {
                     _currentModel.model.Skin = _loc2_.Skin;
                  }
                  _currentModel.model.setPartStyle(_loc2_.CategoryID,_loc2_.NeedSex,_loc2_.TemplateID,_loc2_.Color);
               }
               _loc8_++;
            }
         }
         _currentModel.model.Bag.items = _bodyThings;
         if(_loc3_)
         {
            saveModel();
         }
         setBtnsStatus();
         updateCharacter();
         updateHideCheckBox();
      }
      
      public function putOnDress(param1:InventoryItemInfo) : void
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.setIsUsed(param1.IsUsed);
         ObjectUtils.copyProperties(_loc2_,param1);
         var _loc3_:int = DressUtils.findItemPlace(_loc2_);
         _currentModel.model.Bag.items.add(_loc3_,_loc2_);
         if(_loc2_.CategoryID == 6)
         {
            _currentModel.model.Skin = _loc2_.Skin;
         }
         _currentModel.model.setPartStyle(_loc2_.CategoryID,_loc2_.NeedSex,_loc2_.TemplateID,_loc2_.Color);
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
      
      private function __onAddIsSuccess(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         if(_loc2_)
         {
            _loc4_ = LanguageMgr.GetTranslation("playerDress.add.success");
            MessageTipManager.getInstance().show(_loc4_,0,true,1);
            PlayerDressManager.instance.currentModelNum = PlayerDressManager.instance.currentModelNum + 1;
            _comboBoxArr.splice(PlayerDressManager.instance.currentModelNum - 1,PlayerDressManager.instance.currentModelNum == 6?1:0,LanguageMgr.GetTranslation("playerDress.model" + PlayerDressManager.instance.currentModelNum));
            _selectedBox.textField.text = _comboBoxArr[_currentIndex];
            updateComboBox(_comboBoxArr[_currentIndex]);
            updateModel();
         }
      }
      
      protected function __onUpLoadClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
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
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("draftView.uploadStyle.info",DraftModel.UploadNum,_stylePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false);
            _loc2_.addEventListener("response",onBuyConfirmResponse);
         }
      }
      
      private function onBuyConfirmResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",onBuyConfirmResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,_stylePrice,onCheckComplete);
         }
         _loc2_.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.uploadDraftStyle(_currentModel.model.Style,_currentModel.model.Colors + "#" + _currentModel.model.Skin);
      }
      
      protected function __updateGoods(param1:BagEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc12_:int = 0;
         var _loc11_:* = _currentModel.model.Bag.items;
         for(var _loc8_ in _currentModel.model.Bag.items)
         {
            _loc5_ = _currentModel.model.Bag.items[_loc8_];
            if(_loc5_)
            {
               var _loc10_:int = 0;
               var _loc9_:* = _loc4_;
               for(var _loc7_ in _loc4_)
               {
                  _loc6_ = _loc4_[_loc7_];
                  if(_self.Bag.items[_loc7_])
                  {
                     if(_loc5_.ItemID != 0 && _loc5_.ItemID == _loc6_.ItemID || _loc5_.ItemID == 0 && _loc5_.TemplateID == _loc6_.TemplateID)
                     {
                        _loc3_ = new InventoryItemInfo();
                        _loc3_.setIsUsed(_loc6_.IsUsed);
                        ObjectUtils.copyProperties(_loc3_,_loc6_);
                        _currentModel.model.Bag.items[_loc8_] = _loc3_;
                        _loc2_ = DressUtils.getBagItems(int(_loc8_),true);
                        if(_dressCells[_loc2_])
                        {
                           _dressCells[_loc2_].info = _loc3_;
                        }
                     }
                  }
               }
               continue;
            }
         }
         setBtnsStatus();
      }
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         _loc5_ = 0;
         while(_loc5_ <= 8 - 1)
         {
            if(_dressCells[_loc5_] == param1.target)
            {
               _loc3_ = DressUtils.getBagItems(_loc5_);
               _loc4_ = _currentModel.model.Bag.items[_loc3_];
               _loc2_ = !!_self.Sex?1:2;
               _currentModel.model.setPartStyle(_loc4_.CategoryID,_loc2_);
               if(_loc4_.CategoryID == 6)
               {
                  _currentModel.model.Skin = "";
               }
               _currentModel.model.Bag.items[_loc3_] = null;
               _dressCells[_loc5_].info = null;
            }
            _loc5_++;
         }
         setBtnsStatus();
      }
      
      protected function __okBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         enableOKBtn(false);
         saveBtnClick = false;
         _loc4_ = 0;
         while(_loc4_ <= 8 - 1)
         {
            _loc3_ = _dressCells[_loc4_] as BagCell;
            if(_loc3_.info && (_loc3_.info.BindType == 1 || _loc3_.info.BindType == 2 || _loc3_.info.BindType == 3) && _loc3_.itemInfo.IsBinds == false)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               _loc2_.addEventListener("response",__onResponse);
               return;
            }
            _loc4_++;
         }
         save();
         exchangeProperty();
      }
      
      private function exchangeProperty() : void
      {
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         PlayerDressControl.instance.lockDressBag();
         var _loc5_:BagInfo = PlayerManager.Instance.Self.Bag;
         var _loc2_:Boolean = false;
         _loc8_ = 0;
         while(_loc8_ <= 8 - 1)
         {
            _loc4_ = DressUtils.getBagItems(_loc8_);
            _loc3_ = _currentModel.model.Bag.items[_loc4_];
            _loc1_ = _self.Bag.items[_loc4_];
            if(_loc3_ && checkOverDue(_loc3_))
            {
               _loc3_ = null;
            }
            if(_loc3_ && _loc1_)
            {
               _loc6_ = _loc3_.Place;
               _loc7_ = _loc1_.Place;
               if(_loc6_ != _loc7_)
               {
                  if(DressUtils.hasNoAddition(_loc1_))
                  {
                     SocketManager.Instance.out.sendMoveGoods(0,_loc6_,0,_loc7_,1,true);
                  }
                  else if(PlayerManager.Instance.Self.Gold < 5000)
                  {
                     _loc2_ = true;
                     SocketManager.Instance.out.sendMoveGoods(0,_loc6_,0,_loc7_,1,true);
                  }
                  else
                  {
                     SocketManager.Instance.out.sendItemTransfer(true,true,0,_loc6_,0,_loc7_);
                     SocketManager.Instance.out.sendMoveGoods(0,_loc6_,0,_loc7_,1,true);
                  }
               }
            }
            else if(!_loc3_ && _loc1_)
            {
               SocketManager.Instance.out.sendMoveGoods(0,_loc1_.Place,0,-1,1,true);
            }
            else if(_loc3_ && !_loc1_)
            {
               SocketManager.Instance.out.sendMoveGoods(0,_loc3_.Place,0,_loc4_,1,true);
            }
            _loc8_++;
         }
         SocketManager.Instance.out.setCurrentModel(_currentIndex);
         SocketManager.Instance.out.lockDressBag();
         if(_loc2_)
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
      
      protected function __saveBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         saveBtnClick = true;
         _loc4_ = 0;
         while(_loc4_ <= 8 - 1)
         {
            _loc3_ = _dressCells[_loc4_] as BagCell;
            if(_loc3_.info && (_loc3_.info.BindType == 1 || _loc3_.info.BindType == 2 || _loc3_.info.BindType == 3) && _loc3_.itemInfo.IsBinds == false)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               _loc2_.addEventListener("response",__onResponse);
               return;
            }
            _loc4_++;
         }
         save();
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse);
         _loc2_.dispose();
         switch(int(param1.responseCode))
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
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ <= 8 - 1)
         {
            _loc1_ = DressUtils.getBagItems(_loc4_);
            _loc2_ = _currentModel.model.Bag.items[_loc1_];
            if(_loc2_)
            {
               _loc3_.push(_loc2_.Place);
            }
            _loc4_++;
         }
         SocketManager.Instance.out.saveDressModel(_currentIndex,_loc3_);
      }
      
      protected function __onListClick(param1:ListItemEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_currentIndex == _comboBoxArr.indexOf(param1.cellValue))
         {
            return;
         }
         if(param1.cellValue == LanguageMgr.GetTranslation("playerDress.add"))
         {
            _selectedBox.textField.text = _comboBoxArr[_currentIndex];
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _money = PlayerDressManager.instance.additionModel[_comboBoxArr.length - 3];
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.game.GameView.gypsyRMBTicketConfirm",_money),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,0);
            _loc2_.addEventListener("response",__alertAllBack);
            return;
         }
         _currentIndex = _comboBoxArr.indexOf(param1.cellValue);
         PlayerDressManager.instance.currentIndex = _currentIndex;
         updateModel();
         updateComboBox(param1.cellValue);
      }
      
      private function __alertAllBack(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__alertAllBack);
         SoundManager.instance.playButtonSound();
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,_money,SocketManager.Instance.out.addPlayerDressPay);
         }
         _loc2_.dispose();
      }
      
      private function updateComboBox(param1:*) : void
      {
         var _loc2_:VectorListModel = _selectedBox.listPanel.vectorListModel;
         _loc2_.clear();
         _loc2_.appendAll(_comboBoxArr);
         _loc2_.remove(param1);
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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
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
         _loc2_ = 0;
         while(_loc2_ < _dressCells.length)
         {
            _loc1_ = DressUtils.getBagItems(_loc2_);
            if(_currentModel.model.Bag.items[_loc1_])
            {
               _dressCells[_loc2_].info = _currentModel.model.Bag.items[_loc1_];
            }
            else
            {
               _dressCells[_loc2_].info = null;
            }
            _loc2_++;
         }
      }
      
      public function setBtnsStatus() : void
      {
         if(_saveBtn)
         {
            _saveBtn.enable = canSaveBtnClick();
         }
         var _loc1_:Boolean = canOKBtnClick();
         if(_okBtn)
         {
            enableOKBtn(_loc1_);
         }
      }
      
      private function canSaveBtnClick() : Boolean
      {
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc7_:* = null;
         var _loc6_:Array = PlayerDressManager.instance.modelArr[_currentIndex];
         if(!_loc6_)
         {
            if(_currentModel.model.Bag.items.length == 0)
            {
               return false;
            }
            return true;
         }
         var _loc3_:Array = _loc6_.concat();
         _loc8_ = 0;
         while(true)
         {
            if(_loc8_ > 8 - 1)
            {
               if(_loc3_.length == 0)
               {
                  return false;
               }
               return true;
            }
            _loc2_ = DressUtils.getBagItems(_loc8_);
            _loc4_ = _currentModel.model.Bag.items[_loc2_];
            if(_loc4_)
            {
               _loc1_ = true;
               _loc5_ = 0;
               while(_loc5_ <= _loc3_.length - 1)
               {
                  _loc7_ = _loc3_[_loc5_];
                  if(_loc4_.ItemID == _loc7_.itemId)
                  {
                     _loc3_.splice(_loc5_,1);
                     _loc1_ = false;
                     break;
                  }
                  _loc5_++;
               }
               if(_loc1_)
               {
                  break;
               }
            }
            _loc8_++;
         }
         return true;
      }
      
      private function canOKBtnClick() : Boolean
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ <= 8 - 1)
         {
            _loc1_ = DressUtils.getBagItems(_loc4_);
            _loc2_ = _currentModel.model.Bag.items[_loc1_];
            _loc3_ = _self.Bag.items[_loc1_];
            if(_loc2_ && !_loc3_ && !checkOverDue(_loc2_) || !_loc2_ && _loc3_ || _loc2_ && _loc3_ && _loc2_.ItemID != _loc3_.ItemID)
            {
               if(PlayerManager.Instance.Self.Grade >= 3 && !PlayerManager.Instance.Self.IsWeakGuildFinish(107))
               {
                  NewHandContainer.Instance.showArrow(122,180,"playerDress.dressTipPos","","",this,0,true);
               }
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private function checkOverDue(param1:InventoryItemInfo) : Boolean
      {
         var _loc2_:* = 0;
         var _loc4_:Date = TimeManager.Instance.Now();
         var _loc5_:Date = DateUtils.getDateByStr(param1.BeginDate);
         var _loc3_:Number = Math.round((_loc4_.getTime() - _loc5_.getTime()) / 1000);
         if(_loc3_ >= 0)
         {
            _loc2_ = uint(Math.floor(_loc3_ / 60 / 60 / 24));
         }
         if(_loc3_ < 0 || param1.IsUsed == true && param1.ValidDate > 0 && _loc2_ >= param1.ValidDate)
         {
            return true;
         }
         return false;
      }
      
      private function __hideWingClickHandler(param1:Event) : void
      {
         _currentModel.model.wingHide = _hideWingBtn.selected;
      }
      
      private function __hideSuitesChange(param1:Event) : void
      {
         _currentModel.model.setSuiteHide(_hideSuitBtn.selected);
      }
      
      private function __hideGlassChange(param1:Event) : void
      {
         _currentModel.model.setGlassHide(_hideGlassBtn.selected);
      }
      
      private function __hideHatChange(param1:Event) : void
      {
         _currentModel.model.setHatHide(_hideHatBtn.selected);
      }
      
      private function enableOKBtn(param1:Boolean) : void
      {
         _okBtn.enable = param1;
         if(param1)
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
      
      protected function __okBtnOverHandler(param1:MouseEvent) : void
      {
         _okBtnTip.visible = true;
         LayerManager.Instance.addToLayer(_okBtnTip,2);
         var _loc2_:Point = _okBtn.localToGlobal(new Point(0,0));
         _okBtnTip.x = _loc2_.x - 64;
         _okBtnTip.y = _loc2_.y + _okBtn.height;
      }
      
      protected function __okBtnOutHandler(param1:MouseEvent) : void
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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ <= 8 - 1)
         {
            _dressCells[_loc1_].removeEventListener("doubleclick",__cellDoubleClick);
            ObjectUtils.disposeObject(_dressCells[_loc1_]);
            _dressCells[_loc1_] = null;
            _loc1_++;
         }
      }
   }
}
