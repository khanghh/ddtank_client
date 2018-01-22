package newTitle
{
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import newTitle.analyzer.NewTitleDataAnalyz;
   import newTitle.event.NewTitleEvent;
   import newTitle.model.NewTitleModel;
   import road7th.comm.PackageIn;
   
   public class NewTitleManager extends CoreManager
   {
      
      public static var FIRST_TITLEID:int = 602;
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:NewTitleManager;
       
      
      public var ShowTitle:Boolean = true;
      
      private var _titleInfo:Dictionary;
      
      private var _titleArray:Array;
      
      public function NewTitleManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : NewTitleManager
      {
         if(!_instance)
         {
            _instance = new NewTitleManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(279),__onGetHideTitleFlag);
      }
      
      protected function __onGetHideTitleFlag(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         NewTitleManager.instance.ShowTitle = !_loc2_.readBoolean();
      }
      
      public function newTitleDataSetup(param1:NewTitleDataAnalyz) : void
      {
         _titleInfo = param1.list;
         _titleArray = [];
         var _loc4_:int = 0;
         var _loc3_:* = _titleInfo;
         for(var _loc2_ in _titleInfo)
         {
            _titleArray.push(_titleInfo[_loc2_]);
         }
         _titleArray.sortOn("Order",16);
      }
      
      public function getTitleByName(param1:String) : NewTitleModel
      {
         var _loc3_:int = 0;
         var _loc2_:NewTitleModel = null;
         _loc3_ = 0;
         while(_loc3_ < _titleArray.length)
         {
            if(_titleArray[_loc3_].Name == param1)
            {
               _loc2_ = _titleArray[_loc3_];
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new NewTitleEvent("newTitleOpenView"));
      }
      
      public function get titleInfo() : Dictionary
      {
         return _titleInfo;
      }
      
      public function get titleArray() : Array
      {
         return _titleArray;
      }
   }
}
