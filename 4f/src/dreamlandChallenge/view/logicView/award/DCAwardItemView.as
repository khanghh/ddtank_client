package dreamlandChallenge.view.logicView.award{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import dreamlandChallenge.data.UnrealRankRewardInfo;   import dreamlandChallenge.view.mornui.award.DCAwardItemViewUI;      public class DCAwardItemView extends DCAwardItemViewUI   {                   private var _info:UnrealRankRewardInfo;            private var _selfRank:int;            private var _hbox:HBox;            private var _isSpeedMatch:Boolean = false;            public function DCAwardItemView() { super(); }
            override protected function initialize() : void { }
            public function set info(value:UnrealRankRewardInfo) : void { }
            public function set isSpeedMatch(value:Boolean) : void { }
            public function set selfRank(value:int) : void { }
            private function addAwardItem() : void { }
            private function createItem(good:Array, index:int) : BagCell { return null; }
            override public function dispose() : void { }
   }}