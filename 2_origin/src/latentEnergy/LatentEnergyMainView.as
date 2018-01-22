package latentEnergy
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class LatentEnergyMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _replaceBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      protected var _bagPanel:ScrollPanel;
      
      private var _bagList:LatentEnergyBagListView;
      
      private var _proBagList:LatentEnergyBagListView;
      
      private var _leftDrapSprite:LatentEnergyLeftDragSprite;
      
      private var _rightDrapSprite:LatentEnergyRightDragSprite;
      
      private var _itemPlace:int;
      
      private var _itemCell:LatentEnergyItemCell;
      
      private var _equipCell:LatentEnergyEquipCell;
      
      private var _moreLessIconMcList:Vector.<MovieClip>;
      
      private var _leftProTxtList:Vector.<FilterFrameText>;
      
      private var _rightProTxtList:Vector.<FilterFrameText>;
      
      private var _noProTxt:String;
      
      private var _delayIndex:int;
      
      private var _equipBagInfo:BagInfo;
      
      private var _isDispose:Boolean = false;
      
      public function LatentEnergyMainView()
      {
         super();
         this.mouseEnabled = false;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("latentenergy");
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "latentenergy")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "latentenergy")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            initThis();
         }
      }
      
      private function initThis() : void
      {
         initView();
         initEvent();
         createAcceptDragSprite();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.latentEnergyFrame.bg");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("latentEnergyFrame.openBtn");
         _openBtn.enable = false;
         _replaceBtn = ComponentFactory.Instance.creatComponentByStylename("latentEnergyFrame.replaceBtn");
         _replaceBtn.enable = false;
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"latentEnergyFrame.helpBtn",null,LanguageMgr.GetTranslation("ddt.latentEnergy.helpTitle"),"latentEnergy.helpFrame.text",404,484) as SimpleBitmapButton;
         _bagList = new LatentEnergyBagListView(0,7,21,true);
         _bagPanel = ComponentFactory.Instance.creat("ddtstore.LatentEnergyBagListView.BagScrollPanel");
         addChild(_bagPanel);
         _bagPanel.setView(_bagList);
         _bagPanel.invalidateViewport();
         refreshBagList();
         _proBagList = new LatentEnergyBagListView(1,7,21);
         PositionUtils.setPos(_proBagList,"latentEnergyFrame.proBagListPos");
         _proBagList.setData(LatentEnergyManager.instance.getLatentEnergyItemData());
         _equipCell = new LatentEnergyEquipCell(0,null,true,new Bitmap(new BitmapData(60,60,true,0)),false);
         _equipCell.BGVisible = false;
         PositionUtils.setPos(_equipCell,"latentEnergyFrame.equipCellPos");
         _itemCell = new LatentEnergyItemCell(_itemPlace,null,true,new Bitmap(new BitmapData(60,60,true,0)),false);
         PositionUtils.setPos(_itemCell,"latentEnergyFrame.itemCellPos");
         _itemCell.BGVisible = false;
         addChild(_bg);
         addChild(_openBtn);
         addChild(_replaceBtn);
         addChild(_proBagList);
         addChild(_equipCell);
         addChild(_itemCell);
         createTxtView();
      }
      
      private function refreshBagList() : void
      {
         _equipBagInfo = LatentEnergyManager.instance.getCanLatentEnergyData();
         _bagList.setData(_equipBagInfo);
      }
      
      private function createTxtView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _noProTxt = LanguageMgr.GetTranslation("ddt.latentEnergy.oldProNoTxt");
         _leftProTxtList = new Vector.<FilterFrameText>(4);
         _rightProTxtList = new Vector.<FilterFrameText>(4);
         _moreLessIconMcList = new Vector.<MovieClip>(4);
         _loc4_ = 1;
         while(_loc4_ <= 4)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("latentEnergyFrame.leftProTxt");
            PositionUtils.setPos(_loc3_,"latentEnergyFrame.leftProTxtPos" + _loc4_);
            _loc3_.visible = false;
            addChild(_loc3_);
            _leftProTxtList[_loc4_ - 1] = _loc3_;
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("latentEnergyFrame.rightProTxt");
            PositionUtils.setPos(_loc1_,"latentEnergyFrame.rightProTxtPos" + _loc4_);
            _loc1_.visible = false;
            addChild(_loc1_);
            _rightProTxtList[_loc4_ - 1] = _loc1_;
            _loc2_ = ComponentFactory.Instance.creat("asset.latentEnergyFrame.moreLessIcon");
            PositionUtils.setPos(_loc2_,"latentEnergyFrame.moreLessIconPos" + _loc4_);
            _loc2_.gotoAndStop(3);
            addChild(_loc2_);
            _moreLessIconMcList[_loc4_ - 1] = _loc2_;
            _loc4_++;
         }
      }
      
      public function set itemPlace(param1:int) : void
      {
         _itemPlace = param1;
         var _loc2_:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.items[_itemPlace] as InventoryItemInfo;
         _itemCell = new LatentEnergyItemCell(_itemPlace,_loc2_,true,new Bitmap(new BitmapData(60,60,true,0)),false);
         PositionUtils.setPos(_itemCell,"latentEnergyFrame.itemCellPos");
         _itemCell.BGVisible = false;
         addChild(_itemCell);
         _equipCell.latentEnergyItemId = _loc2_.TemplateID;
      }
      
      private function createAcceptDragSprite() : void
      {
         _leftDrapSprite = new LatentEnergyLeftDragSprite();
         _leftDrapSprite.mouseEnabled = false;
         _leftDrapSprite.mouseChildren = false;
         _leftDrapSprite.graphics.beginFill(0,0);
         _leftDrapSprite.graphics.drawRect(0,0,347,404);
         _leftDrapSprite.graphics.endFill();
         PositionUtils.setPos(_leftDrapSprite,"latentEnergyFrame.leftDrapSpritePos");
         addChild(_leftDrapSprite);
         _rightDrapSprite = new LatentEnergyRightDragSprite();
         _rightDrapSprite.mouseEnabled = false;
         _rightDrapSprite.mouseChildren = false;
         _rightDrapSprite.graphics.beginFill(0,0);
         _rightDrapSprite.graphics.drawRect(0,0,374,407);
         _rightDrapSprite.graphics.endFill();
         PositionUtils.setPos(_rightDrapSprite,"latentEnergyFrame.rightDrapSpritePos");
         addChild(_rightDrapSprite);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _openBtn.addEventListener("click",openHandler,false,0,true);
         _replaceBtn.addEventListener("click",replaceHandler,false,0,true);
         _bagList.addEventListener("itemclick",cellClickHandler,false,0,true);
         _bagList.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _equipCell.addEventListener("change",equipChangeHandler,false,0,true);
         _proBagList.addEventListener("itemclick",cellClickHandler,false,0,true);
         _proBagList.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _itemCell.addEventListener("change",itemChangeHandler,false,0,true);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",propInfoChangeHandler);
         PlayerManager.Instance.Self.Bag.addEventListener("update",bagInfoChangeHandler);
         LatentEnergyManager.instance.addEventListener("latentEnergy_equip_change",equipInfoChangeHandler);
      }
      
      private function bagInfoChangeHandler(param1:BagEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc3_ = _loc5_;
         }
         if(_loc3_ && !PlayerManager.Instance.Self.Bag.items[_loc3_.Place])
         {
            if(_equipCell.info && (_equipCell.info as InventoryItemInfo).Place == _loc3_.Place)
            {
               _equipCell.info = null;
            }
            else
            {
               refreshBagList();
            }
         }
         else
         {
            _loc2_ = LatentEnergyManager.instance.getCanLatentEnergyData();
            if(_loc2_.items.length != _equipBagInfo.items.length)
            {
               _equipBagInfo = _loc2_;
               _bagList.setData(_equipBagInfo);
            }
         }
      }
      
      private function equipInfoChangeHandler(param1:Event) : void
      {
         refreshCurProView();
         refreshNewProView();
      }
      
      private function propInfoChangeHandler(param1:BagEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc3_ = _loc5_;
         }
         if(_loc3_ && !PlayerManager.Instance.Self.PropBag.items[_loc3_.Place])
         {
            if(_itemCell.info && (_itemCell.info as InventoryItemInfo).Place == _loc3_.Place)
            {
               _itemCell.info = null;
            }
            else
            {
               _proBagList.setData(LatentEnergyManager.instance.getLatentEnergyItemData());
            }
         }
         else
         {
            if(!_itemCell || !_itemCell.info)
            {
               return;
            }
            _loc2_ = _itemCell.info as InventoryItemInfo;
            if(!PlayerManager.Instance.Self.PropBag.items[_loc2_.Place])
            {
               _itemCell.info = null;
            }
            else
            {
               _itemCell.setCount(_loc2_.Count);
            }
         }
      }
      
      private function openHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!_equipCell.info)
         {
            return;
         }
         if(!_itemCell.info)
         {
            return;
         }
         if((_itemCell.info as InventoryItemInfo).Count <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.latentEnergy.noEnoughItem"));
            return;
         }
         if(!(_equipCell.info as InventoryItemInfo).IsBinds)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.latentEnergy.bindTipTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            _loc2_.moveEnable = false;
            _loc2_.addEventListener("response",__confirm,false,0,true);
         }
         else
         {
            doOpenHandler();
         }
      }
      
      private function doOpenHandler() : void
      {
         var _loc1_:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         var _loc2_:InventoryItemInfo = _itemCell.info as InventoryItemInfo;
         SocketManager.Instance.out.sendLatentEnergy(1,_loc1_.BagType,_loc1_.Place,_loc2_.BagType,_loc2_.Place);
         _openBtn.enable = false;
         _delayIndex = setTimeout(openBtnEnableHandler,1000);
      }
      
      private function __confirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__confirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            doOpenHandler();
         }
      }
      
      private function openBtnEnableHandler() : void
      {
         if(_equipCell && _openBtn && _itemCell)
         {
            if(_equipCell.info && _itemCell.info)
            {
               _openBtn.enable = true;
            }
            else
            {
               _openBtn.enable = false;
            }
         }
      }
      
      private function replaceHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_equipCell.info)
         {
            return;
         }
         if(!(_equipCell.info as InventoryItemInfo).isHasLatenetEnergyNew)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.latentEnergy.noNewProperty"));
            _replaceBtn.enable = false;
            return;
         }
         var _loc2_:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         SocketManager.Instance.out.sendLatentEnergy(2,_loc2_.BagType,_loc2_.Place);
      }
      
      private function itemChangeHandler(param1:Event) : void
      {
         if(_itemCell.info)
         {
            _equipCell.latentEnergyItemId = _itemCell.info.TemplateID;
         }
         else
         {
            _equipCell.latentEnergyItemId = 0;
         }
         equipChangeHandler(null);
      }
      
      private function equipChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_equipCell.info)
         {
            refreshCurProView();
            refreshNewProView();
         }
         else
         {
            _replaceBtn.enable = false;
            _loc2_ = 0;
            while(_loc2_ < 4)
            {
               _leftProTxtList[_loc2_].visible = false;
               _rightProTxtList[_loc2_].visible = false;
               _moreLessIconMcList[_loc2_].gotoAndStop(3);
               _loc2_++;
            }
         }
         if(_equipCell.info && _itemCell.info)
         {
            _openBtn.enable = true;
         }
         else
         {
            _openBtn.enable = false;
         }
      }
      
      private function refreshCurProView() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!_equipCell.info)
         {
            return;
         }
         var _loc1_:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         if(_loc1_.isHasLatentEnergy)
         {
            _loc2_ = _loc1_.latentEnergyCurList;
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               _leftProTxtList[_loc3_].text = _loc2_[_loc3_];
               _leftProTxtList[_loc3_].visible = true;
               _loc3_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               _leftProTxtList[_loc4_].text = _noProTxt;
               _leftProTxtList[_loc4_].visible = true;
               _loc4_++;
            }
         }
      }
      
      private function refreshNewProView() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!_equipCell.info)
         {
            return;
         }
         var _loc1_:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         if(_loc1_.isHasLatenetEnergyNew)
         {
            _replaceBtn.enable = true;
            _loc3_ = _loc1_.latentEnergyNewList;
            _loc2_ = _loc1_.latentEnergyCurList;
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               _rightProTxtList[_loc4_].text = _loc3_[_loc4_];
               _rightProTxtList[_loc4_].visible = true;
               if(int(_loc3_[_loc4_]) > int(_loc2_[_loc4_]))
               {
                  _moreLessIconMcList[_loc4_].gotoAndStop(1);
               }
               else if(int(_loc3_[_loc4_]) == int(_loc2_[_loc4_]))
               {
                  _moreLessIconMcList[_loc4_].gotoAndStop(3);
               }
               else if(int(_loc3_[_loc4_]) < int(_loc2_[_loc4_]))
               {
                  _moreLessIconMcList[_loc4_].gotoAndStop(2);
               }
               _loc4_++;
            }
         }
         else
         {
            _replaceBtn.enable = false;
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               _rightProTxtList[_loc5_].visible = false;
               _moreLessIconMcList[_loc5_].gotoAndStop(3);
               _loc5_++;
            }
         }
      }
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:String = "";
         if(param1.target == _proBagList)
         {
            _loc2_ = "latentEnergy_item_move";
         }
         else
         {
            _loc2_ = "latentEnergy_equip_move";
         }
         var _loc3_:LatentEnergyEvent = new LatentEnergyEvent(_loc2_);
         var _loc4_:BagCell = param1.data as BagCell;
         _loc3_.info = _loc4_.info as InventoryItemInfo;
         _loc3_.moveType = 1;
         LatentEnergyManager.instance.dispatchEvent(_loc3_);
      }
      
      private function cellClickHandler(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BagCell = param1.data as BagCell;
         _loc2_.dragStart();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         .super.visible = param1;
         if(param1)
         {
            if(!_isDispose)
            {
               refreshListData();
               PlayerManager.Instance.Self.PropBag.addEventListener("update",propInfoChangeHandler);
               PlayerManager.Instance.Self.Bag.addEventListener("update",bagInfoChangeHandler);
            }
         }
         else
         {
            clearCellInfo();
            PlayerManager.Instance.Self.PropBag.removeEventListener("update",propInfoChangeHandler);
            PlayerManager.Instance.Self.Bag.removeEventListener("update",bagInfoChangeHandler);
         }
      }
      
      public function clearCellInfo() : void
      {
         if(_equipCell)
         {
            _equipCell.clearInfo();
         }
         if(_itemCell)
         {
            _itemCell.clearInfo();
         }
      }
      
      public function refreshListData() : void
      {
         if(_bagList)
         {
            refreshBagList();
         }
         if(_proBagList)
         {
            _proBagList.setData(LatentEnergyManager.instance.getLatentEnergyItemData());
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_openBtn != null)
         {
            _openBtn.removeEventListener("click",openHandler);
         }
         if(_replaceBtn != null)
         {
            _replaceBtn.removeEventListener("click",replaceHandler);
         }
         if(_bagList != null)
         {
            _bagList.removeEventListener("itemclick",cellClickHandler);
            _bagList.removeEventListener("doubleclick",__cellDoubleClick);
         }
         if(_equipCell != null)
         {
            _equipCell.removeEventListener("change",equipChangeHandler);
         }
         if(_proBagList != null)
         {
            _proBagList.removeEventListener("itemclick",cellClickHandler);
            _proBagList.removeEventListener("doubleclick",__cellDoubleClick);
         }
         if(_itemCell != null)
         {
            _itemCell.removeEventListener("change",itemChangeHandler);
         }
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",propInfoChangeHandler);
         PlayerManager.Instance.Self.Bag.removeEventListener("update",bagInfoChangeHandler);
         LatentEnergyManager.instance.removeEventListener("latentEnergy_equip_change",equipInfoChangeHandler);
      }
      
      public function dispose() : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         removeEvent();
         clearTimeout(_delayIndex);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _openBtn = null;
         _replaceBtn = null;
         _helpBtn = null;
         _bagList = null;
         _proBagList = null;
         _leftDrapSprite = null;
         _rightDrapSprite = null;
         _itemCell = null;
         _equipCell = null;
         _moreLessIconMcList = null;
         _leftProTxtList = null;
         _rightProTxtList = null;
         _noProTxt = null;
         _equipBagInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _isDispose = true;
      }
   }
}
