package wantstrong.data
{
   public class WantStrongMenuData
   {
       
      
      private var _id:int;
      
      private var _type:int;
      
      private var _freeBackBtnEnable:Boolean = true;
      
      private var _allBackBtnEnable:Boolean = true;
      
      private var _bossType:int;
      
      private var _title:String;
      
      private var _starNum:int;
      
      private var _description:String;
      
      private var _needLevel:int;
      
      private var _iconUrl:String;
      
      private var _awardType:int;
      
      private var _awardNum:int;
      
      private var _moneyNum:int;
      
      public function WantStrongMenuData()
      {
         super();
      }
      
      public function get iconUrl() : String
      {
         return _iconUrl;
      }
      
      public function set iconUrl(param1:String) : void
      {
         _iconUrl = param1;
      }
      
      public function get moneyNum() : int
      {
         return _moneyNum;
      }
      
      public function set moneyNum(param1:int) : void
      {
         _moneyNum = param1;
      }
      
      public function get awardType() : int
      {
         return _awardType;
      }
      
      public function set awardType(param1:int) : void
      {
         _awardType = param1;
      }
      
      public function get awardNum() : int
      {
         return _awardNum;
      }
      
      public function set awardNum(param1:int) : void
      {
         _awardNum = param1;
      }
      
      public function get allBackBtnEnable() : Boolean
      {
         return _allBackBtnEnable;
      }
      
      public function set allBackBtnEnable(param1:Boolean) : void
      {
         _allBackBtnEnable = param1;
      }
      
      public function get freeBackBtnEnable() : Boolean
      {
         return _freeBackBtnEnable;
      }
      
      public function set freeBackBtnEnable(param1:Boolean) : void
      {
         _freeBackBtnEnable = param1;
      }
      
      public function get bossType() : int
      {
         return _bossType;
      }
      
      public function set bossType(param1:int) : void
      {
         _bossType = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get needLevel() : int
      {
         return _needLevel;
      }
      
      public function set needLevel(param1:int) : void
      {
         _needLevel = param1;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function get starNum() : int
      {
         return _starNum;
      }
      
      public function set starNum(param1:int) : void
      {
         _starNum = param1;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
   }
}
