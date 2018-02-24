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
      
      public function MemoryGameManager(){super();}
      
      public static function get instance() : MemoryGameManager{return null;}
      
      public function setup() : void{}
      
      private function __onGameOpen(param1:PkgEvent) : void{}
      
      override protected function start() : void{}
      
      private function onComplete() : void{}
      
      public function playOpenAllComplete() : Boolean{return false;}
      
      public function playCloseAllComplete() : Boolean{return false;}
      
      public function playActionAllComplete() : Boolean{return false;}
      
      public function playOpenStart() : void{}
      
      public function playOpenStop() : void{}
      
      public function playCloseStart() : void{}
      
      public function playCloseStop() : void{}
      
      public function get count() : int{return 0;}
      
      public function set count(param1:int) : void{}
      
      public function get score() : int{return 0;}
      
      public function set score(param1:int) : void{}
      
      public function dateToString() : String{return null;}
      
      public function get endDate() : Date{return null;}
      
      public function analyzer(param1:MemoryGameAnalyzer) : void{}
      
      public function goodsList() : Vector.<MemoryGameGoodsInfo>{return null;}
      
      public function get isValid() : Boolean{return false;}
   }
}
