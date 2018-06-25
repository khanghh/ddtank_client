package sevenDayTarget.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class NewPlayerRewardCell extends Sprite
   {
       
      
      protected var _itemNum:FilterFrameText;
      
      private var cell:BaseCell;
      
      public function NewPlayerRewardCell()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         cell = new BaseCell(ComponentFactory.Instance.creat("newPlayerReward.rewardItemBg"));
         _itemNum = ComponentFactory.Instance.creat("BoxVipTips.ItemName3");
         PositionUtils.setPos(cell,"sevenDayTarget.itemAwardCellPos");
         PositionUtils.setPos(_itemNum,"sevenDayTarget.itemAwardNumPos");
         addChild(cell);
         addChild(_itemNum);
      }
      
      public function set info(value:ItemTemplateInfo) : void
      {
         cell.info = value;
      }
      
      public function set itemNum(name:String) : void
      {
         _itemNum.text = name;
      }
      
      public function dispose() : void
      {
         if(_itemNum)
         {
            ObjectUtils.disposeObject(_itemNum);
         }
         _itemNum = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
