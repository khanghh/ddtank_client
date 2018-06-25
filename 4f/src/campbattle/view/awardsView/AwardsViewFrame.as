package campbattle.view.awardsView{   import campbattle.CampBattleManager;   import campbattle.view.CampBattleHelpView;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.MouseEvent;      public class AwardsViewFrame extends Frame   {            private static const AWARDS:int = 0;            private static const MYAWARDS:int = 1;                   private var _bg:ScaleBitmapImage;            private var _awardsBtn:SelectedButton;            private var _myAwardsBtn:SelectedButton;            private var _selectedBtnGroup:SelectedButtonGroup;            private var _rewardList:AwardsList;            private var _rewardPanel:ScrollPanel;            private var _bg1:Bitmap;            private var _txt:FilterFrameText;            private var _helpBtn:BaseButton;            public function AwardsViewFrame() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            protected function __onHelpBtnClick(event:MouseEvent) : void { }
            private function frameEvent(event:FrameEvent) : void { }
            private function __typeChange(evt:Event) : void { }
            private function defaultShowThisZoneView() : void { }
            private function updateRewardList() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}