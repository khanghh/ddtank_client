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
      
      public function setBossHp(param1:int, param2:Number) : void
      {
         _bossHp[param1] = param2;
      }
      
      public function setBossMaxHp(param1:int, param2:Number) : void
      {
         _bossMaxHp[param1] = param2;
      }
      
      public function setBossState(param1:int, param2:int) : void
      {
         _bossState[param1] = param2;
      }
      
      public function getBossHp(param1:int) : Number
      {
         return _bossHp[param1];
      }
      
      public function getBossMaxHp(param1:int) : Number
      {
         return _bossMaxHp[param1];
      }
      
      public function getBossState(param1:int) : int
      {
         return _bossState[param1];
      }
      
      public function get playerList() : DictionaryData
      {
         return _playerList;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set openTime(param1:Date) : void
      {
         _openTime = param1;
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
      
      public function set statueHp(param1:Number) : void
      {
         _statueHp = param1;
      }
      
      public function get statueMaxHp() : Number
      {
         return _statueMaxHp;
      }
      
      public function set statueMaxHp(param1:Number) : void
      {
         _statueMaxHp = param1;
      }
      
      public function get isFight() : Boolean
      {
         return _isFight;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         _isFight = param1;
      }
      
      public function get isWin() : Boolean
      {
         return _isWin;
      }
      
      public function set isWin(param1:Boolean) : void
      {
         _isWin = param1;
      }
      
      public function get endTime() : Number
      {
         return _endTime;
      }
      
      public function set endTime(param1:Number) : void
      {
         _endTime = param1;
      }
      
      public function get openLevel() : int
      {
         return _openLevel;
      }
      
      public function set openLevel(param1:int) : void
      {
         _openLevel = param1;
      }
      
      public function get buffLevel() : int
      {
         return _buffLevel;
      }
      
      public function set buffLevel(param1:int) : void
      {
         _buffLevel = param1;
      }
      
      public function get rankBossList() : DictionaryData
      {
         return _rankBossList;
      }
   }
}
