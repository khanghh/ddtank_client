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
      
      public function DdtKingLettersCollectController(single:inner)
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
      
      protected function __onGetNationInfo(e:PkgEvent) : void
      {
         var i:int = 0;
         var type:int = 0;
         var pkg:PackageIn = e.pkg;
         var count:int = pkg.readInt();
         var _loc7_:* = new Dictionary();
         DdtKingLettersCollectManager.getInstance().WordArray = _loc7_;
         var wordArr:* = _loc7_;
         for(i = 0; i < count; )
         {
            type = pkg.readInt();
            wordArr[type] = pkg.readInt();
            i++;
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
      
      private function onEvtShow(e:CEvent) : void
      {
         SocketManager.Instance.out.getNationDayInfo();
      }
      
      public function get isShow() : Boolean
      {
         return _isShow;
      }
      
      public function set isShow(value:Boolean) : void
      {
         _isShow = value;
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
