package ddtKingLettersCollect
{
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreController;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddtKingLettersCollect.view.DdtKingLettersView;
   import flash.utils.Dictionary;
   import nationDay.NationDayManager;
   import road7th.comm.PackageIn;
   
   public class DdtKingLettersCollectController extends CoreController
   {
      
      private static var instance:DdtKingLettersCollectController;
       
      
      private var _manager:DdtKingLettersCollectManager;
      
      private var _isShow:Boolean = false;
      
      private var ddtKingLettersView:DdtKingLettersView;
      
      public function DdtKingLettersCollectController(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : DdtKingLettersCollectController
      {
         if(!instance)
         {
            instance = new DdtKingLettersCollectController(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         if(NationDayManager.instance.curActivity != "lt_ddt_king")
         {
            return;
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(288,2),__onGetNationInfo);
         _manager = DdtKingLettersCollectManager.getInstance();
         addEventsMap([["dklc_show",onEvtShow]],_manager);
      }
      
      protected function __onGetNationInfo(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:int = _loc4_.readInt();
         var _loc7_:* = new Dictionary();
         DdtKingLettersCollectManager.getInstance().WordArray = _loc7_;
         var _loc2_:* = _loc7_;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = _loc4_.readInt();
            _loc2_[_loc5_] = _loc4_.readInt();
            _loc6_++;
         }
         if(isShow)
         {
            ddtKingLettersView.update();
         }
         else
         {
            new HelperUIModuleLoad().loadUIModule(["ddtKingLetters"],onLoadRes);
         }
      }
      
      private function onEvtShow(param1:CEvent) : void
      {
         SocketManager.Instance.out.getNationDayInfo();
      }
      
      public function get isShow() : Boolean
      {
         return _isShow;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         _isShow = param1;
         if(_isShow == false)
         {
            ddtKingLettersView = null;
         }
      }
      
      private function onLoadRes() : void
      {
         ddtKingLettersView = new DdtKingLettersView();
         LayerManager.Instance.addToLayer(ddtKingLettersView,3,true,1);
         isShow = true;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
