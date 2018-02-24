package wantstrong
{
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import wantstrong.data.WantStrongMenuData;
   import wantstrong.event.WantStrongEvent;
   import wantstrong.model.WantStrongModel;
   
   public class WantStrongManager extends EventDispatcher
   {
      
      private static var _instance:WantStrongManager;
       
      
      private var _findBackExist:Boolean;
      
      private var _findBackDataExist:Array;
      
      private var _model:WantStrongModel;
      
      public var findBackDic:Dictionary;
      
      public var isPlayMovie:Boolean;
      
      private var _bossFlag:int;
      
      private var _isAutoGotoFindBack:Boolean = true;
      
      public function WantStrongManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : WantStrongManager{return null;}
      
      public function get isAutoGotoFindBack() : Boolean{return false;}
      
      public function set isAutoGotoFindBack(param1:Boolean) : void{}
      
      public function get bossFlag() : int{return 0;}
      
      public function set bossFlag(param1:int) : void{}
      
      public function get findBackDataExist() : Array{return null;}
      
      public function get findBackExist() : Boolean{return false;}
      
      public function set findBackExist(param1:Boolean) : void{}
      
      public function show() : void{}
      
      private function _loaderCompleteHandle() : void{}
      
      private function findBackHandler(param1:PkgEvent) : void{}
      
      private function updateFindBackView() : void{}
      
      public function setCurrentInfo(param1:* = null, param2:Boolean = false) : void{}
      
      public function setFindBackData(param1:int) : void{}
      
      public function get model() : WantStrongModel{return null;}
      
      public function set model(param1:WantStrongModel) : void{}
      
      public function showFrame(param1:int = 1, param2:Boolean = true) : void{}
   }
}
