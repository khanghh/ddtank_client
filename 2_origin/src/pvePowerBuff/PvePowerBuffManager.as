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
      
      public function PvePowerBuffManager(param1:PvePowerBuffInstance)
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
      
      private function __pvePowerBuffHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc7_:PackageIn = param1.pkg;
         var _loc8_:int = _loc7_.readInt();
         switch(int(_loc8_) - 1)
         {
            case 0:
               playerInfoVc = new Vector.<PlayerInfo>();
               refreshCount = _loc7_.readInt();
               refreshDate = _loc7_.readDate();
               getBuffCount = _loc7_.readInt();
               getBuffDate = _loc7_.readDate();
               getBuffIndex = _loc7_.readInt();
               _loc4_ = _loc7_.readInt();
               _loc11_ = 0;
               while(_loc11_ < _loc4_)
               {
                  _loc3_ = new PlayerInfo();
                  _loc3_.ID = _loc7_.readInt();
                  _loc3_.Attack = _loc7_.readInt();
                  _loc3_.Defence = _loc7_.readInt();
                  _loc3_.Agility = _loc7_.readInt();
                  _loc3_.Luck = _loc7_.readInt();
                  _loc3_.Damage = _loc7_.readInt();
                  _loc3_.Guard = _loc7_.readInt();
                  _loc3_.hp = _loc7_.readInt();
                  _loc3_.MagicAttack = _loc7_.readInt();
                  _loc3_.MagicDefence = _loc7_.readInt();
                  _loc3_.Grade = _loc7_.readInt();
                  _loc3_.FightPower = _loc7_.readInt();
                  _loc3_.NickName = _loc7_.readUTF();
                  _loc3_.Sex = _loc7_.readInt();
                  _loc3_.Style = _loc7_.readUTF();
                  _loc3_.Colors = _loc7_.readUTF();
                  _loc3_.Skin = _loc7_.readUTF();
                  _loc3_.Hide = _loc7_.readInt();
                  playerInfoVc.push(_loc3_);
                  _loc11_++;
               }
               getBuffAtk = _loc7_.readInt();
               getBuffDef = _loc7_.readInt();
               getBuffAgl = _loc7_.readInt();
               getBuffLuck = _loc7_.readInt();
               getBuffDmg = _loc7_.readInt();
               getBuffAr = _loc7_.readInt();
               getBuffHp = _loc7_.readInt();
               getBuffMAtk = _loc7_.readInt();
               getBuffMDef = _loc7_.readInt();
               break;
            case 1:
               isInRefresh = true;
               playerInfoVc = new Vector.<PlayerInfo>();
               refreshCount = _loc7_.readInt();
               refreshDate = _loc7_.readDate();
               getBuffIndex = _loc7_.readInt();
               _loc6_ = _loc7_.readInt();
               _loc10_ = 0;
               while(_loc10_ < _loc6_)
               {
                  _loc9_ = new PlayerInfo();
                  _loc9_.ID = _loc7_.readInt();
                  _loc9_.Attack = _loc7_.readInt();
                  _loc9_.Defence = _loc7_.readInt();
                  _loc9_.Agility = _loc7_.readInt();
                  _loc9_.Luck = _loc7_.readInt();
                  _loc9_.Damage = _loc7_.readInt();
                  _loc9_.Guard = _loc7_.readInt();
                  _loc9_.hp = _loc7_.readInt();
                  _loc9_.MagicAttack = _loc7_.readInt();
                  _loc9_.MagicDefence = _loc7_.readInt();
                  _loc9_.Grade = _loc7_.readInt();
                  _loc9_.FightPower = _loc7_.readInt();
                  _loc9_.NickName = _loc7_.readUTF();
                  _loc9_.Sex = _loc7_.readInt();
                  _loc9_.Style = _loc7_.readUTF();
                  _loc9_.Colors = _loc7_.readUTF();
                  _loc9_.Skin = _loc7_.readUTF();
                  _loc9_.Hide = _loc7_.readInt();
                  playerInfoVc.push(_loc9_);
                  _loc10_++;
               }
               _loc2_ = new PvePowerBuffEvent("pvepowerbuff_refresh");
               dispatchEvent(_loc2_);
               break;
            case 2:
               getBuffCount = _loc7_.readInt();
               getBuffDate = _loc7_.readDate();
               getBuffIndex = _loc7_.readInt();
               getBuffAtk = _loc7_.readInt();
               getBuffDef = _loc7_.readInt();
               getBuffAgl = _loc7_.readInt();
               getBuffLuck = _loc7_.readInt();
               getBuffDmg = _loc7_.readInt();
               getBuffAr = _loc7_.readInt();
               getBuffHp = _loc7_.readInt();
               getBuffMAtk = _loc7_.readInt();
               getBuffMDef = _loc7_.readInt();
               _loc5_ = new PvePowerBuffEvent("pvepowerbuff_getbuff");
               dispatchEvent(_loc5_);
         }
      }
      
      override protected function start() : void
      {
         dispatchEvent(new PvePowerBuffEvent("pvePowerBuffOpenView"));
      }
      
      public function disposeView() : void
      {
         var _loc1_:PvePowerBuffEvent = new PvePowerBuffEvent("pvePowerBuffDispose");
         dispatchEvent(_loc1_);
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
