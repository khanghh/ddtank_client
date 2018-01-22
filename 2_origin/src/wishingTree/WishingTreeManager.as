package wishingTree
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   
   public class WishingTreeManager extends CoreManager
   {
      
      public static const WISHING_TREE_OPEN:String = "wishingTreeOpen";
      
      private static var _instance:WishingTreeManager;
       
      
      private var _hallStateView:HallStateView;
      
      private var _isShowIcon:Boolean;
      
      private var _wishingTreeIcon:MovieClip;
      
      public function WishingTreeManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : WishingTreeManager
      {
         if(!_instance)
         {
            _instance = new WishingTreeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(299,1),__wishingTreeOpen);
      }
      
      protected function __wishingTreeOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _isShowIcon;
         _isShowIcon = _loc2_.readBoolean();
         if(_isShowIcon)
         {
            showEnterIcon();
         }
         else if(_loc3_)
         {
            hideEnterIcon();
         }
      }
      
      private function showEnterIcon() : void
      {
         if(_hallStateView)
         {
            addEnterIcon(_hallStateView);
         }
         ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("wishingTree.open"));
      }
      
      private function hideEnterIcon() : void
      {
         disposeEnterIcon();
         ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("wishingTree.close"));
      }
      
      public function addEnterIcon(param1:HallStateView) : void
      {
         _hallStateView = param1;
         if(_hallStateView && _isShowIcon)
         {
            disposeEnterIcon();
            _wishingTreeIcon = ComponentFactory.Instance.creat("asset.hall.wishingTreeIcon");
            _wishingTreeIcon.y = 11;
            _wishingTreeIcon.buttonMode = true;
            _wishingTreeIcon.addEventListener("click",__wishingTreeIconClick);
         }
      }
      
      private function disposeEnterIcon() : void
      {
         if(_wishingTreeIcon)
         {
            _wishingTreeIcon.removeEventListener("click",__wishingTreeIconClick);
            _wishingTreeIcon = null;
         }
      }
      
      protected function __wishingTreeIconClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         show();
      }
      
      override protected function start() : void
      {
         dispatchEvent(new Event("wishingTreeOpen"));
      }
      
      public function get wishingTreeIcon() : MovieClip
      {
         return _wishingTreeIcon;
      }
   }
}
