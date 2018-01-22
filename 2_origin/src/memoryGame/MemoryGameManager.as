package memoryGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.HelperUIModuleLoad;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import memoryGame.analyzer.MemoryGameAnalyzer;
   import memoryGame.data.MemoryGameGoodsInfo;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class MemoryGameManager extends CoreManager
   {
      
      private static var _instance:MemoryGameManager;
       
      
      public var turning:Boolean = false;
      
      public var getRewardList:DictionaryData;
      
      private var _isOpen:Boolean;
      
      private var _hall:HallStateView;
      
      private var _icon:BaseButton;
      
      private var _endDate:Date;
      
      private var _playOpenComplete:int;
      
      private var _playCloseComplete:int;
      
      private var _count:int;
      
      private var _score:int;
      
      private var _list:Vector.<MemoryGameGoodsInfo>;
      
      public function MemoryGameManager()
      {
         super();
         getRewardList = new DictionaryData();
      }
      
      public static function get instance() : MemoryGameManager
      {
         if(!_instance)
         {
            _instance = new MemoryGameManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(329,10),__onGameOpen);
      }
      
      private function __onGameOpen(param1:PkgEvent) : void
      {
         _isOpen = param1.pkg.readBoolean();
         _endDate = param1.pkg.readDate();
         HallIconManager.instance.updateSwitchHandler("memoryGame",_isOpen);
      }
      
      override protected function start() : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.creatMemoryGameAwardLoader],function():void
         {
            new HelperUIModuleLoad().loadUIModule(["memoryGame"],onComplete);
         });
      }
      
      private function onComplete() : void
      {
         var _loc1_:* = ComponentFactory.Instance.creatComponentByStylename("memoryGame.MemoryGameFrame");
         _loc1_.show();
      }
      
      public function playOpenAllComplete() : Boolean
      {
         return _playOpenComplete == 0;
      }
      
      public function playCloseAllComplete() : Boolean
      {
         return _playCloseComplete == 0;
      }
      
      public function playActionAllComplete() : Boolean
      {
         return playOpenAllComplete() && playCloseAllComplete();
      }
      
      public function playOpenStart() : void
      {
         _playOpenComplete = Number(_playOpenComplete) + 1;
      }
      
      public function playOpenStop() : void
      {
         _playOpenComplete = Number(_playOpenComplete) - 1;
      }
      
      public function playCloseStart() : void
      {
         _playCloseComplete = Number(_playCloseComplete) + 1;
      }
      
      public function playCloseStop() : void
      {
         _playCloseComplete = Number(_playCloseComplete) - 1;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function set score(param1:int) : void
      {
         if(_score == param1)
         {
            return;
         }
         _score = param1;
      }
      
      public function dateToString() : String
      {
         return DateUtils.dateFormat(_endDate);
      }
      
      public function get endDate() : Date
      {
         return _endDate;
      }
      
      public function analyzer(param1:MemoryGameAnalyzer) : void
      {
         _list = param1.list;
      }
      
      public function goodsList() : Vector.<MemoryGameGoodsInfo>
      {
         return _list;
      }
      
      public function get isValid() : Boolean
      {
         var _loc2_:Number = _endDate.getTime();
         var _loc1_:Number = TimeManager.Instance.Now().getTime();
         if(_loc2_ > _loc1_)
         {
            return true;
         }
         return false;
      }
   }
}
