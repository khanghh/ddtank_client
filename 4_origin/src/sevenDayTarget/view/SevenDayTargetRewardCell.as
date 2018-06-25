package sevenDayTarget.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class SevenDayTargetRewardCell extends Sprite
   {
       
      
      protected var _itemName:FilterFrameText;
      
      protected var _itemNum:FilterFrameText;
      
      private var cell:BaseCell;
      
      public function SevenDayTargetRewardCell()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         cell = new BaseCell(ComponentFactory.Instance.creat("asset.awardSystem.roulette.SelectCellBGAsset"));
         _itemName = ComponentFactory.Instance.creat("BoxVipTips.ItemName");
         _itemNum = ComponentFactory.Instance.creat("BoxVipTips.ItemName2");
         PositionUtils.setPos(cell,"sevenDayTarget.itemAwardCellPos");
         PositionUtils.setPos(_itemName,"sevenDayTarget.itemAwardNamePos");
         PositionUtils.setPos(_itemNum,"sevenDayTarget.itemAwardNumPos");
         addChild(cell);
         addChild(_itemName);
         addChild(_itemNum);
      }
      
      public function set itemNum(name:String) : void
      {
         _itemNum.text = name;
      }
      
      public function set itemName(name:String) : void
      {
         _itemName.text = name;
      }
      
      public function set info(value:ItemTemplateInfo) : void
      {
         cell.info = value;
      }
      
      public function dispose() : void
      {
         if(_itemName)
         {
            ObjectUtils.disposeObject(_itemName);
         }
         _itemName = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
