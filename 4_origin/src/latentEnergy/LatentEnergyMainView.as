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
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "latentenergy")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "latentenergy")
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
         var i:int = 0;
         var tmpTxt:* = null;
         var tmpTxt2:* = null;
         var tmpMc:* = null;
         _noProTxt = LanguageMgr.GetTranslation("ddt.latentEnergy.oldProNoTxt");
         _leftProTxtList = new Vector.<FilterFrameText>(4);
         _rightProTxtList = new Vector.<FilterFrameText>(4);
         _moreLessIconMcList = new Vector.<MovieClip>(4);
         for(i = 1; i <= 4; )
         {
            tmpTxt = ComponentFactory.Instance.creatComponentByStylename("latentEnergyFrame.leftProTxt");
            PositionUtils.setPos(tmpTxt,"latentEnergyFrame.leftProTxtPos" + i);
            tmpTxt.visible = false;
            addChild(tmpTxt);
            _leftProTxtList[i - 1] = tmpTxt;
            tmpTxt2 = ComponentFactory.Instance.creatComponentByStylename("latentEnergyFrame.rightProTxt");
            PositionUtils.setPos(tmpTxt2,"latentEnergyFrame.rightProTxtPos" + i);
            tmpTxt2.visible = false;
            addChild(tmpTxt2);
            _rightProTxtList[i - 1] = tmpTxt2;
            tmpMc = ComponentFactory.Instance.creat("asset.latentEnergyFrame.moreLessIcon");
            PositionUtils.setPos(tmpMc,"latentEnergyFrame.moreLessIconPos" + i);
            tmpMc.gotoAndStop(3);
            addChild(tmpMc);
            _moreLessIconMcList[i - 1] = tmpMc;
            i++;
         }
      }
      
      public function set itemPlace(place:int) : void
      {
         _itemPlace = place;
         var itemInfo:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.items[_itemPlace] as InventoryItemInfo;
         _itemCell = new LatentEnergyItemCell(_itemPlace,itemInfo,true,new Bitmap(new BitmapData(60,60,true,0)),false);
         PositionUtils.setPos(_itemCell,"latentEnergyFrame.itemCellPos");
         _itemCell.BGVisible = false;
         addChild(_itemCell);
         _equipCell.latentEnergyItemId = itemInfo.TemplateID;
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
      
      private function bagInfoChangeHandler(event:BagEvent) : void
      {
         var changeItemInfo:* = null;
         var tmp2:* = null;
         var changedSlots:Dictionary = event.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = changedSlots;
         for each(var tmp in changedSlots)
         {
            changeItemInfo = tmp;
         }
         if(changeItemInfo && !PlayerManager.Instance.Self.Bag.items[changeItemInfo.Place])
         {
            if(_equipCell.info && (_equipCell.info as InventoryItemInfo).Place == changeItemInfo.Place)
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
            tmp2 = LatentEnergyManager.instance.getCanLatentEnergyData();
            if(tmp2.items.length != _equipBagInfo.items.length)
            {
               _equipBagInfo = tmp2;
               _bagList.setData(_equipBagInfo);
            }
         }
      }
      
      private function equipInfoChangeHandler(event:Event) : void
      {
         refreshCurProView();
         refreshNewProView();
      }
      
      private function propInfoChangeHandler(event:BagEvent) : void
      {
         var changeItemInfo:* = null;
         var tmpItemInfo:* = null;
         var changedSlots:Dictionary = event.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = changedSlots;
         for each(var tmp in changedSlots)
         {
            changeItemInfo = tmp;
         }
         if(changeItemInfo && !PlayerManager.Instance.Self.PropBag.items[changeItemInfo.Place])
         {
            if(_itemCell.info && (_itemCell.info as InventoryItemInfo).Place == changeItemInfo.Place)
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
            tmpItemInfo = _itemCell.info as InventoryItemInfo;
            if(!PlayerManager.Instance.Self.PropBag.items[tmpItemInfo.Place])
            {
               _itemCell.info = null;
            }
            else
            {
               _itemCell.setCount(tmpItemInfo.Count);
            }
         }
      }
      
      private function openHandler(event:MouseEvent) : void
      {
         var confirmFrame:* = null;
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
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.latentEnergy.bindTipTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",__confirm,false,0,true);
         }
         else
         {
            doOpenHandler();
         }
      }
      
      private function doOpenHandler() : void
      {
         var equipInfo:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         var itemInfo:InventoryItemInfo = _itemCell.info as InventoryItemInfo;
         SocketManager.Instance.out.sendLatentEnergy(1,equipInfo.BagType,equipInfo.Place,itemInfo.BagType,itemInfo.Place);
         _openBtn.enable = false;
         _delayIndex = setTimeout(openBtnEnableHandler,1000);
      }
      
      private function __confirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__confirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
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
      
      private function replaceHandler(event:MouseEvent) : void
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
         var equipInfo:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         SocketManager.Instance.out.sendLatentEnergy(2,equipInfo.BagType,equipInfo.Place);
      }
      
      private function itemChangeHandler(event:Event) : void
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
      
      private function equipChangeHandler(event:Event) : void
      {
         var i:int = 0;
         if(_equipCell.info)
         {
            refreshCurProView();
            refreshNewProView();
         }
         else
         {
            _replaceBtn.enable = false;
            for(i = 0; i < 4; )
            {
               _leftProTxtList[i].visible = false;
               _rightProTxtList[i].visible = false;
               _moreLessIconMcList[i].gotoAndStop(3);
               i++;
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
         var tmpValueArray:* = null;
         var k:int = 0;
         var i:int = 0;
         if(!_equipCell.info)
         {
            return;
         }
         var tmpItemInfo:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         if(tmpItemInfo.isHasLatentEnergy)
         {
            tmpValueArray = tmpItemInfo.latentEnergyCurList;
            for(k = 0; k < 4; )
            {
               _leftProTxtList[k].text = tmpValueArray[k];
               _leftProTxtList[k].visible = true;
               k++;
            }
         }
         else
         {
            i = 0;
            while(i < 4)
            {
               _leftProTxtList[i].text = _noProTxt;
               _leftProTxtList[i].visible = true;
               i++;
            }
         }
      }
      
      private function refreshNewProView() : void
      {
         var tmpValueArray:* = null;
         var tmpCurValueArray:* = null;
         var k:int = 0;
         var i:int = 0;
         if(!_equipCell.info)
         {
            return;
         }
         var tmpItemInfo:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         if(tmpItemInfo.isHasLatenetEnergyNew)
         {
            _replaceBtn.enable = true;
            tmpValueArray = tmpItemInfo.latentEnergyNewList;
            tmpCurValueArray = tmpItemInfo.latentEnergyCurList;
            for(k = 0; k < 4; )
            {
               _rightProTxtList[k].text = tmpValueArray[k];
               _rightProTxtList[k].visible = true;
               if(int(tmpValueArray[k]) > int(tmpCurValueArray[k]))
               {
                  _moreLessIconMcList[k].gotoAndStop(1);
               }
               else if(int(tmpValueArray[k]) == int(tmpCurValueArray[k]))
               {
                  _moreLessIconMcList[k].gotoAndStop(3);
               }
               else if(int(tmpValueArray[k]) < int(tmpCurValueArray[k]))
               {
                  _moreLessIconMcList[k].gotoAndStop(2);
               }
               k++;
            }
         }
         else
         {
            _replaceBtn.enable = false;
            for(i = 0; i < 4; )
            {
               _rightProTxtList[i].visible = false;
               _moreLessIconMcList[i].gotoAndStop(3);
               i++;
            }
         }
      }
      
      protected function __cellDoubleClick(evt:CellEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpStr:String = "";
         if(evt.target == _proBagList)
         {
            tmpStr = "latentEnergy_item_move";
         }
         else
         {
            tmpStr = "latentEnergy_equip_move";
         }
         var event:LatentEnergyEvent = new LatentEnergyEvent(tmpStr);
         var cell:BagCell = evt.data as BagCell;
         event.info = cell.info as InventoryItemInfo;
         event.moveType = 1;
         LatentEnergyManager.instance.dispatchEvent(event);
      }
      
      private function cellClickHandler(event:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var cell:BagCell = event.data as BagCell;
         cell.dragStart();
      }
      
      override public function set visible(value:Boolean) : void
      {
         .super.visible = value;
         if(value)
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
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
