package wasteRecycle.view
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import wasteRecycle.WasteRecycleController;
   
   public class WasteRecyclePropBagView extends BagListView
   {
       
      
      private var _waitBagUpdate:Array;
      
      public function WasteRecyclePropBagView(param1:int, param2:int = 7, param3:int = 49)
      {
         _waitBagUpdate = [];
         super(param1,param2,param3);
         WasteRecycleController.instance.addEventListener("complete",__onWaitUpdate);
      }
      
      override protected function createCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc2_ = 0;
         while(_loc2_ < _cellNum)
         {
            _loc1_ = new WasteRecycleCell(_loc2_,null);
            _loc1_.mouseOverEffBoolean = false;
            addChild(_loc1_);
            _loc1_.bagType = _bagType;
            _loc1_.addEventListener("interactive_click",__clickHandler);
            _loc1_.addEventListener("mouseOver",_cellOverEff);
            _loc1_.addEventListener("mouseOut",_cellOutEff);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _loc1_.addEventListener("lockChanged",__cellChanged);
            _cells[_loc1_.place] = _loc1_;
            _cellVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if((param1.currentTarget as BagCell).info != null)
         {
            SoundManager.instance.playButtonSound();
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("wasteRecycel.selectedFrame");
            _loc2_.show(param1.currentTarget as WasteRecycleCell);
         }
      }
      
      override public function setData(param1:BagInfo) : void
      {
         var _loc3_:* = null;
         if(_bagdata == param1)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         _bagdata = param1;
         var _loc2_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _bagdata.items;
         for(var _loc4_ in _bagdata.items)
         {
            _loc3_ = _bagdata.items[_loc4_] as InventoryItemInfo;
            if(WasteRecycleController.instance.model.data[_loc3_.TemplateID])
            {
               _cells[_loc4_].info = _loc3_;
               _loc2_.push(_cells[_loc4_]);
            }
         }
         _bagdata.addEventListener("update",__updateGoods);
         _cellsSort(_loc2_);
      }
      
      override protected function __updateGoods(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         if(WasteRecycleController.instance.isPlay)
         {
            _waitBagUpdate.push(_loc4_);
         }
         else
         {
            var _loc6_:int = 0;
            var _loc5_:* = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               _loc2_ = _bagdata.getItemAt(_loc3_.Place);
               if(_loc2_ && WasteRecycleController.instance.model.data[_loc2_.TemplateID])
               {
                  setCellInfo(_loc2_.Place,_loc2_);
               }
               else
               {
                  setCellInfo(_loc3_.Place,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
      }
      
      private function __onWaitUpdate(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         while(_waitBagUpdate.length)
         {
            _loc3_ = _waitBagUpdate.shift();
            var _loc6_:int = 0;
            var _loc5_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               _loc2_ = _bagdata.getItemAt(_loc4_.Place);
               if(_loc2_ && WasteRecycleController.instance.model.data[_loc2_.TemplateID])
               {
                  setCellInfo(_loc2_.Place,_loc2_);
               }
               else
               {
                  setCellInfo(_loc4_.Place,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
      }
      
      private function _cellsSort(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1.length <= 0)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_].x;
            _loc5_ = param1[_loc6_].y;
            _loc3_ = _cellVec.indexOf(param1[_loc6_]);
            _loc2_ = _cellVec[_loc6_];
            param1[_loc6_].x = _loc2_.x;
            param1[_loc6_].y = _loc2_.y;
            _loc2_.x = _loc4_;
            _loc2_.y = _loc5_;
            _cellVec[_loc6_] = param1[_loc6_];
            _cellVec[_loc3_] = _loc2_;
            _loc6_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:* = null;
         WasteRecycleController.instance.removeEventListener("complete",__onWaitUpdate);
         if(_waitBagUpdate)
         {
            while(_waitBagUpdate.length)
            {
               _loc2_ = _waitBagUpdate.pop();
               var _loc4_:int = 0;
               var _loc3_:* = _loc2_;
               for(var _loc1_ in _loc2_)
               {
                  _loc2_[_loc1_] = null;
                  delete _loc2_[_loc1_];
               }
            }
         }
         _waitBagUpdate = null;
         super.dispose();
      }
   }
}
