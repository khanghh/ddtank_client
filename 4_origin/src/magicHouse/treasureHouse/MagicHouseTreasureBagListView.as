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
      
      public function MagicHouseTreasureBagListView(param1:int, param2:int = 0)
      {
         super(param1,MAX_LINE_NUM);
         _selfInfo = PlayerManager.Instance.Self;
      }
      
      public function addDepot(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:* = null;
         if(param1 == _depotNum)
         {
            return;
         }
         _loc4_ = _depotNum;
         while(_loc4_ < param1)
         {
            _loc2_ = _loc4_;
            _loc3_ = _cells[_loc2_] as MagicHouseTreasureCell;
            _loc3_.grayFilters = false;
            _loc3_.isOpen = true;
            _loc4_++;
         }
         _depotNum = param1;
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as MagicHouseTreasureCell).info != null)
         {
            dispatchEvent(new CellEvent("doubleclick",param1.currentTarget));
         }
      }
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         if(param1.currentTarget.isOpen)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget,false,false));
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _needMoney = 0;
            _pos = param1.currentTarget.pos;
            _loc8_ = MagicHouseModel.instance.depotCount;
            while(_loc8_ < param1.currentTarget.pos + 1)
            {
               _loc8_++;
               _needMoney = _needMoney + (MagicHouseModel.instance.openDepotNeedMoney + (_loc8_ - 10 - 1) * MagicHouseModel.instance.depotPromoteNeedMoney);
            }
            _loc3_ = _selfInfo.getBag(1);
            _loc4_ = _loc3_.getItemByTemplateId(29995);
            _loc7_ = _loc3_.getItemCountByTemplateId(29995);
            _loc5_ = ItemManager.Instance.getTemplateById(29995).Property3;
            _loc2_ = _loc5_ * _loc7_;
            if(!_frame)
            {
               _frame = ComponentFactory.Instance.creatComponentByStylename("magichouse.tipFrame");
               _frame.titleText = LanguageMgr.GetTranslation("magichouse.treasureView.openDepotTitle");
               if(_loc2_ >= _needMoney)
               {
                  IsOK = true;
                  _frame.setTipHtmlText(LanguageMgr.GetTranslation("magichouse.treasureView.openDepotTitle1",int(_needMoney / _loc5_),_loc4_.Name,param1.currentTarget.pos + 1 - MagicHouseModel.instance.depotCount));
                  _frame.item.visible = false;
               }
               else
               {
                  IsOK = false;
                  _loc6_ = _loc5_ <= 0?0:int(_needMoney / _loc5_);
                  _frame.setTipHtmlText(LanguageMgr.GetTranslation("magichouse.treasureView.openDepotTitle2",_loc6_,_needMoney,param1.currentTarget.pos + 1 - MagicHouseModel.instance.depotCount));
                  _frame.item.visible = true;
               }
               LayerManager.Instance.addToLayer(_frame,3,true,1);
               _frame.okBtn.addEventListener("click",__okBtnHandler);
               _frame.cancelBtn.addEventListener("click",__cancelBtnHandler);
               _frame.addEventListener("response",__confirmResponse);
            }
         }
      }
      
      private function __okBtnHandler(param1:MouseEvent) : void
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
      
      private function __cancelBtnHandler(param1:MouseEvent) : void
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
      
      private function __confirmResponse(param1:FrameEvent) : void
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
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _cells = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < MAX_LINE_NUM)
         {
            _loc3_ = 0;
            while(_loc3_ < MAX_LINE_NUM)
            {
               _loc1_ = _loc4_ * MAX_LINE_NUM + _loc3_;
               _loc2_ = CellFactory.instance.createTreasureCell(_loc1_) as MagicHouseTreasureCell;
               addChild(_loc2_);
               _loc2_.bagType = _bagType;
               _loc2_.addEventListener("interactive_click",__clickHandler);
               _loc2_.addEventListener("interactive_double_click",__doubleClickHandler);
               DoubleClickManager.Instance.enableDoubleClick(_loc2_);
               _loc2_.addEventListener("lockChanged",__cellChanged);
               _cells[_loc2_.place] = _loc2_;
               if(_depotNum <= _loc4_ * MAX_LINE_NUM + _loc3_)
               {
                  _loc2_.grayFilters = true;
                  _loc2_.isOpen = false;
               }
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      public function checkMagicHouseStoreCell() : int
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _depotNum)
         {
            _loc1_ = _cells[_loc2_] as MagicHouseTreasureCell;
            if(!_loc1_.info)
            {
               return 1;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function set depotNum(param1:int) : void
      {
         _depotNum = param1;
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("interactive_click",__clickHandler);
            _loc1_.removeEventListener("interactive_double_click",__doubleClickHandler);
            _loc1_.removeEventListener("lockChanged",__cellChanged);
         }
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
