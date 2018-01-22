package equipretrieve.view
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.SoundManager;
   import equipretrieve.RetrieveModel;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class RetrieveBagListView extends BagListView
   {
       
      
      public function RetrieveBagListView(param1:int, param2:int = 7)
      {
         super(param1,param2);
      }
      
      override protected function createCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc2_ = 0;
         while(_loc2_ < 49)
         {
            _loc1_ = new RetrieveBagcell(_loc2_);
            _loc1_.mouseOverEffBoolean = false;
            addChild(_loc1_);
            _loc1_.bagType = _bagType;
            _loc1_.addEventListener("interactive_click",__clickHandler);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            _loc1_.addEventListener("dragStop",_stopDrag);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _loc1_.addEventListener("mouseOver",_cellOverEff);
            _loc1_.addEventListener("mouseOut",_cellOutEff);
            _loc1_.addEventListener("lockChanged",__cellChanged);
            _cells[_loc1_.place] = _loc1_;
            _cellVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function _stopDrag(param1:CellEvent) : void
      {
         dispatchEvent(new CellEvent("dragStop",param1.currentTarget));
      }
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget,false,false,param1.ctrlKey));
         }
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
         if((param1.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("doubleclick",param1.currentTarget));
         }
      }
      
      override public function setData(param1:BagInfo) : void
      {
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
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var _loc3_ in _bagdata.items)
         {
            if(_cells[_loc3_] != null && _bagdata.items[_loc3_] && ItemManager.Instance.getTemplateById(_bagdata.items[_loc3_].TemplateID).CanRecycle != 0)
            {
               _cells[_loc3_].info = _bagdata.items[_loc3_];
               _loc2_.push(_cells[_loc3_]);
            }
         }
         _bagdata.addEventListener("update",__updateGoods);
         _cellsSort(_loc2_);
      }
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         if(param2 == null)
         {
            _cells[param1].info = null;
            return;
         }
         if(param2.Count > 0 && ItemManager.Instance.getTemplateById(param2.TemplateID).CanRecycle != 0)
         {
            _cells[param1].info = param2;
         }
         else
         {
            _cells[param1].info = null;
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
      
      public function returnNullPoint(param1:Number, param2:Number) : Object
      {
         var _loc5_:int = 0;
         var _loc3_:Point = new Point(0,0);
         var _loc4_:Object = {};
         _loc5_ = 0;
         while(_loc5_ < 49)
         {
            if(_bagdata.items[_loc5_] == null)
            {
               _loc3_.x = this.localToGlobal(new Point(_cells[_loc5_].x,_cells[_loc5_].y)).x;
               _loc3_.y = this.localToGlobal(new Point(_cells[_loc5_].x,_cells[_loc5_].y)).y;
               _loc4_.point = _loc3_;
               _loc4_.bagType = 1;
               _loc4_.place = _loc5_;
               _loc4_.cell = _cells[_loc5_];
               return _loc4_;
            }
            _loc5_++;
         }
         _loc3_.x = 776;
         _loc3_.y = 572;
         _loc4_.point = _loc3_;
         _loc4_.bagType = 1;
         _loc4_.place = _loc5_;
         _loc4_.cell = _cells[_loc5_];
         RetrieveModel.Instance.isFull = true;
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         DoubleClickManager.Instance.clearTarget();
         super.dispose();
      }
   }
}
