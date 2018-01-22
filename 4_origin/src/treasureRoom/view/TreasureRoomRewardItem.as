package treasureRoom.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.mornUI.items.MarkBagItemUI;
   import morn.core.components.Clip;
   
   public class TreasureRoomRewardItem extends MarkBagItemUI
   {
       
      
      private var _cell:BaseCell = null;
      
      private var _id:int = 0;
      
      private var _info:InventoryItemInfo;
      
      public function TreasureRoomRewardItem(param1:InventoryItemInfo, param2:int)
      {
         _info = param1;
         _id = param2;
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = null;
         _cell = new BagCell(0,_info,true,ComponentFactory.Instance.creatBitmap("asset.treasureRoom.view.cellBg"));
         addChildAt(_cell,0);
         _cell.tipData = null;
         super.initialize();
         imgStatus.visible = false;
         var _loc2_:Clip = getChildByName("selectBg") as Clip;
         _loc2_.visible = false;
         itemBox.visible = false;
         if(_id > 0)
         {
            _loc1_ = MarkMgr.inst.model.getChipById(_id);
            showStars(_loc1_.bornLv + _loc1_.hammerLv);
            tipStyle = "mark.MarkChipTip";
            tipData = _loc1_;
         }
      }
      
      private function showStars(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = ["",conStars1,conStars2,conStars3,conStars4,conStars5];
         _loc3_ = 1;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc3_ == param1)
            {
               if(param1 != 0)
               {
                  _loc2_[_loc3_].visible = true;
               }
            }
            else
            {
               _loc2_[_loc3_].visible = false;
            }
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         if(_cell)
         {
            ObjectUtils.disposeAllChildren(_cell);
            _cell = null;
         }
         super.dispose();
      }
   }
}
