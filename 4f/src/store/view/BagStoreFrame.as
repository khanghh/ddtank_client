package store.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpBtnEnable;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import powerUp.PowerUpMovieManager;
   import store.StoreController;
   import store.fineStore.view.FineStoreView;
   import store.forge.ForgeMainView;
   import store.newFusion.FusionNewManager;
   import store.states.BaseStoreView;
   
   public class BagStoreFrame extends Frame
   {
       
      
      private var _controller:StoreController;
      
      private var _bg:Scale9CornerImage;
      
      private var _storeBtn:SelectedButton;
      
      private var _forgeBtn:SelectedButton;
      
      private var _fineStoreBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _storeView:BaseStoreView;
      
      private var _forgeView:ForgeMainView;
      
      private var _fineStoreView:FineStoreView;
      
      private var _fightPower:int;
      
      public function BagStoreFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function __soundPlay(param1:MouseEvent) : void{}
      
      public function set controller(param1:StoreController) : void{}
      
      public function show(param1:String) : void{}
      
      private function getStoreType(param1:String) : String{return null;}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
