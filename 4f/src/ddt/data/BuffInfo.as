package ddt.data
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.TimeManager;
   
   public class BuffInfo
   {
      
      public static const FREE:int = 15;
      
      public static const DOUBEL_EXP:int = 13;
      
      public static const DOUBLE_GESTE:int = 12;
      
      public static const PREVENT_KICK:int = 11;
      
      public static const LABYRINTH_STONE:int = 10;
      
      public static const GROW_HELP:int = 14;
      
      public static const LABYRINTH_BUFF:int = 17;
      
      public static const RANDOM_SUIT:int = 18;
      
      public static const DOUBLE_PRESTIGE:int = 26;
      
      public static const GOURD_EXP:int = 27;
      
      public static const Caddy_Good:int = 70;
      
      public static const Save_Life:int = 51;
      
      public static const Agility:int = 50;
      
      public static const ReHealth:int = 52;
      
      public static const Train_Good:int = 71;
      
      public static const Level_Try:int = 72;
      
      public static const Card_Get:int = 73;
      
      public static const Pay_Buff:int = 16;
      
      public static const PropertyWater_74:int = 74;
      
      public static const DOUBLE_CONTRIBUTE:int = 110;
       
      
      public var Type:int;
      
      public var IsExist:Boolean;
      
      public var BeginData:Date;
      
      public var _ValidDate:int;
      
      public var Value:int;
      
      public var TemplateID:int;
      
      private var _ValidCount:int;
      
      public var isSelf:Boolean = true;
      
      private var _buffName:String;
      
      private var _buffItem:ItemTemplateInfo;
      
      private var _description:String;
      
      public var additionCount:int = 0;
      
      public var day:int;
      
      private var _valided:Boolean = true;
      
      public function BuffInfo(param1:int = -1, param2:Boolean = false, param3:Date = null, param4:int = 0, param5:int = 0, param6:int = 0, param7:int = 0){super();}
      
      public function get ValidCount() : int{return 0;}
      
      public function set ValidDate(param1:int) : void{}
      
      public function get ValidDate() : int{return 0;}
      
      public function get maxCount() : int{return 0;}
      
      public function getLeftTimeByUnit(param1:Number) : int{return 0;}
      
      public function get valided() : Boolean{return false;}
      
      public function calculatePayBuffValidDay() : void{}
      
      private function getLeftTime() : Number{return 0;}
      
      public function get buffName() : String{return null;}
      
      public function get description() : String{return null;}
      
      public function set description(param1:String) : void{}
      
      public function get buffItemInfo() : ItemTemplateInfo{return null;}
      
      public function initItemInfo() : void{}
      
      public function dispose() : void{}
   }
}
