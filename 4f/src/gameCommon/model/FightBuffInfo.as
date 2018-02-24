package gameCommon.model
{
   import calendar.CalendarManager;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffType;
   import ddt.manager.LanguageMgr;
   import gameCommon.BuffManager;
   import gameCommon.GameControl;
   
   public class FightBuffInfo
   {
      
      public static const DEFUALT_EFFECT:String = "asset.game.AttackEffect2";
      
      public static const BUFF_ID_BEING_KILLED_ADD_BLOOD:int = 1435;
      
      public static const BUFF_ID_BEING_AWAKEN_KILLED_ADD_BLOOD:int = 1514;
       
      
      public var id:int;
      
      public var displayid:int = 0;
      
      public var type:int;
      
      private var _sigh:int = -1;
      
      public var buffPic:String = "";
      
      public var buffEffect:String = "";
      
      public var buffName:String = "FightBuffInfo";
      
      public var description:String = "unkown buff";
      
      public var priority:Number = 0.0;
      
      private var _data:int;
      
      private var _level:int;
      
      public var Count:int = 1;
      
      public var showType:int;
      
      public var isSelf:Boolean;
      
      public function FightBuffInfo(param1:int){super();}
      
      public function get data() : int{return 0;}
      
      public function set data(param1:int) : void{}
      
      public function execute(param1:Living) : void{}
      
      public function unExecute(param1:Living) : void{}
      
      public function clone() : FightBuffInfo{return null;}
   }
}
