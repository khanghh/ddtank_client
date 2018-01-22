package levelFund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.view.LevelFundIcon;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hall.HallStateView;
   import levelFund.event.LevelFundEvent;
   import levelFund.model.LevelFundModel;
   import road7th.comm.PackageIn;
   
   public class LevelFundManager extends EventDispatcher
   {
      
      private static var _instance:LevelFundManager;
       
      
      private var _model:LevelFundModel;
      
      private var _frame:Frame;
      
      private var _levelFundActivityIcon:LevelFundIcon;
      
      private var _hallView:HallStateView;
      
      public function LevelFundManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : LevelFundManager
      {
         if(_instance == null)
         {
            _instance = new LevelFundManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new LevelFundModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(290),__levelFundHandler);
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("levelFund",6);
         AssetModuleLoader.startCodeLoader(loadCompleteHandler);
      }
      
      private function loadCompleteHandler() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("levelFund.LevelFundFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      public function addLevelFundActivityBtn(param1:HallStateView) : void
      {
         _hallView = param1;
         if(_model.isOpen)
         {
            initBtn();
         }
      }
      
      private function initBtn() : void
      {
         if(_hallView)
         {
            deleteBtn();
            _levelFundActivityIcon = new LevelFundIcon();
         }
      }
      
      public function deleteBtn() : void
      {
         if(_levelFundActivityIcon)
         {
            ObjectUtils.disposeObject(_levelFundActivityIcon);
            _levelFundActivityIcon = null;
         }
      }
      
      private function __levelFundHandler(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readByte();
         if(_loc2_ == 1)
         {
            getInfoHandler(param1.pkg);
         }
         else if(_loc2_ == 2)
         {
            buyLevelFundHandler(param1.pkg);
         }
         else if(_loc2_ == 3)
         {
            getAwardLevelFundHandler(param1.pkg);
         }
      }
      
      private function getInfoHandler(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Boolean = model.isOpen;
         model.isOpen = param1.readBoolean();
         if(model.isOpen)
         {
            model.buyType = param1.readInt();
            _loc3_ = param1.readInt();
            model.dataArr = [];
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc2_ = param1.readInt();
               _loc5_ = param1.readInt();
               _loc4_ = param1.readInt();
               model.dataArr.push({
                  "level":_loc2_,
                  "money":_loc5_,
                  "state":_loc4_
               });
               _loc7_++;
            }
            dispatchEvent(new LevelFundEvent("update_view"));
            if(!_loc6_)
            {
               initBtn();
            }
         }
         else
         {
            deleteBtn();
         }
      }
      
      private function buyLevelFundHandler(param1:PackageIn) : void
      {
         var _loc2_:Boolean = param1.readBoolean();
         if(_loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.buyLevelFund.successMsg"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.buyLevelFund.errorMsg"));
         }
      }
      
      private function getAwardLevelFundHandler(param1:PackageIn) : void
      {
         var _loc2_:Boolean = param1.readBoolean();
         if(_loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.getAwardLevelFund.successMsg"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.getAwardLevelFund.errorMsg"));
         }
      }
      
      public function get levelFundActivityIcon() : LevelFundIcon
      {
         return this._levelFundActivityIcon;
      }
      
      public function get model() : LevelFundModel
      {
         return this._model;
      }
   }
}
