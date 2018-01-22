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
      
      public function WantStrongManager(param1:IEventDispatcher = null)
      {
         super(param1);
         _model = new WantStrongModel();
      }
      
      public static function get Instance() : WantStrongManager
      {
         if(_instance == null)
         {
            _instance = new WantStrongManager();
         }
         return _instance;
      }
      
      public function get isAutoGotoFindBack() : Boolean
      {
         return _isAutoGotoFindBack;
      }
      
      public function set isAutoGotoFindBack(param1:Boolean) : void
      {
         _isAutoGotoFindBack = param1;
      }
      
      public function get bossFlag() : int
      {
         return _bossFlag;
      }
      
      public function set bossFlag(param1:int) : void
      {
         _bossFlag = param1;
      }
      
      public function get findBackDataExist() : Array
      {
         if(_findBackDataExist == null)
         {
            _findBackDataExist = [];
            _findBackDataExist.push(false);
            _findBackDataExist.push(false);
            _findBackDataExist.push(false);
            _findBackDataExist.push(false);
            _findBackDataExist.push(false);
         }
         return _findBackDataExist;
      }
      
      public function get findBackExist() : Boolean
      {
         return _findBackExist;
      }
      
      public function set findBackExist(param1:Boolean) : void
      {
         _findBackExist = param1;
         isPlayMovie = param1;
      }
      
      public function show() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(147),findBackHandler);
         AssetModuleLoader.addModelLoader("wantstrong",6);
         AssetModuleLoader.startLoader(_loaderCompleteHandle);
      }
      
      private function _loaderCompleteHandle() : void
      {
         dispatchEvent(new WantStrongEvent("wantStrongOpenView"));
      }
      
      private function findBackHandler(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Array = [];
         _loc3_[0] = param1.pkg.readBoolean();
         _loc3_[1] = param1.pkg.readBoolean();
         if(isPlayMovie)
         {
            if(_loc3_[0] || _loc3_[1])
            {
               isPlayMovie = false;
               WantStrongManager.Instance.dispatchEvent(new Event("alreadyFindBack"));
            }
         }
         findBackDic[_loc2_] = _loc3_;
         _loc5_ = 0;
         while(_loc5_ < _model.data[5].length)
         {
            if((_model.data[5][_loc5_] as WantStrongMenuData).bossType == _loc2_)
            {
               (_model.data[5][_loc5_] as WantStrongMenuData).freeBackBtnEnable = !_loc3_[0];
               (_model.data[5][_loc5_] as WantStrongMenuData).allBackBtnEnable = !_loc3_[1];
               if(_loc3_[0] && _loc3_[1])
               {
                  _loc4_ = _model.data[5];
                  _loc4_.splice(_loc5_,1);
                  if(_loc2_ == 6)
                  {
                     findBackDataExist[0] = false;
                  }
                  else if(_loc2_ == 18)
                  {
                     findBackDataExist[1] = false;
                  }
                  else if(_loc2_ == 19)
                  {
                     findBackDataExist[2] = false;
                  }
                  else if(_loc2_ == 4)
                  {
                     findBackDataExist[4] = false;
                  }
                  else if(_loc2_ == 5)
                  {
                     findBackDataExist[3] = false;
                  }
               }
            }
            _loc5_++;
         }
         updateFindBackView();
      }
      
      private function updateFindBackView() : void
      {
         if(_model.data[5].length > 0)
         {
            _model.activeId = 5;
         }
         else
         {
            _model.activeId = 1;
         }
         dispatchEvent(new Event("cellChange"));
         setCurrentInfo(_model.data[_model.activeId],true);
      }
      
      public function setCurrentInfo(param1:* = null, param2:Boolean = false) : void
      {
         var _loc3_:Object = {};
         _loc3_["data"] = param1;
         _loc3_["stateChange"] = param2;
         dispatchEvent(new WantStrongEvent("wantStrongSetInfo",_loc3_));
      }
      
      public function setFindBackData(param1:int) : void
      {
         findBackDataExist[param1] = true;
      }
      
      public function get model() : WantStrongModel
      {
         return _model;
      }
      
      public function set model(param1:WantStrongModel) : void
      {
         _model = param1;
      }
      
      public function showFrame(param1:int = 1, param2:Boolean = true) : void
      {
         if(_model == null)
         {
            _model = new WantStrongModel();
         }
         _model.activeId = param1;
         _isAutoGotoFindBack = param2;
         show();
      }
   }
}
