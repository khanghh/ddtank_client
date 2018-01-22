package treasureHunting
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.InventoryItemAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.caddyII.CaddyAwardListFrame;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.LookTrophy;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   import treasureHunting.event.TreasureEvent;
   import treasureHunting.views.TreasureHuntingFrame;
   
   public class TreasureControl extends EventDispatcher
   {
      
      private static var _instance:TreasureControl;
       
      
      private var _treasureFrame:TreasureHuntingFrame;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _bagData:Dictionary;
      
      private var _mask:Sprite;
      
      private var _showPrize:LookTrophy;
      
      private var _listView:CaddyAwardListFrame;
      
      public var isMovieComplete:Boolean = true;
      
      public var isAlert:Boolean = false;
      
      public var lightIndexArr:Array;
      
      public var msgStr:String;
      
      public var countMsg:String;
      
      public function TreasureControl()
      {
         super();
         _bagData = new Dictionary();
      }
      
      public static function get instance() : TreasureControl
      {
         if(!_instance)
         {
            _instance = new TreasureControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         TreasureManager.instance.addEventListener("teasureOpenView",__onOpenView);
         SocketManager.Instance.addEventListener(PkgEvent.format(110,2),onPayForHunting);
         PlayerManager.Instance.Self.CaddyBag.addEventListener("update",_update);
         TreasureManager.instance.addEventListener("teasureRemoveMask",__onRemoveMask);
      }
      
      protected function __onOpenView(param1:Event) : void
      {
         loadTreasureHuntingModule(addTreasureFrame);
      }
      
      private function addTreasureFrame() : void
      {
         if(RouletteManager.instance.goodList == null)
         {
            LoadResourceManager.Instance.startLoad(LoaderCreate.Instance.creatRouletteTempleteLoader(loadComplete));
            return;
         }
         var _loc1_:TreasureHuntingFrame = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.TreasureHuntingFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,false,1,false);
      }
      
      private function loadComplete(param1:InventoryItemAnalyzer) : void
      {
         RouletteManager.instance.goodList = param1.list;
         var _loc2_:TreasureHuntingFrame = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.TreasureHuntingFrame");
         LayerManager.Instance.addToLayer(_loc2_,3,false,1,false);
      }
      
      public function loadTreasureHuntingModule(param1:Function = null, param2:Array = null) : void
      {
         _func = param1;
         _funcParams = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("treasureHunting");
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "treasureHunting")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "treasureHunting")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            if(null != _func)
            {
               _func.apply(null,_funcParams);
            }
            _func = null;
            _funcParams = null;
         }
      }
      
      private function _update(param1:BagEvent) : void
      {
         var _loc2_:Dictionary = param1.changedSlots;
         if(_treasureFrame && _treasureFrame.bagView)
         {
            _treasureFrame.bagView.updateData(_loc2_);
         }
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for(var _loc3_ in _loc2_)
         {
            _bagData[_loc3_] = _loc2_[_loc3_];
         }
      }
      
      private function onPayForHunting(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         lightIndexArr = [];
         msgStr = LanguageMgr.GetTranslation("treasureHunting.msg");
         var _loc5_:PackageIn = param1.pkg;
         TreasureManager.instance.isActivityOpen = _loc5_.readBoolean();
         var _loc7_:int = _loc5_.readInt();
         if(TreasureManager.instance.isActivityOpen == false || _loc7_ <= 0)
         {
            _treasureFrame.huntingBtn.enable = true;
            isMovieComplete = true;
            removeMask();
            return;
         }
         countMsg = LanguageMgr.GetTranslation("treasureHunting.count",_loc7_);
         _loc9_ = 0;
         while(_loc9_ <= _loc7_ - 1)
         {
            _loc6_ = _loc5_.readInt();
            _loc2_ = _loc5_.readInt();
            _loc4_ = _loc5_.readUTF();
            _loc3_ = _loc5_.readInt();
            msgStr = msgStr + (_loc4_ + "x" + _loc3_ + "  ");
            lightIndexArr.push(_loc2_ - 1);
            _loc9_++;
         }
         _treasureFrame.creatMoveCell(_loc6_);
         var _loc8_:int = _loc5_.readInt();
         if(_loc8_ > 0)
         {
            msgStr = msgStr + ("幸运彩石x" + _loc8_);
            _treasureFrame.creatMoveCell(11550);
            SocketManager.Instance.out.sendQequestBadLuck();
         }
         if(_loc7_ == 1)
         {
            _treasureFrame.startTimer();
         }
         else
         {
            _treasureFrame.lightUpItemArr();
         }
      }
      
      public function openShowPrize() : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createCaddyAwardsLoader],lookTrophy);
      }
      
      private function lookTrophy() : void
      {
         _showPrize = ComponentFactory.Instance.creatCustomObject("treasureHunting.LookTrophy");
         _showPrize.show(CaddyModel.instance.getCaddyTrophy(2000));
         _showPrize.addEventListener("dispose",onshowPrizeDispose);
      }
      
      public function openRankPrize() : void
      {
         _listView = ComponentFactory.Instance.creatComponentByStylename("caddyAwardListFrame");
         LayerManager.Instance.addToLayer(_listView,2,true,0);
      }
      
      private function onshowPrizeDispose(param1:ComponentEvent) : void
      {
         _showPrize.removeEventListener("dispose",onshowPrizeDispose);
         ObjectUtils.disposeObject(_showPrize);
         _showPrize = null;
      }
      
      public function addMask() : void
      {
         if(_mask == null)
         {
            _mask = new Sprite();
            _mask.graphics.beginFill(0,0);
            _mask.graphics.drawRect(0,0,2000,1200);
            _mask.graphics.endFill();
            _mask.addEventListener("click",onMaskClick);
         }
         LayerManager.Instance.addToLayer(_mask,3,false,2);
      }
      
      protected function __onRemoveMask(param1:TreasureEvent) : void
      {
         removeMask();
      }
      
      public function removeMask() : void
      {
         if(_mask != null)
         {
            _mask.parent.removeChild(_mask);
            _mask.removeEventListener("click",onMaskClick);
            _mask = null;
         }
      }
      
      private function onMaskClick(param1:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.huntingNow"));
      }
      
      public function checkBag() : Boolean
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _bagData;
         for(var _loc2_ in _bagData)
         {
            _loc1_ = PlayerManager.Instance.Self.CaddyBag.getItemAt(int(_loc2_));
            if(_loc1_ != null)
            {
               return true;
            }
         }
         return false;
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(110,2),onPayForHunting);
         PlayerManager.Instance.Self.CaddyBag.removeEventListener("update",_update);
      }
      
      public function dispose() : void
      {
         removeMask();
         if(_showPrize != null)
         {
            ObjectUtils.disposeObject(_showPrize);
         }
         _showPrize = null;
         if(_listView != null)
         {
            ObjectUtils.disposeObject(_listView);
         }
         _listView = null;
         if(_mask != null)
         {
            ObjectUtils.disposeObject(_mask);
         }
         _mask = null;
      }
      
      public function setFrame(param1:TreasureHuntingFrame) : void
      {
         _treasureFrame = param1;
      }
   }
}
