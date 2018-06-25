package welfareCenter
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hall.IHallStateView;
   import hallIcon.HallIconManager;
   import welfareCenter.callBackFund.CallBackFundManager;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   
   [Event(name="change",type="flash.events.Event")]
   public class WelfareCenterManager extends CoreManager
   {
      
      public static const SHOW:String = "welfareCenterShow";
      
      private static var _instance:WelfareCenterManager;
       
      
      private var _hall:IHallStateView;
      
      private var _icon:MovieClip;
      
      private var _isOpen:Boolean;
      
      private var _gradeGiftIsOpen:Boolean;
      
      private var _gradeGiftProgress:int;
      
      private var _gradeGiftEndTime:Number;
      
      private const gradeList:Array = [12,20,30,35];
      
      public function WelfareCenterManager()
      {
         super();
      }
      
      public static function get instance() : WelfareCenterManager
      {
         if(_instance == null)
         {
            _instance = new WelfareCenterManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(343,10),__onOldPlayerGradeGift);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onGradeChange);
      }
      
      public function getitemIsOpen($type:int) : Boolean
      {
         var isOpen:Boolean = false;
         switch(int($type))
         {
            case 0:
               isOpen = CallBackFundManager.instance.isOpen;
               break;
            case 1:
               isOpen = CallBackLotteryDrawManager.instance.callBackLotteryDrawModel.isOpen;
               break;
            case 2:
               isOpen = gradeGiftIsOpen;
         }
         return isOpen;
      }
      
      public function getItemShine($type:int) : Boolean
      {
         var isShine:Boolean = false;
         switch(int($type))
         {
            case 0:
               isShine = getitemIsOpen($type) && CallBackFundManager.instance.state == 1;
               break;
            case 1:
               isShine = getitemIsOpen($type) && CallBackLotteryDrawManager.instance.getCallBackLeftSec() <= 0;
               break;
            case 2:
               isShine = getitemIsOpen($type) && PlayerManager.Instance.Self.Grade >= gradeList[_gradeGiftProgress];
         }
         return isShine;
      }
      
      public function showMainIcon() : void
      {
         if(!CallBackFundManager.instance.isOpen && !CallBackLotteryDrawManager.instance.callBackLotteryDrawModel.isOpen && !gradeGiftIsOpen)
         {
            HallIconManager.instance.updateSwitchHandler("welfareCenter",false);
         }
         else
         {
            HallIconManager.instance.updateSwitchHandler("welfareCenter",true);
         }
      }
      
      public function showView() : void
      {
         new HelperUIModuleLoad().loadUIModule(["welfareCenter"],show);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("welfareCenterShow"));
      }
      
      private function __onClickIcon(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         new HelperUIModuleLoad().loadUIModule(["welfareCenter"],show);
      }
      
      private function get isOpen() : Boolean
      {
         var callLotteryIsOpen:Boolean = CallBackLotteryDrawManager.instance.callBackLotteryDrawModel.isOpen;
         var callFundIsOpen:Boolean = CallBackFundManager.instance.isOpen;
         _isOpen = callLotteryIsOpen || callFundIsOpen || gradeGiftIsOpen;
         return _isOpen;
      }
      
      private function __onOldPlayerGradeGift(e:PkgEvent) : void
      {
         var date:* = null;
         _gradeGiftIsOpen = e.pkg.readBoolean();
         _gradeGiftProgress = e.pkg.readInt();
         if(_gradeGiftIsOpen)
         {
            date = e.pkg.readDate();
            _gradeGiftEndTime = date.time + 7 * 86400000;
         }
         dispatchEvent(new Event("change"));
         showMainIcon();
         checkShineIcon();
      }
      
      private function get gradeGiftIsOpen() : Boolean
      {
         return _gradeGiftIsOpen && _gradeGiftProgress < 4;
      }
      
      public function get gradeGiftProgress() : int
      {
         return _gradeGiftProgress;
      }
      
      public function get gradeGiftEndTime() : Number
      {
         return _gradeGiftEndTime;
      }
      
      public function __onGradeChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["Grade"])
         {
            checkShineIcon();
         }
      }
      
      public function checkShineIcon() : void
      {
      }
   }
}
