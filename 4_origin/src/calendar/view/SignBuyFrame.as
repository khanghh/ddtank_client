package calendar.view
{
   import calendar.CalendarControl;
   import calendar.CalendarManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   
   public class SignBuyFrame extends BaseAlerFrame
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _date:Date;
      
      private var _dayCell:DayCell;
      
      public function SignBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.view.task.dayCell.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"));
         info = _loc1_;
         _txt = ComponentFactory.Instance.creatComponentByStylename("dayCell.alert.txt");
         _txt.text = LanguageMgr.GetTranslation("dayCell.alert.text",CalendarManager.getInstance().price,5 - CalendarManager.getInstance().times);
         addToContent(_txt);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHander);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHander);
      }
      
      private function responseHander(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.Money < CalendarManager.getInstance().price)
            {
               LeavePageManager.showFillFrame();
               dispose();
               return;
            }
            SocketManager.Instance.out.sendDaySign(_date);
            if(CalendarControl.getInstance().signNew(_date))
            {
               _dayCell.playSignAnimation("asset.ddtcalendar.Grid.SignAnimation");
            }
            dispose();
         }
         else if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            dispose();
         }
      }
      
      public function set date(param1:Date) : void
      {
         _date = param1;
      }
      
      public function set dayCellClass(param1:DayCell) : void
      {
         _dayCell = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
