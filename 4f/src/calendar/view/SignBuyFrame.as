package calendar.view{   import calendar.CalendarControl;   import calendar.CalendarManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;      public class SignBuyFrame extends BaseAlerFrame   {                   private var _txt:FilterFrameText;            private var _date:Date;            private var _dayCell:DayCell;            public function SignBuyFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function responseHander(e:FrameEvent) : void { }
            public function set date(date:Date) : void { }
            public function set dayCellClass(cell:DayCell) : void { }
            override public function dispose() : void { }
   }}