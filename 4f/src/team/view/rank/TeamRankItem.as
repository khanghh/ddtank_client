package team.view.rank{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.utils.ObjectUtils;   import team.TeamManager;   import team.model.TeamRankInfo;   import team.view.mornui.Rank.TeamRankItemUI;      public class TeamRankItem extends TeamRankItemUI   {                   private var _info:TeamRankInfo;            private var _index:int;            private var _isClick:Boolean;            private var _selectBg:Scale9CornerImage;            private var _isShow:Boolean;            public function TeamRankItem() { super(); }
            override protected function initialize() : void { }
            public function updaInfo(info:TeamRankInfo) : void { }
            override public function dispose() : void { }
            public function set isClick(value:Boolean) : void { }
            public function set index(value:int) : void { }
            public function set isShow(value:Boolean) : void { }
   }}