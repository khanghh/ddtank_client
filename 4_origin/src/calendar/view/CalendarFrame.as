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
      
      public function CalendarFrame(model:CalendarModel)
      {
         super();
         _model = model;
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
         var rec:Rectangle = ComponentFactory.Instance.creatCustomObject("dateSelect.comboxRec");
         ObjectUtils.copyPropertyByRectangle(_dateCombox,rec);
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
      
      public function lookActivity(date:Date) : void
      {
      }
      
      private function getWeek(add:int) : String
      {
         var week:* = null;
         var isNext:Boolean = false;
         var today:Date = _model.today;
         var date:Date = new Date(today.fullYearUTC,today.monthUTC,today.dateUTC + add);
         if(today.day > date.day)
         {
            if(date.day == 0)
            {
               isNext = false;
            }
            else
            {
               isNext = true;
            }
         }
         var _loc6_:* = date.day;
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
                              if(isNext)
                              {
                                 week = LanguageMgr.GetTranslation("ddt.weekNextSaturday");
                              }
                              else
                              {
                                 week = LanguageMgr.GetTranslation("ddt.weekSaturday");
                              }
                           }
                        }
                        else if(isNext)
                        {
                           week = LanguageMgr.GetTranslation("ddt.weekNextFriday");
                        }
                        else
                        {
                           week = LanguageMgr.GetTranslation("ddt.weekFriday");
                        }
                     }
                     else if(isNext)
                     {
                        week = LanguageMgr.GetTranslation("ddt.weekNextThursday");
                     }
                     else
                     {
                        week = LanguageMgr.GetTranslation("ddt.weekThursday");
                     }
                  }
                  else if(isNext)
                  {
                     week = LanguageMgr.GetTranslation("ddt.weekNextWednesday");
                  }
                  else
                  {
                     week = LanguageMgr.GetTranslation("ddt.weekWednesday");
                  }
               }
               else if(isNext)
               {
                  week = LanguageMgr.GetTranslation("ddt.weekNextTuesday");
               }
               else
               {
                  week = LanguageMgr.GetTranslation("ddt.weekTuesday");
               }
            }
            else if(isNext)
            {
               week = LanguageMgr.GetTranslation("ddt.weekNextMonday");
            }
            else
            {
               week = LanguageMgr.GetTranslation("ddt.weekMonday");
            }
         }
         else if(isNext)
         {
            week = LanguageMgr.GetTranslation("ddt.weekNextSunday");
         }
         else
         {
            week = LanguageMgr.GetTranslation("ddt.weekSunday");
         }
         return week;
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
      
      private function __dateComboxChanged(e:Event) : void
      {
         SoundManager.instance.play("008");
         var index:int = _dateCombox.currentSelectedIndex;
         var today:Date = TimeManager.Instance.Now();
         var date:Date = new Date(today.fullYearUTC,today.monthUTC,today.dateUTC + index,today.hours,today.minutes,today.seconds);
         CalendarControl.getInstance().lookActivity(date);
      }
      
      private function __getAward(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CalendarControl.getInstance().reciveDayAward();
      }
      
      private function __vipOpen(e:MouseEvent) : void
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
      
      private function __alertHandler(event:FrameEvent) : void
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
      
      private function __responseVipInfoTipHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _vipInfoTipBox.removeEventListener("response",__responseHandler);
         switch(int(event.responseCode))
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
      
      private function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         awards.removeEventListener("response",__responseHandler);
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               awards.dispose();
               awards = null;
         }
      }
      
      private function showAwards(para:ItemTemplateInfo) : void
      {
         awards = ComponentFactory.Instance.creat("vip.awardFrame");
         awards.escEnable = true;
         awards.boxType = 2;
         awards.vipAwardGoodsList = _getStrArr(BossBoxManager.instance.inventoryItemList);
         awards.addEventListener("response",__responseHandler);
         awards.addEventListener("_haveBtnClick",__sendReward);
         LayerManager.Instance.addToLayer(awards,3,true,1);
      }
      
      private function __sendReward(event:Event) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendDailyAward(3);
         awards.removeEventListener("_haveBtnClick",__sendReward);
         awards.dispose();
         PlayerManager.Instance.Self.canTakeVipReward = false;
      }
      
      private function getVIPInfoTip(dic:DictionaryData) : Array
      {
         var resultGoodsArray:* = null;
         resultGoodsArray = PlayerManager.Instance.Self.VIPLevel == 12?[ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 2])),ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1]))]:[ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1])),ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel]))];
         return resultGoodsArray;
      }
      
      private function _getStrArr(dic:DictionaryData) : Array
      {
         var goodsArr:Array = dic[VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1]];
         return goodsArr;
      }
      
      private function __getFocus(evt:Event) : void
      {
         removeEventListener("addedToStage",__getFocus);
         StageReferance.stage.focus = this;
      }
      
      private function __response(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
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
      
      private function __signCountChanged(event:Event) : void
      {
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         removeEventListener("addedToStage",__getFocus);
      }
      
      public function setState(data:* = null) : void
      {
         if(_state != data)
         {
            _state = data;
            ObjectUtils.disposeObject(_currentState);
            _currentState = null;
            _currentState = ComponentFactory.Instance.creatCustomObject("ddtcalendar.ActivityState",[_model]);
            addToContent(_currentState as DisplayObject);
         }
         if(_currentState)
         {
            _currentState.setData(data);
         }
      }
      
      public function showByQQ(activeID:int) : void
      {
         _activityList.showByQQ(activeID);
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
