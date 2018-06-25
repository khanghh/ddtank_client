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
      
      override public function setBagType(type:int) : void
      {
         super.setBagType(type);
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
      
      override protected function __cellDoubleClick(evt:CellEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         evt.stopImmediatePropagation();
         var cell:RetrieveBagcell = evt.data as RetrieveBagcell;
         var info:InventoryItemInfo = cell.info as InventoryItemInfo;
         var templeteInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(info.TemplateID);
         var playerSex:int = !!PlayerManager.Instance.Self.Sex?1:2;
         if(!cell.locked)
         {
            RetrieveController.Instance.cellDoubleClick(cell);
         }
      }
      
      override protected function __cellClick(evt:CellEvent) : void
      {
         var cell:* = null;
         var info:* = null;
         if(!_sellBtn.isActive)
         {
            evt.stopImmediatePropagation();
            cell = evt.data as BagCell;
            if(cell)
            {
               info = cell.info as InventoryItemInfo;
            }
            if(info == null)
            {
               return;
            }
            if(!cell.locked)
            {
               SoundManager.instance.play("008");
               cell.dragStart();
               RetrieveController.Instance.shine = true;
            }
         }
      }
      
      private function _stopDrag(e:CellEvent) : void
      {
         RetrieveController.Instance.shine = false;
      }
      
      public function resultPoint(i:int, _dx:Number, _dy:Number) : void
      {
         setBagType(i);
         if(i == 0)
         {
            RetrieveModel.Instance.setresultCell(RetrieveBagEquipListView(_equiplist).returnNullPoint(_dx,_dy));
         }
         else if(i == 1)
         {
            RetrieveModel.Instance.setresultCell(RetrieveBagListView(_proplist).returnNullPoint(_dx,_dy));
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
