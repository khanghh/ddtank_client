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
      
      public function MagicStoneControl()
      {
         super();
      }
      
      public static function get instance() : MagicStoneControl
      {
         if(!_instance)
         {
            _instance = new MagicStoneControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new StoneExploreModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(258,4),__getMagicStoneScore);
         MagicStoneManager.instance.addEventListener("magicStoneOpenView",__openView);
         MagicStoneManager.instance.addEventListener("magicStoneDispose",__disposeView);
         SocketManager.Instance.addEventListener("magicstone_doublescore",__getMagicStoneDoubleScore);
         SocketManager.Instance.addEventListener(PkgEvent.format(284),__MagicStoneMonsterInfo);
      }
      
      private function __MagicStoneMonsterInfo(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _model.normalFightNum = pkg.readInt();
         _model.hardFightNum = pkg.readInt();
         dispatchEvent(new Event("showExploreView"));
      }
      
      private function __getMagicStoneDoubleScore(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         isDoubleScore = pkg.readBoolean();
         pkg.readDate();
         pkg.readDate();
         dispatchEvent(new MagicStoneEvent("magicStoneDoubleScore"));
      }
      
      protected function __disposeView(event:MagicStoneEvent) : void
      {
         magicStoneView = null;
      }
      
      private function __openView(event:MagicStoneEvent) : void
      {
         AssetModuleLoader.addModelLoader("magicStone",6);
         AssetModuleLoader.startCodeLoader(openMagicStoneView);
      }
      
      private function openMagicStoneView() : void
      {
         magicStoneView = ComponentFactory.Instance.creatCustomObject("magicStoneMainView");
         var event:MagicStoneEvent = new MagicStoneEvent("magicStoneLoadComplete");
         event.info = magicStoneView;
         MagicStoneManager.instance.dispatchEvent(event);
      }
      
      protected function __getMagicStoneScore(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         mgStoneScore = pkg.readInt();
         if(_infoView)
         {
            _infoView.updateScore(mgStoneScore);
         }
         if(_shopFrame)
         {
            _shopFrame.updateScore(mgStoneScore);
         }
      }
      
      public function playUpgradeMc() : void
      {
         if(!_upgradeMC)
         {
            _upgradeMC = ComponentFactory.Instance.creat("magicStone.upgradeMc");
            _upgradeMC.x = 285;
            _upgradeMC.y = 188;
            _upgradeMC.addEventListener("enterFrame",__disposeUpgradeMC);
            LayerManager.Instance.addToLayer(_upgradeMC,0,false,1,true);
            _upgradeMC.gotoAndPlay(1);
         }
      }
      
      protected function __disposeUpgradeMC(event:Event) : void
      {
         var mc:MovieClip = event.target as MovieClip;
         if(mc.currentFrame == mc.totalFrames)
         {
            mc.gotoAndStop(1);
            mc.removeEventListener("enterFrame",__disposeUpgradeMC);
            ObjectUtils.disposeObject(mc);
            mc = null;
         }
      }
      
      public function get infoView() : MagicStoneInfoView
      {
         return _infoView;
      }
      
      public function set infoView(value:MagicStoneInfoView) : void
      {
         _infoView = value;
      }
      
      public function get shopFrame() : MagicStoneShopFrame
      {
         return _shopFrame;
      }
      
      public function set shopFrame(value:MagicStoneShopFrame) : void
      {
         _shopFrame = value;
      }
      
      public function get model() : StoneExploreModel
      {
         return _model;
      }
      
      public function set model(value:StoneExploreModel) : void
      {
         _model = value;
      }
   }
}
