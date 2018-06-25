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
      
      public function NewTitleManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      protected function __onGetHideTitleFlag(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         NewTitleManager.instance.ShowTitle = !pkg.readBoolean();
      }
      
      public function newTitleDataSetup(analyzer:NewTitleDataAnalyz) : void
      {
         _titleInfo = analyzer.list;
         _titleArray = [];
         var _loc4_:int = 0;
         var _loc3_:* = _titleInfo;
         for(var id in _titleInfo)
         {
            _titleArray.push(_titleInfo[id]);
         }
         _titleArray.sortOn("Order",16);
      }
      
      public function getTitleByName(name:String) : NewTitleModel
      {
         var i:int = 0;
         var title:NewTitleModel = null;
         for(i = 0; i < _titleArray.length; )
         {
            if(_titleArray[i].Name == name)
            {
               title = _titleArray[i];
               break;
            }
            i++;
         }
         return title;
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
