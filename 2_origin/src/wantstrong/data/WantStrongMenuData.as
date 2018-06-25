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
      
      public function set iconUrl(value:String) : void
      {
         _iconUrl = value;
      }
      
      public function get moneyNum() : int
      {
         return _moneyNum;
      }
      
      public function set moneyNum(value:int) : void
      {
         _moneyNum = value;
      }
      
      public function get awardType() : int
      {
         return _awardType;
      }
      
      public function set awardType(value:int) : void
      {
         _awardType = value;
      }
      
      public function get awardNum() : int
      {
         return _awardNum;
      }
      
      public function set awardNum(value:int) : void
      {
         _awardNum = value;
      }
      
      public function get allBackBtnEnable() : Boolean
      {
         return _allBackBtnEnable;
      }
      
      public function set allBackBtnEnable(value:Boolean) : void
      {
         _allBackBtnEnable = value;
      }
      
      public function get freeBackBtnEnable() : Boolean
      {
         return _freeBackBtnEnable;
      }
      
      public function set freeBackBtnEnable(value:Boolean) : void
      {
         _freeBackBtnEnable = value;
      }
      
      public function get bossType() : int
      {
         return _bossType;
      }
      
      public function set bossType(value:int) : void
      {
         _bossType = value;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get needLevel() : int
      {
         return _needLevel;
      }
      
      public function set needLevel(value:int) : void
      {
         _needLevel = value;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function set description(value:String) : void
      {
         _description = value;
      }
      
      public function get starNum() : int
      {
         return _starNum;
      }
      
      public function set starNum(value:int) : void
      {
         _starNum = value;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(value:String) : void
      {
         _title = value;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(value:int) : void
      {
         _id = value;
      }
   }
}
