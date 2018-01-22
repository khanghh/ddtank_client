package newChickenBox.model
{
   import flash.events.EventDispatcher;
   
   public class NewChickenBoxModel extends EventDispatcher
   {
      
      private static var _instance:NewChickenBoxModel = null;
       
      
      private var _templateIDList:Array;
      
      public var canOpenCounts:int;
      
      public var openCardPrice:Array;
      
      public var canEagleEyeCounts:int;
      
      public var eagleEyePrice:Array;
      
      public var flushPrice:int;
      
      public var boxCount:int;
      
      private var _canclickEnable:Boolean = false;
      
      public var clickEagleEye:Boolean = false;
      
      public var AlertFlush:Boolean = true;
      
      public var alertEye:Boolean = true;
      
      public var alertOpenCard:Boolean = true;
      
      public var countEye:int = 0;
      
      public var currentEyePrice:int;
      
      public var currentCardPrice:int;
      
      public var isShowAll:Boolean;
      
      public var lastFlushTime:Date;
      
      public var freeFlushTime:int;
      
      public var countTime:int = 0;
      
      public var itemList:Array;
      
      public var firstEnterHelp:Boolean = true;
      
      public var freeOpenCardCount:int = 0;
      
      public var freeEyeCount:int = 0;
      
      public var freeRefreshBoxCount:int = 0;
      
      public var endTime:Date;
      
      public function NewChickenBoxModel()
      {
         super();
         if(_templateIDList == null)
         {
            _templateIDList = [];
            openCardPrice = [];
            eagleEyePrice = [];
            itemList = [];
         }
      }
      
      public static function get instance() : NewChickenBoxModel
      {
         if(_instance == null)
         {
            _instance = new NewChickenBoxModel();
         }
         return _instance;
      }
      
      public function get canclickEnable() : Boolean
      {
         return _canclickEnable;
      }
      
      public function set canclickEnable(param1:Boolean) : void
      {
         _canclickEnable = param1;
      }
      
      public function get templateIDList() : Array
      {
         return _templateIDList;
      }
      
      public function set templateIDList(param1:Array) : void
      {
         _templateIDList = param1;
      }
   }
}
