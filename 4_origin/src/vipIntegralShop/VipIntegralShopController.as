package vipIntegralShop
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.PkgEvent;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.VipIntegralShopManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   import vipIntegralShop.data.VipIntegralShopDataAnalyzer;
   import vipIntegralShop.data.VipIntegralShopInfo;
   import vipIntegralShop.view.VipIntegralShopView;
   
   public class VipIntegralShopController extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:VipIntegralShopController;
       
      
      private var _integralShopView:VipIntegralShopView;
      
      private var _goodsInfoList:Vector.<VipIntegralShopInfo>;
      
      private var _limitDic:Dictionary;
      
      public function VipIntegralShopController()
      {
         super();
      }
      
      public static function get instance() : VipIntegralShopController
      {
         if(!_instance)
         {
            _instance = new VipIntegralShopController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         VipIntegralShopManager.Instance.addEventListener("vipintgralOpenView",__onOpenView);
      }
      
      protected function __onUpdateShopView(event:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         if(count > 0)
         {
            for(i = 0; i < count; )
            {
               limitDic[pkg.readInt()] = pkg.readInt();
               i++;
            }
         }
         _integralShopView.refreshView();
      }
      
      private function __onOpenView(event:Event) : void
      {
         initData();
      }
      
      private function initData() : void
      {
         _limitDic = new Dictionary();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("VipStoreList.xml"),5);
         loader.analyzer = new VipIntegralShopDataAnalyzer(getGoodsInfoList);
         loader.addEventListener("complete",__onComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      protected function __onComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",__onComplete);
         show();
      }
      
      private function getGoodsInfoList(analyzer:VipIntegralShopDataAnalyzer) : void
      {
         _goodsInfoList = analyzer.shopInfoVec;
      }
      
      public function show() : void
      {
         if(loadComplete)
         {
            showIntegralShopFrame();
         }
         else if(useFirst)
         {
            AssetModuleLoader.addModelLoader("vipintegralshop",6);
            AssetModuleLoader.startCodeLoader(__complainShow);
         }
      }
      
      public function hide() : void
      {
         if(_integralShopView != null)
         {
            _integralShopView.dispose();
         }
         _integralShopView = null;
         SocketManager.Instance.removeEventListener(PkgEvent.format(312),__onUpdateShopView);
      }
      
      private function __complainShow() : void
      {
         loadComplete = true;
         useFirst = false;
         show();
      }
      
      private function showIntegralShopFrame() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(312),__onUpdateShopView);
         _integralShopView = ComponentFactory.Instance.creatComponentByStylename("vipIntegralshop.vipIntegralShopView");
         LayerManager.Instance.addToLayer(_integralShopView,3,true,2);
      }
      
      public function get goodsInfoList() : Vector.<VipIntegralShopInfo>
      {
         return _goodsInfoList;
      }
      
      public function get limitDic() : Dictionary
      {
         return _limitDic;
      }
   }
}
