package calendar.view{   import calendar.CalendarControl;   import calendar.CalendarModel;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.BossBoxManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.HelperUIModuleLoad;   import ddt.view.bossbox.AwardsViewII;   import ddt.view.bossbox.VipInfoTipBox;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Rectangle;   import mainbutton.MainButtnController;   import road7th.data.DictionaryData;   import vip.view.VipViewFrame;      public class CalendarFrame extends Frame   {                   private var _model:CalendarModel;            private var _stateback:MovieImage;            private var _currentState:ICalendar;            private var _state:int;            private var _activityList:ActivityList;            private var _titlebitmap:Bitmap;            private var _recentbitmap:Bitmap;            private var _dateCombox:ComboBox;            private var _vipInfoTipBox:VipInfoTipBox;            private var awards:AwardsViewII;            private var alertFrame:BaseAlerFrame;            public function CalendarFrame(model:CalendarModel) { super(); }
            private function configUI() : void { }
            public function lookActivity(date:Date) : void { }
            private function getWeek(add:int) : String { return null; }
            public function get activityList() : ActivityList { return null; }
            private function addEvent() : void { }
            private function __dateComboxChanged(e:Event) : void { }
            private function __getAward(event:MouseEvent) : void { }
            private function __vipOpen(e:MouseEvent) : void { }
            private function showVipPackage() : void { }
            private function __alertHandler(event:FrameEvent) : void { }
            private function __responseVipInfoTipHandler(event:FrameEvent) : void { }
            private function __responseHandler(event:FrameEvent) : void { }
            private function showAwards(para:ItemTemplateInfo) : void { }
            private function __sendReward(event:Event) : void { }
            private function getVIPInfoTip(dic:DictionaryData) : Array { return null; }
            private function _getStrArr(dic:DictionaryData) : Array { return null; }
            private function __getFocus(evt:Event) : void { }
            private function __response(event:FrameEvent) : void { }
            private function __signCountChanged(event:Event) : void { }
            private function removeEvent() : void { }
            public function setState(data:* = null) : void { }
            public function showByQQ(activeID:int) : void { }
            override public function dispose() : void { }
   }}