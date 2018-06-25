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
      
      public function WantStrongManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function set isAutoGotoFindBack(value:Boolean) : void
      {
         _isAutoGotoFindBack = value;
      }
      
      public function get bossFlag() : int
      {
         return _bossFlag;
      }
      
      public function set bossFlag(value:int) : void
      {
         _bossFlag = value;
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
      
      public function set findBackExist(value:Boolean) : void
      {
         _findBackExist = value;
         isPlayMovie = value;
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
      
      private function findBackHandler(e:PkgEvent) : void
      {
         var i:int = 0;
         var data:* = undefined;
         var bType:int = e.pkg.readInt();
         var arr:Array = [];
         arr[0] = e.pkg.readBoolean();
         arr[1] = e.pkg.readBoolean();
         if(isPlayMovie)
         {
            if(arr[0] || arr[1])
            {
               isPlayMovie = false;
               WantStrongManager.Instance.dispatchEvent(new Event("alreadyFindBack"));
            }
         }
         findBackDic[bType] = arr;
         for(i = 0; i < _model.data[5].length; )
         {
            if((_model.data[5][i] as WantStrongMenuData).bossType == bType)
            {
               (_model.data[5][i] as WantStrongMenuData).freeBackBtnEnable = !arr[0];
               (_model.data[5][i] as WantStrongMenuData).allBackBtnEnable = !arr[1];
               if(arr[0] && arr[1])
               {
                  data = _model.data[5];
                  data.splice(i,1);
                  if(bType == 6)
                  {
                     findBackDataExist[0] = false;
                  }
                  else if(bType == 18)
                  {
                     findBackDataExist[1] = false;
                  }
                  else if(bType == 19)
                  {
                     findBackDataExist[2] = false;
                  }
                  else if(bType == 4)
                  {
                     findBackDataExist[4] = false;
                  }
                  else if(bType == 5)
                  {
                     findBackDataExist[3] = false;
                  }
               }
            }
            i++;
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
      
      public function setCurrentInfo(data:* = null, stateChange:Boolean = false) : void
      {
         var info:Object = {};
         info["data"] = data;
         info["stateChange"] = stateChange;
         dispatchEvent(new WantStrongEvent("wantStrongSetInfo",info));
      }
      
      public function setFindBackData(index:int) : void
      {
         findBackDataExist[index] = true;
      }
      
      public function get model() : WantStrongModel
      {
         return _model;
      }
      
      public function set model(value:WantStrongModel) : void
      {
         _model = value;
      }
      
      public function showFrame(activeId:int = 1, isAutoGotoFindBack:Boolean = true) : void
      {
         if(_model == null)
         {
            _model = new WantStrongModel();
         }
         _model.activeId = activeId;
         _isAutoGotoFindBack = isAutoGotoFindBack;
         show();
      }
   }
}
