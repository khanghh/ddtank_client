package calendar.view
{
   import calendar.CalendarControl;
   import calendar.CalendarModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.bossbox.AwardsViewII;
   import ddt.view.bossbox.VipInfoTipBox;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainbutton.MainButtnController;
   import road7th.data.DictionaryData;
   import vip.view.VipViewFrame;
   
   public class CalendarFrame extends Frame
   {
       
      
      private var _model:CalendarModel;
      
      private var _stateback:MovieImage;
      
      private var _currentState:ICalendar;
      
      private var _state:int;
      
      private var _activityList:ActivityList;
      
      private var _titlebitmap:Bitmap;
      
      private var _recentbitmap:Bitmap;
      
      private var _dateCombox:ComboBox;
      
      private var _vipInfoTipBox:VipInfoTipBox;
      
      private var awards:AwardsViewII;
      
      private var alertFrame:BaseAlerFrame;
      
      public function CalendarFrame(param1:CalendarModel){super();}
      
      private function configUI() : void{}
      
      public function lookActivity(param1:Date) : void{}
      
      private function getWeek(param1:int) : String{return null;}
      
      public function get activityList() : ActivityList{return null;}
      
      private function addEvent() : void{}
      
      private function __dateComboxChanged(param1:Event) : void{}
      
      private function __getAward(param1:MouseEvent) : void{}
      
      private function __vipOpen(param1:MouseEvent) : void{}
      
      private function showVipPackage() : void{}
      
      private function __alertHandler(param1:FrameEvent) : void{}
      
      private function __responseVipInfoTipHandler(param1:FrameEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function showAwards(param1:ItemTemplateInfo) : void{}
      
      private function __sendReward(param1:Event) : void{}
      
      private function getVIPInfoTip(param1:DictionaryData) : Array{return null;}
      
      private function _getStrArr(param1:DictionaryData) : Array{return null;}
      
      private function __getFocus(param1:Event) : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function __signCountChanged(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      public function setState(param1:* = null) : void{}
      
      public function showByQQ(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
