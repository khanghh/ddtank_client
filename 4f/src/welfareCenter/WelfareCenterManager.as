package welfareCenter{   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelperUIModuleLoad;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.MouseEvent;   import hall.IHallStateView;   import hallIcon.HallIconManager;   import welfareCenter.callBackFund.CallBackFundManager;   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;      [Event(name="change",type="flash.events.Event")]   public class WelfareCenterManager extends CoreManager   {            public static const SHOW:String = "welfareCenterShow";            private static var _instance:WelfareCenterManager;                   private var _hall:IHallStateView;            private var _icon:MovieClip;            private var _isOpen:Boolean;            private var _gradeGiftIsOpen:Boolean;            private var _gradeGiftProgress:int;            private var _gradeGiftEndTime:Number;            private const gradeList:Array = [12,20,30,35];            public function WelfareCenterManager() { super(); }
            public static function get instance() : WelfareCenterManager { return null; }
            public function setup() : void { }
            public function getitemIsOpen($type:int) : Boolean { return false; }
            public function getItemShine($type:int) : Boolean { return false; }
            public function showMainIcon() : void { }
            public function showView() : void { }
            override protected function start() : void { }
            private function __onClickIcon(e:MouseEvent) : void { }
            private function get isOpen() : Boolean { return false; }
            private function __onOldPlayerGradeGift(e:PkgEvent) : void { }
            private function get gradeGiftIsOpen() : Boolean { return false; }
            public function get gradeGiftProgress() : int { return 0; }
            public function get gradeGiftEndTime() : Number { return 0; }
            public function __onGradeChange(evt:PlayerPropertyEvent) : void { }
            public function checkShineIcon() : void { }
   }}