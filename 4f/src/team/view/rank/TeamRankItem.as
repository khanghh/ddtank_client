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
      
      public function TeamRankItem(){super();}
      
      override protected function initialize() : void{}
      
      public function updaInfo(param1:TeamRankInfo) : void{}
      
      override public function dispose() : void{}
      
      public function set isClick(param1:Boolean) : void{}
      
      public function set index(param1:int) : void{}
      
      public function set isShow(param1:Boolean) : void{}
   }
}
