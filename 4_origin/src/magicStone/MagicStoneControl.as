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
      
      private function __MagicStoneMonsterInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.normalFightNum = _loc2_.readInt();
         _model.hardFightNum = _loc2_.readInt();
         dispatchEvent(new Event("showExploreView"));
      }
      
      private function __getMagicStoneDoubleScore(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         isDoubleScore = _loc2_.readBoolean();
         _loc2_.readDate();
         _loc2_.readDate();
         dispatchEvent(new MagicStoneEvent("magicStoneDoubleScore"));
      }
      
      protected function __disposeView(param1:MagicStoneEvent) : void
      {
         magicStoneView = null;
      }
      
      private function __openView(param1:MagicStoneEvent) : void
      {
         AssetModuleLoader.addModelLoader("magicStone",6);
         AssetModuleLoader.startCodeLoader(openMagicStoneView);
      }
      
      private function openMagicStoneView() : void
      {
         magicStoneView = ComponentFactory.Instance.creatCustomObject("magicStoneMainView");
         var _loc1_:MagicStoneEvent = new MagicStoneEvent("magicStoneLoadComplete");
         _loc1_.info = magicStoneView;
         MagicStoneManager.instance.dispatchEvent(_loc1_);
      }
      
      protected function __getMagicStoneScore(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         mgStoneScore = _loc2_.readInt();
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
      
      protected function __disposeUpgradeMC(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.gotoAndStop(1);
            _loc2_.removeEventListener("enterFrame",__disposeUpgradeMC);
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
      }
      
      public function get infoView() : MagicStoneInfoView
      {
         return _infoView;
      }
      
      public function set infoView(param1:MagicStoneInfoView) : void
      {
         _infoView = param1;
      }
      
      public function get shopFrame() : MagicStoneShopFrame
      {
         return _shopFrame;
      }
      
      public function set shopFrame(param1:MagicStoneShopFrame) : void
      {
         _shopFrame = param1;
      }
      
      public function get model() : StoneExploreModel
      {
         return _model;
      }
      
      public function set model(param1:StoneExploreModel) : void
      {
         _model = param1;
      }
   }
}
