package ddt.data.player
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   
   public class PlayerState
   {
      
      public static const OFFLINE:int = 0;
      
      public static const ONLINE:int = 1;
      
      public static const AWAY:int = 2;
      
      public static const BUSY:int = 3;
      
      public static const SHOPPING:int = 4;
      
      public static const NO_DISTRUB:int = 5;
      
      public static const CLEAN_OUT:int = 6;
      
      public static const AUTO:int = 0;
      
      public static const MANUAL:int = 1;
       
      
      private var _stateID:int;
      
      private var _autoReply:String;
      
      private var _priority:int;
      
      public function PlayerState(param1:int, param2:int = 0)
      {
         super();
         _stateID = param1;
         _priority = param2;
      }
      
      public function get StateID() : int
      {
         return _stateID;
      }
      
      public function get Priority() : int
      {
         return _priority;
      }
      
      public function get AutoReply() : String
      {
         switch(int(_stateID) - 2)
         {
            case 0:
               if(SharedManager.Instance.awayAutoReply[PlayerManager.Instance.Self.ID] != undefined)
               {
                  return SharedManager.Instance.awayAutoReply[PlayerManager.Instance.Self.ID];
               }
               return LanguageMgr.GetTranslation("im.playerState.awayReply");
            case 1:
               if(SharedManager.Instance.busyAutoReply[PlayerManager.Instance.Self.ID] != undefined)
               {
                  return SharedManager.Instance.busyAutoReply[PlayerManager.Instance.Self.ID];
               }
               return LanguageMgr.GetTranslation("im.playerState.busyReply");
            case 2:
               if(SharedManager.Instance.shoppingAutoReply[PlayerManager.Instance.Self.ID] != undefined)
               {
                  return SharedManager.Instance.shoppingAutoReply[PlayerManager.Instance.Self.ID];
               }
               return LanguageMgr.GetTranslation("im.playerState.shoppingReply");
            case 3:
               if(SharedManager.Instance.noDistrubAutoReply[PlayerManager.Instance.Self.ID] != undefined)
               {
                  return SharedManager.Instance.noDistrubAutoReply[PlayerManager.Instance.Self.ID];
               }
               return LanguageMgr.GetTranslation("im.playerState.noDisturbReply");
            case 4:
               if(SharedManager.Instance.shoppingAutoReply[PlayerManager.Instance.Self.ID] != undefined)
               {
                  return SharedManager.Instance.shoppingAutoReply[PlayerManager.Instance.Self.ID];
               }
               return LanguageMgr.GetTranslation("im.playerState.cleanOutReply");
         }
      }
      
      public function set AutoReply(param1:String) : void
      {
         switch(int(_stateID) - 2)
         {
            case 0:
               SharedManager.Instance.awayAutoReply[PlayerManager.Instance.Self.ID] = param1;
               break;
            case 1:
               SharedManager.Instance.busyAutoReply[PlayerManager.Instance.Self.ID] = param1;
               break;
            case 2:
               SharedManager.Instance.shoppingAutoReply[PlayerManager.Instance.Self.ID] = param1;
               break;
            case 3:
               SharedManager.Instance.noDistrubAutoReply[PlayerManager.Instance.Self.ID] = param1;
               break;
            case 4:
               SharedManager.Instance.shoppingAutoReply[PlayerManager.Instance.Self.ID] = param1;
         }
         SharedManager.Instance.save();
      }
      
      public function convertToString() : String
      {
         switch(int(_stateID))
         {
            case 0:
               return LanguageMgr.GetTranslation("im.playerState.offline");
            case 1:
               return LanguageMgr.GetTranslation("im.playerState.online");
            case 2:
               return LanguageMgr.GetTranslation("im.playerState.away");
            case 3:
               return LanguageMgr.GetTranslation("im.playerState.busy");
            case 4:
               return LanguageMgr.GetTranslation("im.playerState.shopping");
            case 5:
               return LanguageMgr.GetTranslation("im.playerState.noDisturb");
            case 6:
               return LanguageMgr.GetTranslation("im.playerState.cleanOut");
         }
      }
   }
}
