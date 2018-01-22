package equipretrieve.view
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import equipretrieve.RetrieveController;
   import equipretrieve.RetrieveModel;
   import flash.display.Shape;
   
   public class RetrieveBagView extends BagView
   {
       
      
      protected var _equipPanel:ScrollPanel;
      
      protected var _propPanel:ScrollPanel;
      
      public function RetrieveBagView()
      {
         super();
         isNeedCard(false);
      }
      
      override protected function set_breakBtn_enable() : void
      {
         if(_breakBtn)
         {
            _breakBtn.enable = false;
            _breakBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_sellBtn)
         {
            _sellBtn.enable = false;
            _sellBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_keySortBtn)
         {
            _keySortBtn.enable = false;
            _keySortBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_cardEnbleFlase)
         {
            _cardEnbleFlase.visible = false;
            _cardEnbleFlase.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_continueBtn)
         {
            _continueBtn.enable = false;
            _continueBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_tabBtn3)
         {
            _tabBtn3.mouseEnabled = false;
         }
         _goodsNumInfoText.visible = false;
         _goodsNumTotalText.visible = false;
      }
      
      override protected function initBackGround() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("bagBGAsset4");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.view.bgIII");
         _moneyBg = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.moneyViewBG");
         _moneyBg1 = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.moneyViewBGI");
         _moneyBg2 = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.moneyViewBGII");
         _bgShape = new Shape();
         _bgShape.graphics.beginFill(15262671,1);
         _bgShape.graphics.drawRoundRect(0,0,327,328,2,2);
         _bgShape.graphics.endFill();
         _bgShape.x = 11;
         _bgShape.y = 50;
      }
      
      override protected function initBagList() : void
      {
         _equiplist = new RetrieveBagEquipListView(0);
         _proplist = new RetrieveBagListView(1);
         _currentList = _equiplist;
         _equipPanel = ComponentFactory.Instance.creat("ddtstore.StoreBagView.BagEquipScrollPanel");
         _equipPanel.x = 16;
         _equipPanel.y = 92;
         addChild(_equipPanel);
         _equipPanel.hScrollProxy = 2;
         _equipPanel.vScrollProxy = 0;
         _equipPanel.setView(_equiplist);
         _equipPanel.invalidateViewport();
         _propPanel = ComponentFactory.Instance.creat("ddtstore.StoreBagView.BagEquipScrollPanel");
         _propPanel.x = 16;
         _propPanel.y = 266;
         addChild(_propPanel);
         _propPanel.hScrollProxy = 2;
         _propPanel.vScrollProxy = 0;
         _propPanel.setView(_proplist);
         _propPanel.invalidateViewport();
      }
      
      override protected function initTabButtons() : void
      {
         super.initTabButtons();
         _tabBtn1.visible = false;
         _tabBtn2.visible = false;
         _tabBtn3.visible = false;
         _buttonContainer.visible = false;
      }
      
      override protected function initEvent() : void
      {
         _equiplist.addEventListener("itemclick",__cellClick);
         _equiplist.addEventListener("doubleclick",__cellDoubleClick);
         _equiplist.addEventListener("change",__listChange);
         _equiplist.addEventListener("dragStop",_stopDrag);
         _proplist.addEventListener("itemclick",__cellClick);
         _proplist.addEventListener("doubleclick",__cellDoubleClick);
         _proplist.addEventListener("dragStop",_stopDrag);
         SocketManager.Instance.addEventListener(PkgEvent.format(205),__useColorShell);
      }
      
      override public function setBagType(param1:int) : void
      {
         super.setBagType(param1);
         _buttonContainer.visible = false;
         var _loc2_:* = false;
         _continueBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _breakBtn.enable = _loc2_;
         _sellBtn.enable = _loc2_;
         _loc2_ = ComponentFactory.Instance.creatFilters("grayFilter");
         _continueBtn.filters = _loc2_;
         _loc2_ = _loc2_;
         _breakBtn.filters = _loc2_;
         _sellBtn.filters = _loc2_;
         _equiplist.visible = true;
         _proplist.visible = true;
      }
      
      override protected function __cellDoubleClick(param1:CellEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         param1.stopImmediatePropagation();
         var _loc3_:RetrieveBagcell = param1.data as RetrieveBagcell;
         var _loc5_:InventoryItemInfo = _loc3_.info as InventoryItemInfo;
         var _loc4_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_loc5_.TemplateID);
         var _loc2_:int = !!PlayerManager.Instance.Self.Sex?1:2;
         if(!_loc3_.locked)
         {
            RetrieveController.Instance.cellDoubleClick(_loc3_);
         }
      }
      
      override protected function __cellClick(param1:CellEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!_sellBtn.isActive)
         {
            param1.stopImmediatePropagation();
            _loc2_ = param1.data as BagCell;
            if(_loc2_)
            {
               _loc3_ = _loc2_.info as InventoryItemInfo;
            }
            if(_loc3_ == null)
            {
               return;
            }
            if(!_loc2_.locked)
            {
               SoundManager.instance.play("008");
               _loc2_.dragStart();
               RetrieveController.Instance.shine = true;
            }
         }
      }
      
      private function _stopDrag(param1:CellEvent) : void
      {
         RetrieveController.Instance.shine = false;
      }
      
      public function resultPoint(param1:int, param2:Number, param3:Number) : void
      {
         setBagType(param1);
         if(param1 == 0)
         {
            RetrieveModel.Instance.setresultCell(RetrieveBagEquipListView(_equiplist).returnNullPoint(param2,param3));
         }
         else if(param1 == 1)
         {
            RetrieveModel.Instance.setresultCell(RetrieveBagListView(_proplist).returnNullPoint(param2,param3));
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_equipPanel);
         _equipPanel = null;
         ObjectUtils.disposeObject(_propPanel);
         _propPanel = null;
         super.dispose();
      }
   }
}
