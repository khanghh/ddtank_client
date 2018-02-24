package magicStone
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import magicStone.components.MgStoneCell;
   import magicStone.event.MagicStoneEvent;
   import magicStone.stoneExploreView.StoneExploreModel;
   import magicStone.views.MagicStoneInfoView;
   import magicStone.views.MagicStoneMainView;
   import magicStone.views.MagicStoneShopFrame;
   import road7th.comm.PackageIn;
   
   public class MagicStoneControl extends EventDispatcher
   {
      
      public static const SHOWEXPLOREVIEW:String = "showExploreView";
      
      private static var _instance:MagicStoneControl;
       
      
      public var singleFeedFunc:Function;
      
      public var singleFeedCell:MgStoneCell;
      
      public var mgStoneScore:int = 0;
      
      private var _infoView:MagicStoneInfoView;
      
      private var _shopFrame:MagicStoneShopFrame;
      
      private var _upgradeMC:MovieClip;
      
      public var isNoPrompt:Boolean;
      
      public var isBatNoPrompt:Boolean;
      
      public var isBand:Boolean;
      
      public var isBatBand:Boolean;
      
      public var magicStoneView:MagicStoneMainView;
      
      public var isDoubleScore:Boolean;
      
      private var _model:StoneExploreModel;
      
      public function MagicStoneControl(){super();}
      
      public static function get instance() : MagicStoneControl{return null;}
      
      public function setup() : void{}
      
      private function __MagicStoneMonsterInfo(param1:CrazyTankSocketEvent) : void{}
      
      private function __getMagicStoneDoubleScore(param1:CrazyTankSocketEvent) : void{}
      
      protected function __disposeView(param1:MagicStoneEvent) : void{}
      
      private function __openView(param1:MagicStoneEvent) : void{}
      
      private function openMagicStoneView() : void{}
      
      protected function __getMagicStoneScore(param1:PkgEvent) : void{}
      
      public function playUpgradeMc() : void{}
      
      protected function __disposeUpgradeMC(param1:Event) : void{}
      
      public function get infoView() : MagicStoneInfoView{return null;}
      
      public function set infoView(param1:MagicStoneInfoView) : void{}
      
      public function get shopFrame() : MagicStoneShopFrame{return null;}
      
      public function set shopFrame(param1:MagicStoneShopFrame) : void{}
      
      public function get model() : StoneExploreModel{return null;}
      
      public function set model(param1:StoneExploreModel) : void{}
   }
}
