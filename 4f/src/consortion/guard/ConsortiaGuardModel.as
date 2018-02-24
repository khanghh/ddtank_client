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
      
      public function ConsortiaGuardModel(){super();}
      
      public function reset() : void{}
      
      public function setBossHp(param1:int, param2:Number) : void{}
      
      public function setBossMaxHp(param1:int, param2:Number) : void{}
      
      public function setBossState(param1:int, param2:int) : void{}
      
      public function getBossHp(param1:int) : Number{return 0;}
      
      public function getBossMaxHp(param1:int) : Number{return 0;}
      
      public function getBossState(param1:int) : int{return 0;}
      
      public function get playerList() : DictionaryData{return null;}
      
      public function set isOpen(param1:Boolean) : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      public function set openTime(param1:Date) : void{}
      
      public function get openTime() : Date{return null;}
      
      public function get rankList() : DictionaryData{return null;}
      
      public function get statueHp() : Number{return 0;}
      
      public function set statueHp(param1:Number) : void{}
      
      public function get statueMaxHp() : Number{return 0;}
      
      public function set statueMaxHp(param1:Number) : void{}
      
      public function get isFight() : Boolean{return false;}
      
      public function set isFight(param1:Boolean) : void{}
      
      public function get isWin() : Boolean{return false;}
      
      public function set isWin(param1:Boolean) : void{}
      
      public function get endTime() : Number{return 0;}
      
      public function set endTime(param1:Number) : void{}
      
      public function get openLevel() : int{return 0;}
      
      public function set openLevel(param1:int) : void{}
      
      public function get buffLevel() : int{return 0;}
      
      public function set buffLevel(param1:int) : void{}
      
      public function get rankBossList() : DictionaryData{return null;}
   }
}
