package pvePowerBuff
{
   import ddt.CoreManager;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import road7th.comm.PackageIn;
   
   public class PvePowerBuffManager extends CoreManager
   {
      
      public static const PVEPOWERBUFF_REFRESH:String = "pvepowerbuff_refresh";
      
      public static const PVEPOWERBUFF_GETBUFF:String = "pvepowerbuff_getbuff";
      
      private static var _instance:PvePowerBuffManager;
       
      
      public var playerInfoVc:Vector.<PlayerInfo>;
      
      public var refreshCount:int;
      
      public var refreshDate:Date;
      
      public var getBuffCount:int;
      
      public var getBuffDate:Date;
      
      public var getBuffIndex:int;
      
      public var getBuffAtk:int;
      
      public var getBuffDef:int;
      
      public var getBuffAgl:int;
      
      public var getBuffLuck:int;
      
      public var getBuffHp:int;
      
      public var getBuffMAtk:int;
      
      public var getBuffMDef:int;
      
      public var getBuffDmg:int;
      
      public var getBuffAr:int;
      
      public var isInRefresh:Boolean = false;
      
      public var isInGetBuff:Boolean = false;
      
      public function PvePowerBuffManager(ppbi:PvePowerBuffInstance)
      {
         super();
      }
      
      public static function get instance() : PvePowerBuffManager
      {
         if(_instance == null)
         {
            _instance = new PvePowerBuffManager(new PvePowerBuffInstance());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("pvePowerBuff",__pvePowerBuffHandler);
      }
      
      private function __pvePowerBuffHandler(event:CrazyTankSocketEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var player:* = null;
         var fcount:int = 0;
         var j:int = 0;
         var fplayer:* = null;
         var refreshEv:* = null;
         var getBUffEv:* = null;
         var pkg:PackageIn = event.pkg;
         var msgType:int = pkg.readInt();
         switch(int(msgType) - 1)
         {
            case 0:
               playerInfoVc = new Vector.<PlayerInfo>();
               refreshCount = pkg.readInt();
               refreshDate = pkg.readDate();
               getBuffCount = pkg.readInt();
               getBuffDate = pkg.readDate();
               getBuffIndex = pkg.readInt();
               count = pkg.readInt();
               for(i = 0; i < count; )
               {
                  player = new PlayerInfo();
                  player.ID = pkg.readInt();
                  player.Attack = pkg.readInt();
                  player.Defence = pkg.readInt();
                  player.Agility = pkg.readInt();
                  player.Luck = pkg.readInt();
                  player.Damage = pkg.readInt();
                  player.Guard = pkg.readInt();
                  player.hp = pkg.readInt();
                  player.MagicAttack = pkg.readInt();
                  player.MagicDefence = pkg.readInt();
                  player.Grade = pkg.readInt();
                  player.FightPower = pkg.readInt();
                  player.NickName = pkg.readUTF();
                  player.Sex = pkg.readInt();
                  player.Style = pkg.readUTF();
                  player.Colors = pkg.readUTF();
                  player.Skin = pkg.readUTF();
                  player.Hide = pkg.readInt();
                  playerInfoVc.push(player);
                  i++;
               }
               getBuffAtk = pkg.readInt();
               getBuffDef = pkg.readInt();
               getBuffAgl = pkg.readInt();
               getBuffLuck = pkg.readInt();
               getBuffDmg = pkg.readInt();
               getBuffAr = pkg.readInt();
               getBuffHp = pkg.readInt();
               getBuffMAtk = pkg.readInt();
               getBuffMDef = pkg.readInt();
               break;
            case 1:
               isInRefresh = true;
               playerInfoVc = new Vector.<PlayerInfo>();
               refreshCount = pkg.readInt();
               refreshDate = pkg.readDate();
               getBuffIndex = pkg.readInt();
               fcount = pkg.readInt();
               for(j = 0; j < fcount; )
               {
                  fplayer = new PlayerInfo();
                  fplayer.ID = pkg.readInt();
                  fplayer.Attack = pkg.readInt();
                  fplayer.Defence = pkg.readInt();
                  fplayer.Agility = pkg.readInt();
                  fplayer.Luck = pkg.readInt();
                  fplayer.Damage = pkg.readInt();
                  fplayer.Guard = pkg.readInt();
                  fplayer.hp = pkg.readInt();
                  fplayer.MagicAttack = pkg.readInt();
                  fplayer.MagicDefence = pkg.readInt();
                  fplayer.Grade = pkg.readInt();
                  fplayer.FightPower = pkg.readInt();
                  fplayer.NickName = pkg.readUTF();
                  fplayer.Sex = pkg.readInt();
                  fplayer.Style = pkg.readUTF();
                  fplayer.Colors = pkg.readUTF();
                  fplayer.Skin = pkg.readUTF();
                  fplayer.Hide = pkg.readInt();
                  playerInfoVc.push(fplayer);
                  j++;
               }
               refreshEv = new PvePowerBuffEvent("pvepowerbuff_refresh");
               dispatchEvent(refreshEv);
               break;
            case 2:
               getBuffCount = pkg.readInt();
               getBuffDate = pkg.readDate();
               getBuffIndex = pkg.readInt();
               getBuffAtk = pkg.readInt();
               getBuffDef = pkg.readInt();
               getBuffAgl = pkg.readInt();
               getBuffLuck = pkg.readInt();
               getBuffDmg = pkg.readInt();
               getBuffAr = pkg.readInt();
               getBuffHp = pkg.readInt();
               getBuffMAtk = pkg.readInt();
               getBuffMDef = pkg.readInt();
               getBUffEv = new PvePowerBuffEvent("pvepowerbuff_getbuff");
               dispatchEvent(getBUffEv);
         }
      }
      
      override protected function start() : void
      {
         dispatchEvent(new PvePowerBuffEvent("pvePowerBuffOpenView"));
      }
      
      public function disposeView() : void
      {
         var event:PvePowerBuffEvent = new PvePowerBuffEvent("pvePowerBuffDispose");
         dispatchEvent(event);
      }
   }
}

class PvePowerBuffInstance
{
    
   
   function PvePowerBuffInstance()
   {
      super();
   }
}
