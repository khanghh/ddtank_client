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
      
      public function TreasureRoomRewardItem(info:InventoryItemInfo, logoId:int)
      {
         _info = info;
         _id = logoId;
         super();
      }
      
      override protected function initialize() : void
      {
         var markChipInfo:* = null;
         _cell = new BagCell(0,_info,true,ComponentFactory.Instance.creatBitmap("asset.treasureRoom.view.cellBg"));
         addChildAt(_cell,0);
         _cell.tipData = null;
         super.initialize();
         imgStatus.visible = false;
         var bg:Clip = getChildByName("selectBg") as Clip;
         bg.visible = false;
         itemBox.visible = false;
         if(_id > 0)
         {
            markChipInfo = MarkMgr.inst.model.getChipById(_id);
            showStars(markChipInfo.bornLv + markChipInfo.hammerLv);
            tipStyle = "mark.MarkChipTip";
            tipData = markChipInfo;
         }
      }
      
      private function showStars(index:int) : void
      {
         var i:int = 0;
         var containers:Array = ["",conStars1,conStars2,conStars3,conStars4,conStars5];
         for(i = 1; i < containers.length; )
         {
            if(i == index)
            {
               if(index != 0)
               {
                  containers[i].visible = true;
               }
            }
            else
            {
               containers[i].visible = false;
            }
            i++;
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
