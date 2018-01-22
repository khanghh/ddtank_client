package wantstrong
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import wantstrong.event.WantStrongEvent;
   import wantstrong.model.WantStrongModel;
   import wantstrong.view.WantStrongFrame;
   
   public class WantStrongControl extends EventDispatcher
   {
      
      private static var _instance:WantStrongControl;
       
      
      private var _frame:Frame;
      
      private var _initState;
      
      private var _isTimeUpdated:Boolean;
      
      public function WantStrongControl(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : WantStrongControl
      {
         if(_instance == null)
         {
            _instance = new WantStrongControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         WantStrongManager.Instance.addEventListener("wantStrongOpenView",__onOpenView);
         WantStrongManager.Instance.addEventListener("wantStrongSetInfo",__onSetCurrentInfo);
      }
      
      private function setData() : void
      {
         if(WantStrongManager.Instance.findBackExist)
         {
            WantStrongManager.Instance.model.initFindBackData();
            if(!WantStrongManager.Instance.isAutoGotoFindBack)
            {
               WantStrongManager.Instance.model.activeId = 5;
            }
         }
         WantStrongManager.Instance.model.initData();
         _initState = WantStrongManager.Instance.model.data[WantStrongManager.Instance.model.activeId];
      }
      
      public function setFindBackData(param1:int) : void
      {
         WantStrongManager.Instance.findBackDataExist[param1] = true;
      }
      
      protected function __onSetCurrentInfo(param1:WantStrongEvent) : void
      {
         setCurrentInfo(param1.data.data,param1.data.stateChange);
      }
      
      public function setCurrentInfo(param1:* = null, param2:Boolean = false) : void
      {
         if(_frame)
         {
            (_frame as WantStrongFrame).setInfo(param1,param2);
         }
      }
      
      protected function __onOpenView(param1:WantStrongEvent) : void
      {
         if(!WantStrongManager.Instance.model)
         {
            WantStrongManager.Instance.model = new WantStrongModel();
         }
         setData();
         _frame = ComponentFactory.Instance.creatCustomObject("wantStrong.WantStrongFrame",[WantStrongManager.Instance.model]);
         _frame.titleText = LanguageMgr.GetTranslation("ddt.wantStrong.view.titleText");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
         setCurrentInfo(_initState);
      }
      
      public function setinitState(param1:*) : void
      {
         _initState = param1;
      }
      
      public function get isTimeUpdated() : Boolean
      {
         return _isTimeUpdated;
      }
      
      public function set isTimeUpdated(param1:Boolean) : void
      {
         _isTimeUpdated = param1;
      }
      
      public function close() : void
      {
         ObjectUtils.disposeObject(WantStrongManager.Instance.model);
         WantStrongManager.Instance.model = null;
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
      }
   }
}
