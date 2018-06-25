package anotherDimension.view{   import anotherDimension.AnotherDimensionControl;   import anotherDimension.controller.AnotherDimensionManager;   import anotherDimension.model.AnotherDimensionInfo;   import anotherDimension.model.AnotherDimensionMsgInfo;   import anotherDimension.model.AnotherDimensionResourceInfo;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.MouseEvent;   import gameCommon.GameControl;   import room.RoomManager;   import room.model.RoomInfo;      public class AnotherDimensionMainView extends Frame   {                   private var _helpBnt:BaseButton;            private var _bg:Bitmap;            private var _searchBnt:BaseButton;            private var _helpBnt2:BaseButton;            private var _closeBnt:BaseButton;            private var _downBg:Bitmap;            private var _canZhanlingTxt:FilterFrameText;            private var _canLueduoTxt:FilterFrameText;            private var _canZhanlingCountTxt:FilterFrameText;            private var _canLueduoCountTxt:FilterFrameText;            private var _shijiankongzhiSelect:SelectedCheckButton;            private var _kongjianzhangwoSelect:SelectedCheckButton;            private var _lueduodashiSelect:SelectedCheckButton;            private var _shijiankongzhiTxt:FilterFrameText;            private var _kongjianzhangwoTxt:FilterFrameText;            private var _lueduodashiTxt:FilterFrameText;            private var _levelTxt:FilterFrameText;            private var _itemCell:AnotherDimensionItemCell;            private var _upGradeBnt:BaseButton;            private var _allInSelect:SelectedCheckButton;            private var _progress:AnotherDimensionProgress;            private var _type:int = 1;            private var oneItemExp:int = 10;            private var otherItemArr:Array;            private var selfItemArr:Array;            private var _selectBtn:SelectedCheckButton;            private var alert:BaseAlerFrame;            private var timeLvMax:Boolean = false;            private var spaceLvMax:Boolean = false;            private var lootLvMax:Boolean = false;            private var _vbox:VBox;            private var _scrollPanel:ScrollPanel;            public function AnotherDimensionMainView() { super(); }
            private function initView() : void { }
            public function setResourceData() : void { }
            private function initEvent() : void { }
            private function openHelpViewHander(e:MouseEvent) : void { }
            private function frameEvent(e:FrameEvent) : void { }
            protected function __onStartLoad(event:Event) : void { }
            private function __addMsg(e:Event) : void { }
            private function _showMCOver(e:Event) : void { }
            private function __updateInfoView(e:Event) : void { }
            private function __upGradeClick(e:MouseEvent) : void { }
            private function removeEvent() : void { }
            private function __searchClick(e:MouseEvent) : void { }
            private function __onClickSelectedBtn(e:MouseEvent) : void { }
            private function __onRecoverResponse(e:FrameEvent) : void { }
            private function _closeClick(e:MouseEvent) : void { }
            private function _shijiankongzhiSelectClick(e:MouseEvent) : void { }
            private function _kongjianzhangwoSelectClick(e:MouseEvent) : void { }
            private function _lueduodashiSelectClick(e:MouseEvent) : void { }
            private function getTimeControlExpBylv(lv:int) : Array { return null; }
            private function getTimeControlExpBylv_1(lv:int) : Array { return null; }
            private function getSpaceControlExpBylv(lv:int) : Array { return null; }
            private function getSpaceControlExpBylv_1(lv:int) : Array { return null; }
            private function getLooterControlExpBylv(lv:int) : Array { return null; }
            private function getLooterControlExpBylv_1(lv:int) : Array { return null; }
            private function addSelectionBnt() : void { }
            private function addMsgView() : void { }
            public function addMsg(msg:String) : void { }
            private function __helpBntClick(e:MouseEvent) : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}