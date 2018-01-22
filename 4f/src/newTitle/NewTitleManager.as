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
      
      public function NewTitleManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : NewTitleManager{return null;}
      
      public function setup() : void{}
      
      protected function __onGetHideTitleFlag(param1:PkgEvent) : void{}
      
      public function newTitleDataSetup(param1:NewTitleDataAnalyz) : void{}
      
      public function getTitleByName(param1:String) : NewTitleModel{return null;}
      
      override protected function start() : void{}
      
      public function get titleInfo() : Dictionary{return null;}
      
      public function get titleArray() : Array{return null;}
   }
}
