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
      
      protected function __onOpenView(event:Event) : void
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
         var treasureFrame:TreasureHuntingFrame = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.TreasureHuntingFrame");
         LayerManager.Instance.addToLayer(treasureFrame,3,false,1,false);
      }
      
      private function loadComplete(analyze:InventoryItemAnalyzer) : void
      {
         RouletteManager.instance.goodList = analyze.list;
         var treasureFrame:TreasureHuntingFrame = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.TreasureHuntingFrame");
         LayerManager.Instance.addToLayer(treasureFrame,3,false,1,false);
      }
      
      public function loadTreasureHuntingModule(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("treasureHunting");
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "treasureHunting")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "treasureHunting")
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
      
      private function _update(event:BagEvent) : void
      {
         var tmpData:Dictionary = event.changedSlots;
         if(_treasureFrame && _treasureFrame.bagView)
         {
            _treasureFrame.bagView.updateData(tmpData);
         }
         var _loc5_:int = 0;
         var _loc4_:* = tmpData;
         for(var key in tmpData)
         {
            _bagData[key] = tmpData[key];
         }
      }
      
      private function onPayForHunting(event:PkgEvent) : void
      {
         var templeteId:int = 0;
         var categoryIndex:int = 0;
         var str:* = null;
         var count:int = 0;
         var i:int = 0;
         lightIndexArr = [];
         msgStr = LanguageMgr.GetTranslation("treasureHunting.msg");
         var pkg:PackageIn = event.pkg;
         TreasureManager.instance.isActivityOpen = pkg.readBoolean();
         var len:int = pkg.readInt();
         if(TreasureManager.instance.isActivityOpen == false || len <= 0)
         {
            _treasureFrame.huntingBtn.enable = true;
            isMovieComplete = true;
            removeMask();
            return;
         }
         countMsg = LanguageMgr.GetTranslation("treasureHunting.count",len);
         for(i = 0; i <= len - 1; )
         {
            templeteId = pkg.readInt();
            categoryIndex = pkg.readInt();
            str = pkg.readUTF();
            count = pkg.readInt();
            msgStr = msgStr + (str + "x" + count + "  ");
            lightIndexArr.push(categoryIndex - 1);
            i++;
         }
         _treasureFrame.creatMoveCell(templeteId);
         var lukStoneCount:int = pkg.readInt();
         if(lukStoneCount > 0)
         {
            msgStr = msgStr + ("幸运彩石x" + lukStoneCount);
            _treasureFrame.creatMoveCell(11550);
            SocketManager.Instance.out.sendQequestBadLuck();
         }
         if(len == 1)
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
      
      private function onshowPrizeDispose(event:ComponentEvent) : void
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
      
      protected function __onRemoveMask(event:TreasureEvent) : void
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
      
      private function onMaskClick(event:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.huntingNow"));
      }
      
      public function checkBag() : Boolean
      {
         var cellInfo:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _bagData;
         for(var i in _bagData)
         {
            cellInfo = PlayerManager.Instance.Self.CaddyBag.getItemAt(int(i));
            if(cellInfo != null)
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
      
      public function setFrame(frame:TreasureHuntingFrame) : void
      {
         _treasureFrame = frame;
      }
   }
}
