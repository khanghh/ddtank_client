package worldcup
{
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   
   public class WorldcupManager extends EventDispatcher
   {
      
      private static var _instance:WorldcupManager;
      
      public static var OPEN_VIEW:String = "openWorldcupView";
      
      public static var CLEAR_GUESS:String = "clearGuess";
      
      public static var GUESS:String = "guess";
      
      public static var GET_PRIZE_OK:String = "getPrizeOk";
       
      
      private var _model:WorldcupModel;
      
      public function WorldcupManager(single:inner)
      {
         super();
      }
      
      public static function get instance() : WorldcupManager
      {
         if(!_instance)
         {
            _instance = new WorldcupManager(new inner());
         }
         return _instance;
      }
      
      public function get model() : WorldcupModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new WorldcupModel();
         SocketManager.Instance.addEventListener("worldcup_guess",worldcupHandler);
      }
      
      private function worldcupHandler(e:CrazyTankSocketEvent) : void
      {
         var len:int = 0;
         var i:int = 0;
         var country:int = 0;
         var team:int = 0;
         var sue:Boolean = false;
         var bol:Boolean = false;
         var ok:Boolean = false;
         var type:int = e.pkg.readInt();
         switch(int(type) - 1)
         {
            case 0:
               model.state = e.pkg.readInt();
               checkIcon();
               break;
            case 1:
               model.supportCountry = e.pkg.readInt();
               model.totalRecharge = e.pkg.readInt();
               model.awardIndex = e.pkg.readInt();
               model.returnRate = e.pkg.readInt();
               model.promotionCountry = [];
               len = e.pkg.readInt();
               for(i = 0; i < len; )
               {
                  country = e.pkg.readInt();
                  model.promotionCountry.push(country);
                  i++;
               }
               show();
               break;
            case 2:
               team = e.pkg.readInt();
               sue = e.pkg.readBoolean();
               if(sue)
               {
                  model.supportCountry = team;
               }
               else
               {
                  model.supportCountry = 0;
               }
               dispatchEvent(new CEvent(GUESS));
               break;
            case 3:
               ok = e.pkg.readBoolean();
               model.awardIndex = e.pkg.readInt();
               dispatchEvent(new CEvent(GET_PRIZE_OK));
               break;
            case 4:
               bol = e.pkg.readBoolean();
               if(bol)
               {
                  model.supportCountry = 0;
                  model.selectCountry = 0;
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.worldcupGuess.clearSuccess"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.worldcupGuess.clearFail"));
               }
               dispatchEvent(new CEvent(CLEAR_GUESS));
         }
      }
      
      private function checkIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 11)
         {
            HallIconManager.instance.updateSwitchHandler("worldcupGuess",_model.isOpen);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("worldcupGuess",_model.isOpen,11);
         }
      }
      
      private function show() : void
      {
         AssetModuleLoader.addModelLoader("worldcup",7);
         AssetModuleLoader.startCodeLoader(openView);
      }
      
      private function openView() : void
      {
         dispatchEvent(new CEvent(OPEN_VIEW));
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
