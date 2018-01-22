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
      
      public function GradeBuyManager(param1:inner)
      {
         _data = [];
         _countDownDic = new Dictionary();
         super();
      }
      
      public static function getInstance() : GradeBuyManager
      {
         if(!instance)
         {
            instance = new GradeBuyManager(new inner());
         }
         return instance;
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function set data(param1:Array) : void
      {
         _data = param1;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(325),onShowBtnHandler);
      }
      
      protected function onShowBtnHandler(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc8_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Number = NaN;
         var _loc7_:PackageIn = param1.pkg;
         _data = [];
         while(_loc7_.bytesAvailable > 0)
         {
            _loc3_ = _loc7_.readInt();
            _loc8_ = _loc7_.readDate();
            _loc6_ = _loc7_.readInt();
            _loc5_ = _loc7_.readInt();
            _loc4_ = _loc7_.readInt();
            _loc2_ = _loc8_.time + 172800000 - TimeManager.Instance.Now().time;
            if(_loc6_ + _loc5_ + _loc4_ != 0 && _loc2_ > 0)
            {
               _data.push({
                  "id":_loc3_,
                  "date":_loc8_.time + 172800000,
                  "id0":_loc6_,
                  "id1":_loc5_,
                  "id2":_loc4_
               });
            }
         }
         if(_data.length > 0)
         {
            _shown = false;
         }
         updateBtn();
      }
      
      public function updateBtn() : void
      {
         if(_hall != null && _data.length > 0)
         {
            if(_btn == null)
            {
               _btn = ComponentFactory.Instance.creat("asset.hall.gradeBuy");
               PositionUtils.setPos(_btn,"ddt.hall.gradeBuyPos");
               _btn.buttonMode = true;
               _btn.useHandCursor = true;
            }
            _btn.gotoAndStop(!!_shown?1:2);
            _btn.addEventListener("click",onBtnClick);
            _hall.addChild(_btn);
         }
         else
         {
            _btn && _btn.removeEventListener("click",onBtnClick);
            ObjectUtils.disposeObject(_btn);
            _btn = null;
         }
      }
      
      protected function onBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         EnterStart();
      }
      
      private function EnterStart() : void
      {
         dispatchEvent(new CEvent("gb_show"));
      }
      
      public function setHall(param1:HallStateView) : void
      {
         _hall = param1;
         updateBtn();
      }
      
      public function startTimer() : void
      {
         if(_timer != null)
         {
            stopTimer();
         }
         _timer = TimerManager.getInstance().addTimerJuggler(1000,0);
         _timer.addEventListener("timer",onTimer);
         _timer.start();
      }
      
      protected function onTimer(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _countDownDic;
         for each(var _loc2_ in _countDownDic)
         {
            _loc2_.update();
         }
      }
      
      public function stopTimer() : void
      {
         if(_timer == null)
         {
            return;
         }
         _timer.stop();
         _timer.removeEventListener("timer",onTimer);
         TimerManager.getInstance().removeJugglerByTimer(_timer);
         _timer = null;
      }
      
      public function viewClosed() : void
      {
         _shown = true;
      }
      
      public function register(param1:String, param2:ICountDown) : void
      {
         _countDownDic[param1] = param2;
      }
      
      public function unRegister(param1:String) : void
      {
      }
      
      public function requireBuy(param1:int, param2:ItemTemplateInfo) : void
      {
         typeTempleteID = param1;
         itemInfo = param2;
         onBuy = function():void
         {
            GameInSocketOut.sendGradeBuy(typeTempleteID,itemInfo.TemplateID);
         };
         var buyView:BuySingleGoodsNoShop = new BuySingleGoodsNoShop();
         LayerManager.Instance.addToLayer(buyView,3,true,1);
         buyView.isDisCount = true;
         buyView.goodsID = itemInfo.TemplateID;
         buyView.numberSelecter.valueLimit = "1,1";
         buyView.numberSelecter.validate();
         buyView.onBuy = onBuy;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
