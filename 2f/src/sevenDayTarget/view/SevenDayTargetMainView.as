package sevenDayTarget.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.image.ScaleBitmapImage;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;   import sevenDayTarget.controller.SevenDayTargetManager;   import sevenDayTarget.model.NewTargetQuestionInfo;      public class SevenDayTargetMainView extends Frame   {                   private var _topBg:Bitmap;            private var _downBg:Bitmap;            private var grayFilter:ColorMatrixFilter;            private var lightFilter:ColorMatrixFilter;            private var dayArray:Array;            private var _rewardList:SimpleTileList;            private var _rewardArray:Array;            private var _finishBnt:BaseButton;            private var _todayQuestInfo:NewTargetQuestionInfo;            private var conditionSp1:SevenDayTargetConditionCell;            private var conditionSp2:SevenDayTargetConditionCell;            private var conditionSp3:SevenDayTargetConditionCell;            private var _helpBnt:BaseButton;            private var _downBack:ScaleBitmapImage;            public function SevenDayTargetMainView() { super(); }
            public function get todayQuestInfo() : NewTargetQuestionInfo { return null; }
            private function initView() : void { }
            private function addHelpBnt() : void { }
            protected function __onHelpClick(event:MouseEvent) : void { }
            private function initDayView() : void { }
            private function initTargetView() : void { }
            private function initRewardView() : void { }
            private function __getReward(e:MouseEvent) : void { }
            private function createDayClicker() : void { }
            private function __dayClick(e:MouseEvent) : void { }
            public function updateTargetView() : void { }
            public function updateRewardView() : void { }
            private function changeDaysText() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            override public function dispose() : void { }
            public function show() : void { }
   }}