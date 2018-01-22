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
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _beadCellArr = [];
         _skillSpri.removeChildren();
         _loc2_ = 0;
         while(_loc2_ < 18)
         {
            _loc1_ = createCell(_loc2_);
            _skillSpri.addChild(_loc1_);
            _beadCellArr.push(_loc1_);
            _loc2_++;
         }
         _panel.setView(_skillSpri);
      }
      
      private function createCell(param1:int) : BeadAdvanceCell
      {
         var _loc2_:* = null;
         _loc2_ = new BeadAdvanceCell(param1);
         _loc2_.setContentSize(50,50);
         _loc2_.PicPos = new Point(-3,-2);
         _loc2_.x = param1 % 6 * 49 + 10;
         _loc2_.y = int(param1 / 6) * 49;
         _loc2_.addEventListener("interactive_click",beadCellClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(_loc2_);
         return _loc2_;
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
      
      private function cellInfoClickHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:* = null;
         param1.stopImmediatePropagation();
         if(param1.target is BeadAdvanceInfoCell)
         {
            _loc2_ = param1.target as BeadAdvanceInfoCell;
            if(_loc2_.info == null)
            {
               return;
            }
            _loc2_.dragStart();
         }
      }
      
      private function cellInfoRemoveHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:* = null;
         if(param1.target is BeadAdvanceInfoCell)
         {
            _loc2_ = param1.target as BeadAdvanceInfoCell;
            var _loc3_:* = null;
            _loc2_.itemInfo = _loc3_;
            _loc2_.info = _loc3_;
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
      
      private function exchangeHandler(param1:MouseEvent) : void
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
         var _loc2_:String = LanguageMgr.GetTranslation("beadSystem.beadAdvance.exchangeTipMsg");
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1,null,"SimpleAlert",30,true);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __confirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 2)
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
         var _loc4_:int = _info.advancedTempId;
         var _loc2_:BagInfo = PlayerManager.Instance.Self.BeadBag;
         var _loc1_:int = -1;
         var _loc3_:int = -1;
         if(_mainCell && _mainCell.info)
         {
            _loc1_ = (_mainCell.info as InventoryItemInfo).Place;
         }
         if(_secondCell && _secondCell.info)
         {
            _loc3_ = (_secondCell.info as InventoryItemInfo).Place;
         }
         if(_loc1_ == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("beadSystem.beadAdvance.mainMaterial.nuLLMsg"));
            return;
         }
         if(_loc3_ == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("beadSystem.beadAdvance.secondMaterial.nuLLMsg"));
            return;
         }
         SocketManager.Instance.out.sendBeadAdvanceExchange(_loc4_,_loc1_,_loc3_);
      }
      
      public function update(param1:AdvanceBeadInfo, param2:int) : void
      {
         _info = param1;
         _curTabIndex = param2;
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
         for each(var _loc1_ in _beadCellArr)
         {
            if(_loc1_.info)
            {
               var _loc2_:* = null;
               _loc1_.itemInfo = _loc2_;
               _loc1_.info = _loc2_;
            }
         }
      }
      
      private function updateBeadDesc() : void
      {
         var _loc2_:int = 0;
         var _loc1_:String = LanguageMgr.GetTranslation("beadSystem.beadAdvance.anySingleProperty");
         var _loc3_:String = LanguageMgr.GetTranslation("beadSystem.beadAdvance.anyDoubleProperty");
         var _loc4_:String = LanguageMgr.GetTranslation("tank.auctionHouse.view.sphere");
         if(_info.mainMaterials.split("|").length > 1)
         {
            _mainBeadDescTxt.text = _curTabIndex == 0?_loc1_:_loc3_;
         }
         else
         {
            _loc2_ = _info.mainMaterials;
            _mainBeadDescTxt.text = BeadTemplateManager.Instance.GetBeadInfobyID(_loc2_).Name + _loc4_;
         }
         if(_info.auxiliaryMaterials.split("|").length > 1)
         {
            _secondBeadDescTxt.text = _curTabIndex == 0?_loc1_:_loc3_;
         }
         else
         {
            _loc2_ = _info.auxiliaryMaterials;
            _secondBeadDescTxt.text = BeadTemplateManager.Instance.GetBeadInfobyID(_loc2_).Name + _loc4_;
         }
      }
      
      protected function updateData() : void
      {
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc8_:int = 0;
         var _loc7_:Array = _info.getAllBead();
         var _loc4_:BagInfo = PlayerManager.Instance.Self.BeadBag;
         if(_beadCellArr == null && _loc4_ == null)
         {
            return;
         }
         clearBeadCellInfo();
         updateBeadDesc();
         _lookBead.info = createBagCellInfo(_info.maxLevelTempRunId);
         var _loc2_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc3_ = _loc7_[_loc8_];
            var _loc10_:int = 0;
            var _loc9_:* = _loc4_.items;
            for(var _loc5_ in _loc4_.items)
            {
               _loc6_ = _loc4_.items[_loc5_] as InventoryItemInfo;
               if(_loc6_.TemplateID == _loc3_ && _loc6_.Place >= 32)
               {
                  if(_beadCellArr.length > _loc2_)
                  {
                     _loc1_ = _beadCellArr[_loc2_] as BeadAdvanceCell;
                  }
                  else
                  {
                     _loc1_ = createCell(_loc2_);
                     _skillSpri.addChild(_loc1_);
                     _beadCellArr[_loc2_] = _loc1_;
                  }
                  _loc1_.itemInfo = _loc6_;
                  _loc1_.info = _loc6_;
                  _loc2_++;
               }
            }
            _loc8_++;
         }
      }
      
      private function createBagCellInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         _loc2_ = ItemManager.fill(_loc2_);
         _loc2_.IsBinds = true;
         return _loc2_;
      }
      
      private function beadCellClickHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         param1.stopImmediatePropagation();
         if(param1.currentTarget is BeadCell)
         {
            _loc2_ = param1.target as BeadCell;
            if(_loc2_)
            {
               _loc3_ = _loc2_.itemInfo as InventoryItemInfo;
            }
            if(_loc3_ == null)
            {
               return;
            }
            _loc2_.dragStart();
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
