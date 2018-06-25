package totem.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.ui.LayerManager;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import morn.core.handlers.Handler;   import totem.TotemControl;   import totem.TotemManager;   import totem.data.TotemUpGradDataVo;   import totem.mornUI.TotemUpGradeViewUI;      public class TotemUpGradeView extends TotemUpGradeViewUI   {                   private var _preItem:TotemUpGradeItemView;            private var _nextItem:TotemUpGradeItemView;            private var _curPage:int = -1;            private var _clickNum:Number = 0;            public function TotemUpGradeView(page:int) { super(); }
            override protected function initialize() : void { }
            private function __closeHandler() : void { }
            private function __upGradeHandler() : void { }
            private function get canClick() : Boolean { return false; }
            public function show() : void { }
            private function updateData(evt:CEvent) : void { }
            private function checkIsCanUpGrade() : Boolean { return false; }
            private function creatTotemGoodItem(temID1:int, temID2:int) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}