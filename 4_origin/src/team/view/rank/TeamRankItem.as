package team.view.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import team.TeamManager;
   import team.model.TeamRankInfo;
   import team.view.mornui.Rank.TeamRankItemUI;
   
   public class TeamRankItem extends TeamRankItemUI
   {
       
      
      private var _info:TeamRankInfo;
      
      private var _index:int;
      
      private var _isClick:Boolean;
      
      private var _selectBg:Scale9CornerImage;
      
      private var _isShow:Boolean;
      
      public function TeamRankItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         image_rankIcon.clipsUrl = "asset.coreIcon.orderNo1Asset,asset.coreIcon.orderNo2Asset,asset.coreIcon.orderNo3Asset";
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("team.rank.rankItem.selectBg");
         _selectBg.visible = false;
         addChild(_selectBg);
      }
      
      public function updaInfo(param1:TeamRankInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _info = param1;
         label_name.text = _info.TeamName;
         if(_info.IsVIP > 0)
         {
            label_name.textType = 2;
         }
         label_integral.text = String(_info.TeamScore);
         if(_info.AreaName == null || _info.AreaName == "")
         {
            label_server.text = TeamManager.instance.model.currentAreaName;
         }
         else
         {
            label_server.text = _info.AreaName;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_selectBg)
         {
            ObjectUtils.disposeObject(_selectBg);
         }
         _selectBg = null;
      }
      
      public function set isClick(param1:Boolean) : void
      {
         _isClick = param1;
         _selectBg.visible = _isClick;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         if(_index <= 3)
         {
            image_rankIcon.visible = true;
            label_rank.visible = false;
            image_rankIcon.index = _index - 1;
         }
         else
         {
            image_rankIcon.visible = false;
            label_rank.visible = true;
            label_rank.text = _index + "th";
         }
      }
      
      public function set isShow(param1:Boolean) : void
      {
         _isShow = param1;
         image_rankIcon.visible = _isShow;
         if(!_isShow)
         {
            label_name.text = "";
            label_integral.text = "";
            label_server.text = "";
            label_rank.text = "";
         }
      }
   }
}
