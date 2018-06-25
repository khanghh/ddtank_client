package consortion.guard
{
   import road7th.data.DictionaryData;
   
   public class ConsortiaGuardModel
   {
       
      
      private var _playerList:DictionaryData;
      
      private var _isOpen:Boolean;
      
      private var _openTime:Date;
      
      private var _bossHp:Array;
      
      private var _bossMaxHp:Array;
      
      private var _bossState:Array;
      
      private var _statueHp:Number = 0;
      
      private var _statueMaxHp:Number = 0;
      
      private var _isFight:Boolean = true;
      
      private var _isWin:Boolean;
      
      private var _endTime:Number;
      
      private var _openLevel:int;
      
      private var _buffLevel:int;
      
      private var _rankList:DictionaryData;
      
      private var _rankBossList:DictionaryData;
      
      public function ConsortiaGuardModel()
      {
         super();
         reset();
      }
      
      public function reset() : void
      {
         if(_playerList)
         {
            _playerList.clear();
         }
         _playerList = new DictionaryData();
         _bossHp = [100,100,100,100];
         _bossMaxHp = [100,100,100,100];
         _bossState = [];
         if(_rankList)
         {
            _rankList.clear();
         }
         _rankList = new DictionaryData();
         if(_rankBossList)
         {
            _rankBossList.clear();
         }
         _rankBossList = new DictionaryData();
      }
      
      public function setBossHp(index:int, hp:Number) : void
      {
         _bossHp[index] = hp;
      }
      
      public function setBossMaxHp(index:int, hp:Number) : void
      {
         _bossMaxHp[index] = hp;
      }
      
      public function setBossState(index:int, state:int) : void
      {
         _bossState[index] = state;
      }
      
      public function getBossHp(index:int) : Number
      {
         return _bossHp[index];
      }
      
      public function getBossMaxHp(index:int) : Number
      {
         return _bossMaxHp[index];
      }
      
      public function getBossState(index:int) : int
      {
         return _bossState[index];
      }
      
      public function get playerList() : DictionaryData
      {
         return _playerList;
      }
      
      public function set isOpen(value:Boolean) : void
      {
         _isOpen = value;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set openTime(value:Date) : void
      {
         _openTime = value;
      }
      
      public function get openTime() : Date
      {
         return _openTime;
      }
      
      public function get rankList() : DictionaryData
      {
         return _rankList;
      }
      
      public function get statueHp() : Number
      {
         return _statueHp;
      }
      
      public function set statueHp(value:Number) : void
      {
         _statueHp = value;
      }
      
      public function get statueMaxHp() : Number
      {
         return _statueMaxHp;
      }
      
      public function set statueMaxHp(value:Number) : void
      {
         _statueMaxHp = value;
      }
      
      public function get isFight() : Boolean
      {
         return _isFight;
      }
      
      public function set isFight(value:Boolean) : void
      {
         _isFight = value;
      }
      
      public function get isWin() : Boolean
      {
         return _isWin;
      }
      
      public function set isWin(value:Boolean) : void
      {
         _isWin = value;
      }
      
      public function get endTime() : Number
      {
         return _endTime;
      }
      
      public function set endTime(value:Number) : void
      {
         _endTime = value;
      }
      
      public function get openLevel() : int
      {
         return _openLevel;
      }
      
      public function set openLevel(value:int) : void
      {
         _openLevel = value;
      }
      
      public function get buffLevel() : int
      {
         return _buffLevel;
      }
      
      public function set buffLevel(value:int) : void
      {
         _buffLevel = value;
      }
      
      public function get rankBossList() : DictionaryData
      {
         return _rankBossList;
      }
   }
}
