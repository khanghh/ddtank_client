package bagAndInfo.info
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperDataModuleLoad;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   
   public class PlayerInfoViewControl
   {
      
      private static var _view:PlayerInfoFrame;
      
      private static var _tempInfo:PlayerInfo;
      
      public static var isOpenFromBag:Boolean;
      
      public static var isOpenFromBattle:Boolean;
      
      public static var _isBattle:Boolean;
      
      public static var currentPlayer:PlayerInfo;
       
      
      public function PlayerInfoViewControl()
      {
         super();
      }
      
      public static function view(param1:*, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(PetsAdvancedManager.Instance.evolutionDataList == null)
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createPetsEvolutionDataLoader()],loadDataComplete,[param1,param2,param3,param4]);
         }
         else
         {
            loadDataComplete(param1,param2,param3,param4);
         }
      }
      
      private static function loadDataComplete(param1:*, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.creatTexpExpLoader()],loadModule,[param1,param2,param3,param4]);
      }
      
      private static function loadModule(param1:*, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : void
      {
         AssetModuleLoader.addModelLoader("ddtbagandinfo",6);
         AssetModuleLoader.addModelLoader("ddtbead",6);
         AssetModuleLoader.addModelLoader("gemstone",6);
         AssetModuleLoader.addModelLoader("ddtim",6);
         AssetModuleLoader.addModelLoader("ddtstore",6);
         AssetModuleLoader.startCodeLoader(loadComplete,[param1,param2,param3,param4]);
      }
      
      private static function loadComplete(param1:*, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : void
      {
         _isBattle = param3;
         if(param1 && _isBattle)
         {
            if(_view == null)
            {
               _view = ComponentFactory.Instance.creatComponentByStylename("bag.personelInfoViewFrame");
            }
            _view.info = param1;
            _view.show();
            _view.setAchivEnable(param2);
            _view.addEventListener("response",__responseHandler);
            return;
         }
         if(param1 && param1 is PlayerInfo)
         {
            if(param1.Style != null)
            {
               if(_view == null)
               {
                  _view = ComponentFactory.Instance.creatComponentByStylename("bag.personelInfoViewFrame");
               }
               _view.info = param1;
               _view.show();
               _view.setAchivEnable(param2);
               _view.addEventListener("response",__responseHandler);
            }
            else
            {
               param1.addEventListener("propertychange",__infoChange);
            }
            if(param4)
            {
               SocketManager.Instance.out.updateBKingItemEquip(param1.ID,param1.ZoneID,0);
               SocketManager.Instance.out.updateBKingItemEquip(param1.ID,param1.ZoneID,1);
               SocketManager.Instance.out.updateBKingItemEquip(param1.ID,param1.ZoneID,2);
            }
            else
            {
               SocketManager.Instance.out.getPlayerCardInfo(param1.ID);
               SocketManager.Instance.out.sendItemEquip(param1.ID);
               SocketManager.Instance.out.sendUpdatePetInfo(param1.ID);
            }
         }
      }
      
      private static function __infoChange(param1:PlayerPropertyEvent) : void
      {
         if(PlayerInfo(param1.currentTarget).Style)
         {
            PlayerInfo(param1.target).removeEventListener("propertychange",__infoChange);
            if(_view == null)
            {
               _view = ComponentFactory.Instance.creatComponentByStylename("bag.personelInfoViewFrame");
            }
            _view.info = PlayerInfo(param1.target);
            _view.show();
            _view.addEventListener("response",__responseHandler);
         }
      }
      
      public static function viewByID(param1:int, param2:int = -1, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc6_:PlayerInfo = PlayerManager.Instance.findPlayer(param1,param2);
         if(param2 != -1)
         {
            _loc6_.ZoneID = param2;
         }
         view(_loc6_,param3,param4,param5);
      }
      
      public static function viewByNickName(param1:String, param2:int = -1, param3:Boolean = true) : void
      {
         _tempInfo = new PlayerInfo();
         _tempInfo = PlayerManager.Instance.findPlayerByNickName(_tempInfo,param1);
         if(_tempInfo.ID)
         {
            view(_tempInfo,param3);
         }
         else
         {
            SocketManager.Instance.out.sendItemEquip(_tempInfo.NickName,true);
            _tempInfo.addEventListener("propertychange",__IDChange);
         }
      }
      
      private static function __IDChange(param1:PlayerPropertyEvent) : void
      {
         _tempInfo.removeEventListener("propertychange",__IDChange);
         view(_tempInfo);
      }
      
      private static function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _view.dispose();
               clearView();
         }
      }
      
      public static function closeView() : void
      {
         if(_view && _view.parent)
         {
            _view.removeEventListener("response",__responseHandler);
            _view.dispose();
         }
         _view = null;
      }
      
      public static function clearView() : void
      {
         if(_view)
         {
            _view.removeEventListener("response",__responseHandler);
         }
         _view = null;
      }
   }
}
