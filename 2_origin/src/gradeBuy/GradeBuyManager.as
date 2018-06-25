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
      
      public function GradeBuyManager(single:inner)
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
      
      public function set data(value:Array) : void
      {
         _data = value;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(325),onShowBtnHandler);
      }
      
      protected function onShowBtnHandler(e:PkgEvent) : void
      {
         var id:int = 0;
         var date:* = null;
         var id0:int = 0;
         var id1:int = 0;
         var id2:int = 0;
         var timeRemain:Number = NaN;
         var pkg:PackageIn = e.pkg;
         _data = [];
         while(pkg.bytesAvailable > 0)
         {
            id = pkg.readInt();
            date = pkg.readDate();
            id0 = pkg.readInt();
            id1 = pkg.readInt();
            id2 = pkg.readInt();
            timeRemain = date.time + 172800000 - TimeManager.Instance.Now().time;
            if(id0 + id1 + id2 != 0 && timeRemain > 0)
            {
               _data.push({
                  "id":id,
                  "date":date.time + 172800000,
                  "id0":id0,
                  "id1":id1,
                  "id2":id2
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
      
      protected function onBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         EnterStart();
      }
      
      private function EnterStart() : void
      {
         dispatchEvent(new CEvent("gb_show"));
      }
      
      public function setHall($hall:HallStateView) : void
      {
         _hall = $hall;
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
      
      protected function onTimer(e:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _countDownDic;
         for each(var v in _countDownDic)
         {
            v.update();
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
      
      public function register($key:String, countDown:ICountDown) : void
      {
         _countDownDic[$key] = countDown;
      }
      
      public function unRegister($key:String) : void
      {
      }
      
      public function requireBuy(typeTempleteID:int, itemInfo:ItemTemplateInfo) : void
      {
         typeTempleteID = typeTempleteID;
         itemInfo = itemInfo;
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
