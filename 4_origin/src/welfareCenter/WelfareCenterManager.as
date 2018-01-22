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
      
      public function getitemIsOpen(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(int(param1))
         {
            case 0:
               _loc2_ = CallBackFundManager.instance.isOpen;
               break;
            case 1:
               _loc2_ = CallBackLotteryDrawManager.instance.callBackLotteryDrawModel.isOpen;
               break;
            case 2:
               _loc2_ = gradeGiftIsOpen;
         }
         return _loc2_;
      }
      
      public function getItemShine(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(int(param1))
         {
            case 0:
               _loc2_ = getitemIsOpen(param1) && CallBackFundManager.instance.state == 1;
               break;
            case 1:
               _loc2_ = getitemIsOpen(param1) && CallBackLotteryDrawManager.instance.getCallBackLeftSec() <= 0;
               break;
            case 2:
               _loc2_ = getitemIsOpen(param1) && PlayerManager.Instance.Self.Grade >= gradeList[_gradeGiftProgress];
         }
         return _loc2_;
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
      
      private function __onClickIcon(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         new HelperUIModuleLoad().loadUIModule(["welfareCenter"],show);
      }
      
      private function get isOpen() : Boolean
      {
         var _loc2_:Boolean = CallBackLotteryDrawManager.instance.callBackLotteryDrawModel.isOpen;
         var _loc1_:Boolean = CallBackFundManager.instance.isOpen;
         _isOpen = _loc2_ || _loc1_ || gradeGiftIsOpen;
         return _isOpen;
      }
      
      private function __onOldPlayerGradeGift(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         _gradeGiftIsOpen = param1.pkg.readBoolean();
         _gradeGiftProgress = param1.pkg.readInt();
         if(_gradeGiftIsOpen)
         {
            _loc2_ = param1.pkg.readDate();
            _gradeGiftEndTime = _loc2_.time + 7 * 86400000;
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
      
      public function __onGradeChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"])
         {
            checkShineIcon();
         }
      }
      
      public function checkShineIcon() : void
      {
      }
   }
}
