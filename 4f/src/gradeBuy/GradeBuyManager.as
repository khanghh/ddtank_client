package gradeBuy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   import shop.view.BuySingleGoodsNoShop;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class GradeBuyManager extends CoreManager
   {
      
      public static const UPDATE:String = "gb_update";
      
      public static const SHOW:String = "gb_show";
      
      private static var instance:GradeBuyManager;
       
      
      private var _hall:HallStateView;
      
      private var _btn:MovieClip;
      
      private var _shown:Boolean = false;
      
      private var _data:Array;
      
      private var _timer:TimerJuggler;
      
      private var _countDownDic:Dictionary;
      
      public function GradeBuyManager(param1:inner){super();}
      
      public static function getInstance() : GradeBuyManager{return null;}
      
      public function get data() : Array{return null;}
      
      public function set data(param1:Array) : void{}
      
      public function setup() : void{}
      
      protected function onShowBtnHandler(param1:PkgEvent) : void{}
      
      public function updateBtn() : void{}
      
      protected function onBtnClick(param1:MouseEvent) : void{}
      
      private function EnterStart() : void{}
      
      public function setHall(param1:HallStateView) : void{}
      
      public function startTimer() : void{}
      
      protected function onTimer(param1:Event) : void{}
      
      public function stopTimer() : void{}
      
      public function viewClosed() : void{}
      
      public function register(param1:String, param2:ICountDown) : void{}
      
      public function unRegister(param1:String) : void{}
      
      public function requireBuy(param1:int, param2:ItemTemplateInfo) : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
