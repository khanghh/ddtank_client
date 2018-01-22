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
      
      public function CalendarFrame(param1:CalendarModel)
      {
         super();
         _model = param1;
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         _stateback = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.StateBg");
         addToContent(_stateback);
         _activityList = ComponentFactory.Instance.creatCustomObject("ddtcalendar.ActivityList",[_model]);
         addToContent(_activityList);
         _recentbitmap = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityRecent");
         addToContent(_recentbitmap);
         _dateCombox = ComponentFactory.Instance.creatComponentByStylename("dateSelect.combox");
         var _loc1_:Rectangle = ComponentFactory.Instance.creatCustomObject("dateSelect.comboxRec");
         ObjectUtils.copyPropertyByRectangle(_dateCombox,_loc1_);
         _dateCombox.beginChanges();
         _dateCombox.selctedPropName = "text";
         _dateCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("ddt.today"));
         _dateCombox.listPanel.vectorListModel.append(getWeek(1));
         _dateCombox.listPanel.vectorListModel.append(getWeek(2));
         _dateCombox.listPanel.vectorListModel.append(getWeek(3));
         _dateCombox.listPanel.vectorListModel.append(getWeek(4));
         _dateCombox.listPanel.vectorListModel.append(getWeek(5));
         _dateCombox.listPanel.vectorListModel.append(getWeek(6));
         _dateCombox.commitChanges();
         _dateCombox.textField.text = LanguageMgr.GetTranslation("ddt.today");
         addToContent(_dateCombox);
      }
      
      public function lookActivity(param1:Date) : void
      {
      }
      
      private function getWeek(param1:int) : String
      {
         var _loc5_:* = null;
         var _loc2_:Boolean = false;
         var _loc3_:Date = _model.today;
         var _loc4_:Date = new Date(_loc3_.fullYearUTC,_loc3_.monthUTC,_loc3_.dateUTC + param1);
         if(_loc3_.day > _loc4_.day)
         {
            if(_loc4_.day == 0)
            {
               _loc2_ = false;
            }
            else
            {
               _loc2_ = true;
            }
         }
         var _loc6_:* = _loc4_.day;
         if(0 !== _loc6_)
         {
            if(1 !== _loc6_)
            {
               if(2 !== _loc6_)
               {
                  if(3 !== _loc6_)
                  {
                     if(4 !== _loc6_)
                     {
                        if(5 !== _loc6_)
                        {
                           if(6 === _loc6_)
                           {
                              if(_loc2_)
                              {
                                 _loc5_ = LanguageMgr.GetTranslation("ddt.weekNextSaturday");
                              }
                              else
                              {
                                 _loc5_ = LanguageMgr.GetTranslation("ddt.weekSaturday");
                              }
                           }
                        }
                        else if(_loc2_)
                        {
                           _loc5_ = LanguageMgr.GetTranslation("ddt.weekNextFriday");
                        }
                        else
                        {
                           _loc5_ = LanguageMgr.GetTranslation("ddt.weekFriday");
                        }
                     }
                     else if(_loc2_)
                     {
                        _loc5_ = LanguageMgr.GetTranslation("ddt.weekNextThursday");
                     }
                     else
                     {
                        _loc5_ = LanguageMgr.GetTranslation("ddt.weekThursday");
                     }
                  }
                  else if(_loc2_)
                  {
                     _loc5_ = LanguageMgr.GetTranslation("ddt.weekNextWednesday");
                  }
                  else
                  {
                     _loc5_ = LanguageMgr.GetTranslation("ddt.weekWednesday");
                  }
               }
               else if(_loc2_)
               {
                  _loc5_ = LanguageMgr.GetTranslation("ddt.weekNextTuesday");
               }
               else
               {
                  _loc5_ = LanguageMgr.GetTranslation("ddt.weekTuesday");
               }
            }
            else if(_loc2_)
            {
               _loc5_ = LanguageMgr.GetTranslation("ddt.weekNextMonday");
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("ddt.weekMonday");
            }
         }
         else if(_loc2_)
         {
            _loc5_ = LanguageMgr.GetTranslation("ddt.weekNextSunday");
         }
         else
         {
            _loc5_ = LanguageMgr.GetTranslation("ddt.weekSunday");
         }
         return _loc5_;
      }
      
      public function get activityList() : ActivityList
      {
         return _activityList;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__response);
         addEventListener("addedToStage",__getFocus);
         _dateCombox.addEventListener("stateChange",__dateComboxChanged);
      }
      
      private function __dateComboxChanged(param1:Event) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = _dateCombox.currentSelectedIndex;
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc4_:Date = new Date(_loc3_.fullYearUTC,_loc3_.monthUTC,_loc3_.dateUTC + _loc2_,_loc3_.hours,_loc3_.minutes,_loc3_.seconds);
         CalendarControl.getInstance().lookActivity(_loc4_);
      }
      
      private function __getAward(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CalendarControl.getInstance().reciveDayAward();
      }
      
      private function __vipOpen(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         showVipPackage();
      }
      
      private function showVipPackage() : void
      {
         if(PlayerManager.Instance.Self.canTakeVipReward || PlayerManager.Instance.Self.IsVIP == false)
         {
            new HelperUIModuleLoad().loadUIModule(["ddtvipview"],function():void
            {
               _vipInfoTipBox = ComponentFactory.Instance.creat("vip.VipInfoTipFrame");
               _vipInfoTipBox.escEnable = true;
               _vipInfoTipBox.vipAwardGoodsList = getVIPInfoTip(BossBoxManager.instance.inventoryItemList);
               _vipInfoTipBox.addEventListener("response",__responseVipInfoTipHandler);
               LayerManager.Instance.addToLayer(_vipInfoTipBox,3,true,1);
            });
         }
         else
         {
            var incream:int = 0;
            var date:Date = PlayerManager.Instance.Self.systemDate as Date;
            var nowDate:Date = new Date();
            alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.vip.vipView.cueDateScript",nowDate.month + 1,nowDate.date + 1),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
            alertFrame.moveEnable = false;
            alertFrame.addEventListener("response",__alertHandler);
         }
      }
      
      private function __alertHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         alertFrame.removeEventListener("response",__alertHandler);
         if(alertFrame && alertFrame.parent)
         {
            alertFrame.parent.removeChild(alertFrame);
         }
         if(alertFrame)
         {
            alertFrame.dispose();
         }
         alertFrame = null;
      }
      
      private function __responseVipInfoTipHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _vipInfoTipBox.removeEventListener("response",__responseHandler);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _vipInfoTipBox.dispose();
               _vipInfoTipBox = null;
               break;
            case 2:
               MainButtnController.instance.VipAwardState = false;
               MainButtnController.instance.dispatchEvent(new Event(MainButtnController.ICONCLOSE));
               showAwards(_vipInfoTipBox.selectCellInfo);
               _vipInfoTipBox.dispose();
               _vipInfoTipBox = null;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         awards.removeEventListener("response",__responseHandler);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               awards.dispose();
               awards = null;
         }
      }
      
      private function showAwards(param1:ItemTemplateInfo) : void
      {
         awards = ComponentFactory.Instance.creat("vip.awardFrame");
         awards.escEnable = true;
         awards.boxType = 2;
         awards.vipAwardGoodsList = _getStrArr(BossBoxManager.instance.inventoryItemList);
         awards.addEventListener("response",__responseHandler);
         awards.addEventListener("_haveBtnClick",__sendReward);
         LayerManager.Instance.addToLayer(awards,3,true,1);
      }
      
      private function __sendReward(param1:Event) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendDailyAward(3);
         awards.removeEventListener("_haveBtnClick",__sendReward);
         awards.dispose();
         PlayerManager.Instance.Self.canTakeVipReward = false;
      }
      
      private function getVIPInfoTip(param1:DictionaryData) : Array
      {
         var _loc2_:* = null;
         _loc2_ = PlayerManager.Instance.Self.VIPLevel == 12?[ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 2])),ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1]))]:[ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1])),ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel]))];
         return _loc2_;
      }
      
      private function _getStrArr(param1:DictionaryData) : Array
      {
         var _loc2_:Array = param1[VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1]];
         return _loc2_;
      }
      
      private function __getFocus(param1:Event) : void
      {
         removeEventListener("addedToStage",__getFocus);
         StageReferance.stage.focus = this;
      }
      
      private function __response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               CalendarControl.getInstance().close();
               dispose();
            default:
               CalendarControl.getInstance().close();
               dispose();
            default:
            case 4:
               CalendarControl.getInstance().close();
               dispose();
         }
      }
      
      private function __signCountChanged(param1:Event) : void
      {
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         removeEventListener("addedToStage",__getFocus);
      }
      
      public function setState(param1:* = null) : void
      {
         if(_state != param1)
         {
            _state = param1;
            ObjectUtils.disposeObject(_currentState);
            _currentState = null;
            _currentState = ComponentFactory.Instance.creatCustomObject("ddtcalendar.ActivityState",[_model]);
            addToContent(_currentState as DisplayObject);
         }
         if(_currentState)
         {
            _currentState.setData(param1);
         }
      }
      
      public function showByQQ(param1:int) : void
      {
         _activityList.showByQQ(param1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_stateback);
         _stateback = null;
         ObjectUtils.disposeObject(_activityList);
         _activityList = null;
         ObjectUtils.disposeObject(_currentState);
         _currentState = null;
         ObjectUtils.disposeObject(_titlebitmap);
         _titlebitmap = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
