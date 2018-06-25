package magicHouse.treasureHouse
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import magicHouse.MagicHouseModel;
   import magicHouse.MagicHouseTipFrame;
   
   public class MagicHouseTreasureBagListView extends BagListView
   {
      
      private static var MAX_LINE_NUM:int = 10;
      
      private static const baseDepotCount:int = 10;
       
      
      private var _depotNum:int;
      
      private var _needMoney:int = 0;
      
      private var _pos:int = 0;
      
      private var _frame:MagicHouseTipFrame;
      
      private var _selfInfo:SelfInfo;
      
      private var IsOK:Boolean;
      
      public function MagicHouseTreasureBagListView(bagType:int, num:int = 0)
      {
         super(bagType,MAX_LINE_NUM);
         _selfInfo = PlayerManager.Instance.Self;
      }
      
      public function addDepot(num:int) : void
      {
         var i:int = 0;
         var index:* = 0;
         var cell:* = null;
         if(num == _depotNum)
         {
            return;
         }
         for(i = _depotNum; i < num; )
         {
            index = i;
            cell = _cells[index] as MagicHouseTreasureCell;
            cell.grayFilters = false;
            cell.isOpen = true;
            i++;
         }
         _depotNum = num;
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if((evt.currentTarget as MagicHouseTreasureCell).info != null)
         {
            dispatchEvent(new CellEvent("doubleclick",evt.currentTarget));
         }
      }
      
      override protected function __clickHandler(e:InteractiveEvent) : void
      {
         var i:int = 0;
         var bagInfo:* = null;
         var item:* = null;
         var conut:int = 0;
         var money:int = 0;
         var total:int = 0;
         var counts:int = 0;
         if(e.currentTarget.isOpen)
         {
            dispatchEvent(new CellEvent("itemclick",e.currentTarget,false,false));
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _needMoney = 0;
            _pos = e.currentTarget.pos;
            for(i = MagicHouseModel.instance.depotCount; i < e.currentTarget.pos + 1; )
            {
               i++;
               _needMoney = _needMoney + (MagicHouseModel.instance.openDepotNeedMoney + (i - 10 - 1) * MagicHouseModel.instance.depotPromoteNeedMoney);
            }
            bagInfo = _selfInfo.getBag(1);
            item = bagInfo.getItemByTemplateId(29995);
            conut = bagInfo.getItemCountByTemplateId(29995);
            money = ItemManager.Instance.getTemplateById(29995).Property3;
            total = money * conut;
            if(!_frame)
            {
               _frame = ComponentFactory.Instance.creatComponentByStylename("magichouse.tipFrame");
               _frame.titleText = LanguageMgr.GetTranslation("magichouse.treasureView.openDepotTitle");
               if(total >= _needMoney)
               {
                  IsOK = true;
                  _frame.setTipHtmlText(LanguageMgr.GetTranslation("magichouse.treasureView.openDepotTitle1",int(_needMoney / money),item.Name,e.currentTarget.pos + 1 - MagicHouseModel.instance.depotCount));
                  _frame.item.visible = false;
               }
               else
               {
                  IsOK = false;
                  counts = money <= 0?0:int(_needMoney / money);
                  _frame.setTipHtmlText(LanguageMgr.GetTranslation("magichouse.treasureView.openDepotTitle2",counts,_needMoney,e.currentTarget.pos + 1 - MagicHouseModel.instance.depotCount));
                  _frame.item.visible = true;
               }
               LayerManager.Instance.addToLayer(_frame,3,true,1);
               _frame.okBtn.addEventListener("click",__okBtnHandler);
               _frame.cancelBtn.addEventListener("click",__cancelBtnHandler);
               _frame.addEventListener("response",__confirmResponse);
            }
         }
      }
      
      private function __okBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(IsOK)
         {
            SocketManager.Instance.out.magicOpenDepot(_pos,false);
         }
         else
         {
            CheckMoneyUtils.instance.checkMoney(_frame.item.isBind,_needMoney,onCompleteHandler);
         }
         _frame.removeEventListener("response",__okBtnHandler);
         ObjectUtils.disposeObject(_frame);
         if(_frame && _frame.parent)
         {
            _frame.parent.removeChild(_frame);
         }
         _frame = null;
      }
      
      protected function onCompleteHandler() : void
      {
         SocketManager.Instance.out.magicOpenDepot(_pos,CheckMoneyUtils.instance.isBind);
      }
      
      private function __cancelBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _frame.removeEventListener("response",__cancelBtnHandler);
         ObjectUtils.disposeObject(_frame);
         if(_frame && _frame.parent)
         {
            _frame.parent.removeChild(_frame);
         }
         _frame = null;
      }
      
      private function __confirmResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _frame.removeEventListener("response",__confirmResponse);
         ObjectUtils.disposeObject(_frame);
         if(_frame && _frame.parent)
         {
            _frame.parent.removeChild(_frame);
         }
         _frame = null;
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var j:int = 0;
         var index:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         for(i = 0; i < MAX_LINE_NUM; )
         {
            for(j = 0; j < MAX_LINE_NUM; )
            {
               index = i * MAX_LINE_NUM + j;
               cell = CellFactory.instance.createTreasureCell(index) as MagicHouseTreasureCell;
               addChild(cell);
               cell.bagType = _bagType;
               cell.addEventListener("interactive_click",__clickHandler);
               cell.addEventListener("interactive_double_click",__doubleClickHandler);
               DoubleClickManager.Instance.enableDoubleClick(cell);
               cell.addEventListener("lockChanged",__cellChanged);
               _cells[cell.place] = cell;
               if(_depotNum <= i * MAX_LINE_NUM + j)
               {
                  cell.grayFilters = true;
                  cell.isOpen = false;
               }
               j++;
            }
            i++;
         }
      }
      
      public function checkMagicHouseStoreCell() : int
      {
         var i:int = 0;
         var cell:* = null;
         for(i = 0; i < _depotNum; )
         {
            cell = _cells[i] as MagicHouseTreasureCell;
            if(!cell.info)
            {
               return 1;
            }
            i++;
         }
         return 0;
      }
      
      public function set depotNum(value:int) : void
      {
         _depotNum = value;
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.removeEventListener("interactive_click",__clickHandler);
            cell.removeEventListener("interactive_double_click",__doubleClickHandler);
            cell.removeEventListener("lockChanged",__cellChanged);
         }
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
