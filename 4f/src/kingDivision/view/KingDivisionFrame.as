package kingDivision.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import gameCommon.GameControl;   import kingDivision.KingDivisionManager;   import room.RoomManager;   import room.model.RoomInfo;   import store.HelpFrame;      public class KingDivisionFrame extends Frame   {            private static const THISZONE:int = 0;            private static const ALLZONE:int = 1;                   private var _outSideFrame:Bitmap;            private var _thisZone:SelectedButton;            private var _allZone:SelectedButton;            private var _tabSelectedButtonGroup:SelectedButtonGroup;            private var _titleImg:Bitmap;            private var _helpBtn:BaseButton;            private var _quaFrame:QualificationsFrame;            private var _proBar:ProgressBarView;            private var _ranFrame:RankingRoundView;            private var _stateNo:Boolean;            public function KingDivisionFrame() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            protected function __onStartLoad(event:Event) : void { }
            private function __changeHandler(e:Event) : void { }
            private function selectShow() : void { }
            private function defaultShowThisZoneView() : void { }
            private function timeShowView(dateArr:Array, zone:int) : void { }
            protected function __onHelpClick(event:MouseEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            public function get qualificationsFrame() : QualificationsFrame { return null; }
            public function get rankingRoundView() : RankingRoundView { return null; }
            override public function dispose() : void { }
   }}