package dreamlandChallenge.view.logicView.award
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import dreamlandChallenge.data.UnrealRankRewardInfo;
   import dreamlandChallenge.view.mornui.award.DCAwardItemViewUI;
   
   public class DCAwardItemView extends DCAwardItemViewUI
   {
       
      
      private var _info:UnrealRankRewardInfo;
      
      private var _selfRank:int;
      
      private var _hbox:HBox;
      
      private var _isSpeedMatch:Boolean = false;
      
      public function DCAwardItemView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         _hbox = ComponentFactory.Instance.creatComponentByStylename("dreamland.awards.hbox");
         addChild(_hbox);
      }
      
      public function set info(value:UnrealRankRewardInfo) : void
      {
         _info = value;
         if(_info)
         {
            lbl_type.text = _info.RankMin == _info.RankMax?_info.RankMax.toString():_info.RankMin + "-" + _info.RankMax;
         }
         else
         {
            lbl_type.text = "";
            clip_bg.index = 0;
         }
         if(_info && !_isSpeedMatch && _selfRank >= _info.RankMin && _selfRank <= _info.RankMax)
         {
            clip_bg.index = 1;
         }
         else
         {
            clip_bg.index = 0;
         }
         addAwardItem();
      }
      
      public function set isSpeedMatch(value:Boolean) : void
      {
         _isSpeedMatch = value;
      }
      
      public function set selfRank(value:int) : void
      {
         _selfRank = value;
      }
      
      private function addAwardItem() : void
      {
         var good:* = null;
         var cell:* = null;
         var i:int = 0;
         if(_hbox)
         {
            _hbox.clearAllChild();
         }
         if(_info == null)
         {
            return;
         }
         var awards:Array = _info.Rewards.split("|");
         var awardsLen:int = awards.length;
         for(i = 0; i < awardsLen; )
         {
            good = (awards[i] as String).split(",");
            cell = createItem(good,i);
            _hbox.addChild(cell);
            i++;
         }
         _hbox.arrange();
      }
      
      private function createItem(good:Array, index:int) : BagCell
      {
         var cell:BagCell = new BagCell(index);
         var item:ItemTemplateInfo = ItemManager.Instance.getTemplateById(good[0]);
         cell.setContentSize(41,41);
         cell.BGVisible = false;
         cell.info = item;
         cell.setCount(good[1]);
         return cell;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         while(_hbox && _hbox.numChildren > 0)
         {
            ObjectUtils.disposeObject(_hbox.getChildAt(0));
         }
         _hbox = null;
      }
   }
}
