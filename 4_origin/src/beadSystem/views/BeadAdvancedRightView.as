package beadSystem.views
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import beadSystem.controls.BeadAdvanceCell;
   import beadSystem.controls.BeadCell;
   import beadSystem.model.AdvanceBeadInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BeadAdvancedRightView extends Sprite implements Disposeable
   {
      
      private static const CELL_NUM:int = 18;
       
      
      private var _info:AdvanceBeadInfo;
      
      private var _curTabIndex:int = -1;
      
      private var _panel:ScrollPanel;
      
      private var _skillSpri:Sprite;
      
      private var _beadExchangeBtn:SimpleBitmapButton;
      
      private var _beadCellArr:Array;
      
      private var _mainCell:BeadAdvanceInfoCell;
      
      private var _secondCell:BeadAdvanceInfoCell;
      
      private var _materialsDescTxt:FilterFrameText;
      
      private var _mainBeadDescTxt:FilterFrameText;
      
      private var _secondBeadDescTxt:FilterFrameText;
      
      private var _previewsTxt:FilterFrameText;
      
      private var _btnHelp:BaseButton;
      
      private var _lookBead:BagCell;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _clickDate:Number = 0;
      
      public function BeadAdvancedRightView()
      {
         super();
         _panel = ComponentFactory.Instance.creatComponentByStylename("beadSystem.advanceBeadListView.itemlist");
         _panel.width = 350;
         _panel.height = 148;
         PositionUtils.setPos(_panel,"beadSystem.beadAdvance.beadAdvanceRightView.itemlist.Pos");
         addChild(_panel);
         _beadExchangeBtn = ComponentFactory.Instance.creatComponentByStylename("beadSystem.beadAdvance.exchangeBtn");
         addChild(_beadExchangeBtn);
         _materialsDescTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.advanceBead.MaterialsDescTxt");
         _materialsDescTxt.text = LanguageMgr.GetTranslation("beadSystem.beadAdvance.beadPutFailMsg");
         addChild(_materialsDescTxt);
         _mainBeadDescTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.advanceBead.BeadMainDescTxt");
         addChild(_mainBeadDescTxt);
         _secondBeadDescTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.advanceBead.BeadSecondDescTxt");
         addChild(_secondBeadDescTxt);
         _skillSpri = new Sprite();
         _mainCell = new BeadAdvanceInfoCell(0);
         _mainCell.setContentSize(72,72);
         _mainCell.PicPos = new Point(-11,-14);
         PositionUtils.setPos(_mainCell,"beadSystem.beadAdvance.beadAdvanceInfoCell.Pos");
         _secondCell = new BeadAdvanceInfoCell(1);
         _secondCell.setContentSize(72,72);
         _secondCell.PicPos = new Point(-11,-14);
         PositionUtils.setPos(_secondCell,"beadSystem.beadAdvance.beadAdvanceInfoCell2.Pos");
         addChild(_mainCell);
         addChild(_secondCell);
         _lookBead = new BagCell(0);
         _lookBead.setContentSize(49,49);
         PositionUtils.setPos(_lookBead,"beadSystem.beadAdvance.beadAdvanceBagCell.Pos");
         _lookBead.BGVisible = false;
         addChild(_lookBead);
         _previewsTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.advanceBead.BeadPreviewsTxt");
         _previewsTxt.text = LanguageMgr.GetTranslation("store.view.fusion.PreviewFrame.preview");
         addChild(_previewsTxt);
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"beadSystem.advanceRead.helpbtn",{
            "x":284,
            "y":-47
         },LanguageMgr.GetTranslation("beadSystem.beadAdvance.helpTxt"),"beadSystem.beadAdvance.helpTxt",340,408);
         createCells();
         initEvent();
      }
      
      private function createCells() : void
      {
         var cell:* = null;
         var i:int = 0;
         _beadCellArr = [];
         _skillSpri.removeChildren();
         for(i = 0; i < 18; )
         {
            cell = createCell(i);
            _skillSpri.addChild(cell);
            _beadCellArr.push(cell);
            i++;
         }
         _panel.setView(_skillSpri);
      }
      
      private function createCell(index:int) : BeadAdvanceCell
      {
         var temCell:* = null;
         temCell = new BeadAdvanceCell(index);
         temCell.setContentSize(50,50);
         temCell.PicPos = new Point(-3,-2);
         temCell.x = index % 6 * 49 + 10;
         temCell.y = int(index / 6) * 49;
         temCell.addEventListener("interactive_click",beadCellClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(temCell);
         return temCell;
      }
      
      private function initEvent() : void
      {
         if(_beadExchangeBtn)
         {
            _beadExchangeBtn.addEventListener("click",exchangeHandler);
         }
         if(_mainCell)
         {
            _mainCell.addEventListener("interactive_click",cellInfoClickHandler);
            _mainCell.addEventListener("interactive_double_click",cellInfoRemoveHandler);
            DoubleClickManager.Instance.enableDoubleClick(_mainCell);
         }
         if(_secondCell)
         {
            _secondCell.addEventListener("interactive_click",cellInfoClickHandler);
            _secondCell.addEventListener("interactive_double_click",cellInfoRemoveHandler);
            DoubleClickManager.Instance.enableDoubleClick(_secondCell);
         }
      }
      
      private function cellInfoClickHandler(evt:InteractiveEvent) : void
      {
         var cell:* = null;
         evt.stopImmediatePropagation();
         if(evt.target is BeadAdvanceInfoCell)
         {
            cell = evt.target as BeadAdvanceInfoCell;
            if(cell.info == null)
            {
               return;
            }
            cell.dragStart();
         }
      }
      
      private function cellInfoRemoveHandler(evt:InteractiveEvent) : void
      {
         var temCell:* = null;
         if(evt.target is BeadAdvanceInfoCell)
         {
            temCell = evt.target as BeadAdvanceInfoCell;
            var _loc3_:* = null;
            temCell.itemInfo = _loc3_;
            temCell.info = _loc3_;
         }
         update(_info,_curTabIndex);
      }
      
      private function removeEvent() : void
      {
         if(_beadExchangeBtn)
         {
            _beadExchangeBtn.removeEventListener("click",exchangeHandler);
         }
         if(_mainCell)
         {
            _mainCell.removeEventListener("interactive_click",cellInfoClickHandler);
            _mainCell.removeEventListener("interactive_double_click",cellInfoRemoveHandler);
            DoubleClickManager.Instance.disableDoubleClick(_mainCell);
         }
         if(_secondCell)
         {
            _secondCell.removeEventListener("interactive_click",cellInfoClickHandler);
            _secondCell.removeEventListener("interactive_double_click",cellInfoRemoveHandler);
            DoubleClickManager.Instance.disableDoubleClick(_secondCell);
         }
      }
      
      private function exchangeHandler(evt:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(new Date().time - _clickDate <= 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickDate = new Date().time;
         var msg:String = LanguageMgr.GetTranslation("beadSystem.beadAdvance.exchangeTipMsg");
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1,null,"SimpleAlert",30,true);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __confirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               exchange();
         }
         _confirmFrame.removeEventListener("response",__confirm);
         _confirmFrame.dispose();
         if(_confirmFrame.parent)
         {
            _confirmFrame.parent.removeChild(_confirmFrame);
         }
      }
      
      private function exchange() : void
      {
         var itemId:int = _info.advancedTempId;
         var bag:BagInfo = PlayerManager.Instance.Self.BeadBag;
         var mainIndex:int = -1;
         var secondIndex:int = -1;
         if(_mainCell && _mainCell.info)
         {
            mainIndex = (_mainCell.info as InventoryItemInfo).Place;
         }
         if(_secondCell && _secondCell.info)
         {
            secondIndex = (_secondCell.info as InventoryItemInfo).Place;
         }
         if(mainIndex == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("beadSystem.beadAdvance.mainMaterial.nuLLMsg"));
            return;
         }
         if(secondIndex == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("beadSystem.beadAdvance.secondMaterial.nuLLMsg"));
            return;
         }
         SocketManager.Instance.out.sendBeadAdvanceExchange(itemId,mainIndex,secondIndex);
      }
      
      public function update(info:AdvanceBeadInfo, tabIndex:int) : void
      {
         _info = info;
         _curTabIndex = tabIndex;
         clearAdvanceBeadInfoCell();
         updateData();
      }
      
      public function refresh() : void
      {
         clearAdvanceBeadInfoCell();
         updateData();
      }
      
      private function clearAdvanceBeadInfoCell() : void
      {
         var _loc1_:* = null;
         _secondCell.info = _loc1_;
         _mainCell.info = _loc1_;
         _loc1_ = null;
         _secondCell.itemInfo = _loc1_;
         _mainCell.itemInfo = _loc1_;
         _lookBead.info = null;
      }
      
      public function get info() : AdvanceBeadInfo
      {
         return _info;
      }
      
      private function clearBeadCellInfo() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _beadCellArr;
         for each(var cell in _beadCellArr)
         {
            if(cell.info)
            {
               var _loc2_:* = null;
               cell.itemInfo = _loc2_;
               cell.info = _loc2_;
            }
         }
      }
      
      private function updateBeadDesc() : void
      {
         var temId:int = 0;
         var singProTxt:String = LanguageMgr.GetTranslation("beadSystem.beadAdvance.anySingleProperty");
         var doubleProTxt:String = LanguageMgr.GetTranslation("beadSystem.beadAdvance.anyDoubleProperty");
         var beadTxt:String = LanguageMgr.GetTranslation("tank.auctionHouse.view.sphere");
         if(_info.mainMaterials.split("|").length > 1)
         {
            _mainBeadDescTxt.text = _curTabIndex == 0?singProTxt:doubleProTxt;
         }
         else
         {
            temId = _info.mainMaterials;
            _mainBeadDescTxt.text = BeadTemplateManager.Instance.GetBeadInfobyID(temId).Name + beadTxt;
         }
         if(_info.auxiliaryMaterials.split("|").length > 1)
         {
            _secondBeadDescTxt.text = _curTabIndex == 0?singProTxt:doubleProTxt;
         }
         else
         {
            temId = _info.auxiliaryMaterials;
            _secondBeadDescTxt.text = BeadTemplateManager.Instance.GetBeadInfobyID(temId).Name + beadTxt;
         }
      }
      
      protected function updateData() : void
      {
         var beadId:int = 0;
         var itemInfo:* = null;
         var temCeLL:* = null;
         var i:int = 0;
         var beadArr:Array = _info.getAllBead();
         var bag:BagInfo = PlayerManager.Instance.Self.BeadBag;
         if(_beadCellArr == null && bag == null)
         {
            return;
         }
         clearBeadCellInfo();
         updateBeadDesc();
         _lookBead.info = createBagCellInfo(_info.maxLevelTempRunId);
         var index:int = 0;
         for(i = 0; i < beadArr.length; )
         {
            beadId = beadArr[i];
            var _loc10_:int = 0;
            var _loc9_:* = bag.items;
            for(var item in bag.items)
            {
               itemInfo = bag.items[item] as InventoryItemInfo;
               if(itemInfo.TemplateID == beadId && itemInfo.Place >= 32)
               {
                  if(_beadCellArr.length > index)
                  {
                     temCeLL = _beadCellArr[index] as BeadAdvanceCell;
                  }
                  else
                  {
                     temCeLL = createCell(index);
                     _skillSpri.addChild(temCeLL);
                     _beadCellArr[index] = temCeLL;
                  }
                  temCeLL.itemInfo = itemInfo;
                  temCeLL.info = itemInfo;
                  index++;
               }
            }
            i++;
         }
      }
      
      private function createBagCellInfo(templeteId:int) : InventoryItemInfo
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = templeteId;
         info = ItemManager.fill(info);
         info.IsBinds = true;
         return info;
      }
      
      private function beadCellClickHandler(evt:InteractiveEvent) : void
      {
         var cell:* = null;
         var info:* = null;
         evt.stopImmediatePropagation();
         if(evt.currentTarget is BeadCell)
         {
            cell = evt.target as BeadCell;
            if(cell)
            {
               info = cell.itemInfo as InventoryItemInfo;
            }
            if(info == null)
            {
               return;
            }
            cell.dragStart();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _curTabIndex = -1;
         _info = null;
         if(_panel)
         {
            _panel.removeChildren();
         }
         if(_skillSpri)
         {
            ObjectUtils.removeChildAllChildren(_skillSpri);
         }
         if(_beadExchangeBtn)
         {
            ObjectUtils.disposeObject(_beadExchangeBtn);
         }
         _beadExchangeBtn = null;
         if(_mainCell)
         {
            ObjectUtils.disposeObject(_mainCell);
         }
         _mainCell = null;
         if(_secondCell)
         {
            ObjectUtils.disposeObject(_secondCell);
         }
         _secondCell = null;
         if(_materialsDescTxt)
         {
            ObjectUtils.disposeObject(_materialsDescTxt);
         }
         _materialsDescTxt = null;
         if(_mainBeadDescTxt)
         {
            ObjectUtils.disposeObject(_mainBeadDescTxt);
         }
         _mainBeadDescTxt = null;
         if(_secondBeadDescTxt)
         {
            ObjectUtils.disposeObject(_secondBeadDescTxt);
         }
         _secondBeadDescTxt = null;
         if(_previewsTxt)
         {
            ObjectUtils.disposeObject(_previewsTxt);
         }
         _previewsTxt = null;
         if(_btnHelp)
         {
            ObjectUtils.disposeObject(_btnHelp);
         }
         _btnHelp = null;
         if(_lookBead)
         {
            ObjectUtils.disposeObject(_lookBead);
         }
         _lookBead = null;
         _skillSpri = null;
         _beadCellArr = null;
      }
   }
}
