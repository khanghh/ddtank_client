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
      
      public function LevelFundManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function addLevelFundActivityBtn(hall:HallStateView) : void
      {
         _hallView = hall;
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
      
      private function __levelFundHandler(evt:PkgEvent) : void
      {
         var cmd:int = evt.pkg.readByte();
         if(cmd == 1)
         {
            getInfoHandler(evt.pkg);
         }
         else if(cmd == 2)
         {
            buyLevelFundHandler(evt.pkg);
         }
         else if(cmd == 3)
         {
            getAwardLevelFundHandler(evt.pkg);
         }
      }
      
      private function getInfoHandler(pkg:PackageIn) : void
      {
         var count:int = 0;
         var i:int = 0;
         var level:int = 0;
         var money:int = 0;
         var state:int = 0;
         var isOldOpen:Boolean = model.isOpen;
         model.isOpen = pkg.readBoolean();
         if(model.isOpen)
         {
            model.buyType = pkg.readInt();
            count = pkg.readInt();
            model.dataArr = [];
            for(i = 0; i < count; )
            {
               level = pkg.readInt();
               money = pkg.readInt();
               state = pkg.readInt();
               model.dataArr.push({
                  "level":level,
                  "money":money,
                  "state":state
               });
               i++;
            }
            dispatchEvent(new LevelFundEvent("update_view"));
            if(!isOldOpen)
            {
               initBtn();
            }
         }
         else
         {
            deleteBtn();
         }
      }
      
      private function buyLevelFundHandler(pkg:PackageIn) : void
      {
         var isBool:Boolean = pkg.readBoolean();
         if(isBool)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.buyLevelFund.successMsg"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.buyLevelFund.errorMsg"));
         }
      }
      
      private function getAwardLevelFundHandler(pkg:PackageIn) : void
      {
         var isBool:Boolean = pkg.readBoolean();
         if(isBool)
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
