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
      
      public static function view(info:*, achivEnable:Boolean = true, bool:Boolean = false, isBombKing:Boolean = false) : void
      {
         if(PetsAdvancedManager.Instance.evolutionDataList == null)
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createPetsEvolutionDataLoader()],loadDataComplete,[info,achivEnable,bool,isBombKing]);
         }
         else
         {
            loadDataComplete(info,achivEnable,bool,isBombKing);
         }
      }
      
      private static function loadDataComplete(info:*, achivEnable:Boolean = true, bool:Boolean = false, isBombKing:Boolean = false) : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.creatTexpExpLoader()],loadModule,[info,achivEnable,bool,isBombKing]);
      }
      
      private static function loadModule(info:*, achivEnable:Boolean = true, bool:Boolean = false, isBombKing:Boolean = false) : void
      {
         AssetModuleLoader.addModelLoader("ddtbagandinfo",6);
         AssetModuleLoader.addModelLoader("ddtbead",6);
         AssetModuleLoader.addModelLoader("gemstone",6);
         AssetModuleLoader.addModelLoader("ddtim",6);
         AssetModuleLoader.addModelLoader("ddtstore",6);
         AssetModuleLoader.startCodeLoader(loadComplete,[info,achivEnable,bool,isBombKing]);
      }
      
      private static function loadComplete(info:*, achivEnable:Boolean = true, bool:Boolean = false, isBombKing:Boolean = false) : void
      {
         _isBattle = bool;
         if(info && _isBattle)
         {
            if(_view == null)
            {
               _view = ComponentFactory.Instance.creatComponentByStylename("bag.personelInfoViewFrame");
            }
            _view.info = info;
            _view.show();
            _view.setAchivEnable(achivEnable);
            _view.addEventListener("response",__responseHandler);
            return;
         }
         if(info && info is PlayerInfo)
         {
            if(info.Style != null)
            {
               if(_view == null)
               {
                  _view = ComponentFactory.Instance.creatComponentByStylename("bag.personelInfoViewFrame");
               }
               _view.info = info;
               _view.show();
               _view.setAchivEnable(achivEnable);
               _view.addEventListener("response",__responseHandler);
            }
            else
            {
               info.addEventListener("propertychange",__infoChange);
            }
            if(isBombKing)
            {
               SocketManager.Instance.out.updateBKingItemEquip(info.ID,info.ZoneID,0);
               SocketManager.Instance.out.updateBKingItemEquip(info.ID,info.ZoneID,1);
               SocketManager.Instance.out.updateBKingItemEquip(info.ID,info.ZoneID,2);
            }
            else
            {
               SocketManager.Instance.out.getPlayerCardInfo(info.ID);
               SocketManager.Instance.out.sendItemEquip(info.ID);
               SocketManager.Instance.out.sendUpdatePetInfo(info.ID);
            }
         }
      }
      
      private static function __infoChange(evt:PlayerPropertyEvent) : void
      {
         if(PlayerInfo(evt.currentTarget).Style)
         {
            PlayerInfo(evt.target).removeEventListener("propertychange",__infoChange);
            if(_view == null)
            {
               _view = ComponentFactory.Instance.creatComponentByStylename("bag.personelInfoViewFrame");
            }
            _view.info = PlayerInfo(evt.target);
            _view.show();
            _view.addEventListener("response",__responseHandler);
         }
      }
      
      public static function viewByID(id:int, zoneID:int = -1, achivEnable:Boolean = true, _isbattle:Boolean = false, isBombKing:Boolean = false) : void
      {
         var info:PlayerInfo = PlayerManager.Instance.findPlayer(id,zoneID);
         if(zoneID != -1)
         {
            info.ZoneID = zoneID;
         }
         view(info,achivEnable,_isbattle,isBombKing);
      }
      
      public static function viewByNickName(nickName:String, zoneID:int = -1, achivEnable:Boolean = true) : void
      {
         _tempInfo = new PlayerInfo();
         _tempInfo = PlayerManager.Instance.findPlayerByNickName(_tempInfo,nickName);
         if(_tempInfo.ID)
         {
            view(_tempInfo,achivEnable);
         }
         else
         {
            SocketManager.Instance.out.sendItemEquip(_tempInfo.NickName,true);
            _tempInfo.addEventListener("propertychange",__IDChange);
         }
      }
      
      private static function __IDChange(evt:PlayerPropertyEvent) : void
      {
         _tempInfo.removeEventListener("propertychange",__IDChange);
         view(_tempInfo);
      }
      
      private static function __responseHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
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
