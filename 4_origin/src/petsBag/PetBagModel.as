package petsBag
{
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import ddt.utils.ConfirmAlertData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import pet.data.PetInfo;
   import petsBag.data.BreakInfo;
   import petsBag.data.PetAtlasInfo;
   import petsBag.data.PetFarmGuildeInfo;
   import petsBag.event.PetItemEvent;
   import road7th.data.DictionaryData;
   
   public class PetBagModel extends EventDispatcher
   {
       
      
      private var _currentPetBreakInfo:BreakInfo;
      
      private var _currentPetInfo:PetInfo;
      
      private var _currentPlayerInfo:PlayerInfo;
      
      private var _adoptPets:DictionaryData;
      
      private var _adoptItems:DictionaryData;
      
      private var _petsAtlas:DictionaryData;
      
      private var _eatPetsInfo:DictionaryData;
      
      public var eatPetsLevelUp:Boolean;
      
      private var _petsListSelected:Array;
      
      private var _benchBagList:Array;
      
      private var _openCellConfirmData:ConfirmAlertData;
      
      private var _unlockedCellNum:int;
      
      private var _priceList:Vector.<int>;
      
      public var isLoadPetTrainer:Boolean;
      
      public var CurrentPetFarmGuildeArrow:Object;
      
      public var IsFinishTask5:Boolean = false;
      
      private var _petGuildeOptionOnOff:DictionaryData;
      
      private var _petGuilde:DictionaryData;
      
      public var nextShowArrowID:int = 0;
      
      public var preShowArrowID:int = 0;
      
      public function PetBagModel()
      {
         _benchBagList = [];
         super();
         _openCellConfirmData = new ConfirmAlertData();
      }
      
      public function get adoptPets() : DictionaryData
      {
         if(_adoptPets == null)
         {
            _adoptPets = new DictionaryData();
         }
         return _adoptPets;
      }
      
      public function get adoptItems() : DictionaryData
      {
         if(_adoptItems == null)
         {
            _adoptItems = new DictionaryData();
         }
         return _adoptItems;
      }
      
      public function get petsAtlas() : DictionaryData
      {
         return _petsAtlas;
      }
      
      public function set petsAtlas(param1:DictionaryData) : void
      {
         _petsAtlas = param1;
      }
      
      public function get eatPetsInfo() : DictionaryData
      {
         if(_eatPetsInfo == null)
         {
            _eatPetsInfo = new DictionaryData();
         }
         return _eatPetsInfo;
      }
      
      public function set eatPetsInfo(param1:DictionaryData) : void
      {
         _eatPetsInfo = param1;
         dispatchEvent(new PetItemEvent("eat_pets_complete"));
      }
      
      public function getPetAtlasSorted(param1:int, param2:int = 15) : Vector.<PetAtlasInfo>
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Vector.<PetAtlasInfo> = new Vector.<PetAtlasInfo>(param2);
         var _loc6_:int = Math.ceil(_petsAtlas.length / param2);
         if(param1 > 0 && param1 <= _loc6_)
         {
            _loc4_ = 0 + param2 * (param1 - 1);
            _loc5_ = Math.min(_petsAtlas.length - _loc4_,param2);
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc3_[_loc7_] = _petsAtlas.list[_loc4_ + _loc7_];
               _loc7_++;
            }
         }
         return _loc3_;
      }
      
      public function getActivatePetAtlas() : DictionaryData
      {
         var _loc2_:DictionaryData = PlayerManager.Instance.Self.pets;
         var _loc1_:DictionaryData = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(!_loc1_.hasKey(_loc3_.CollectID) || _loc3_.Level > _loc1_[_loc3_.CollectID].Level || _loc3_.Level == _loc1_[_loc3_.CollectID].Level && _loc3_.StarLevel > _loc1_[_loc3_.CollectID].StarLevel)
            {
               _loc1_.add(_loc3_.CollectID,_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function get petsListSelected() : Array
      {
         _petsListSelected = [];
         var _loc1_:DictionaryData = PlayerManager.Instance.Self.pets;
         var _loc4_:int = 0;
         var _loc3_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.Place < 3)
            {
               _petsListSelected.push(_loc2_);
               if(_petsListSelected.length != 3)
               {
                  continue;
               }
               break;
            }
         }
         return _petsListSelected;
      }
      
      public function get petsListInBenchBag() : Array
      {
         _benchBagList = [];
         var _loc1_:DictionaryData = PlayerManager.Instance.Self.pets;
         var _loc4_:int = 0;
         var _loc3_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.Place >= 3)
            {
               _benchBagList.push(_loc2_);
            }
         }
         return _benchBagList;
      }
      
      public function petBagIsFull() : Boolean
      {
         var _loc1_:DictionaryData = PlayerManager.Instance.Self.pets;
         return _loc1_[0] && _loc1_[1] && _loc1_[2];
      }
      
      public function petBenchIsFull() : Boolean
      {
         var _loc1_:DictionaryData = PlayerManager.Instance.Self.pets;
         var _loc2_:int = cellMaxUnlockedPlace;
         var _loc3_:int = 3;
         while(_loc3_ < _loc2_)
         {
            if(_loc1_[_loc3_] == null)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function confirmData() : ConfirmAlertData
      {
         return _openCellConfirmData;
      }
      
      public function set unlockedCellNum(param1:int) : void
      {
         _unlockedCellNum = param1;
      }
      
      public function get unlockedCellNum() : int
      {
         return _unlockedCellNum + 5;
      }
      
      public function get cellMaxUnlockedPlace() : int
      {
         return _unlockedCellNum + 8;
      }
      
      public function getMoneyNeeded(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = _unlockedCellNum;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc2_ = _loc2_ + _priceList[_loc3_];
            _loc3_++;
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function set cellUnlockPrice(param1:Vector.<int>) : void
      {
         _priceList = param1;
      }
      
      public function get cellUnlockPrice() : Vector.<int>
      {
         return _priceList;
      }
      
      public function get curCellUnlockPrice() : int
      {
         return _priceList[_unlockedCellNum];
      }
      
      public function get currentPlayerInfo() : PlayerInfo
      {
         return _currentPlayerInfo;
      }
      
      public function set currentPlayerInfo(param1:PlayerInfo) : void
      {
         _currentPlayerInfo = param1;
      }
      
      public function get currentPetInfo() : PetInfo
      {
         return _currentPetInfo;
      }
      
      public function set currentPetInfo(param1:PetInfo) : void
      {
         if(param1 == _currentPetInfo)
         {
            return;
         }
         _currentPetInfo = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function get petGuildeOptionOnOff() : DictionaryData
      {
         if(!_petGuildeOptionOnOff)
         {
            _petGuildeOptionOnOff = new DictionaryData();
            _petGuildeOptionOnOff.add(117,0);
            _petGuildeOptionOnOff.add(118,0);
         }
         return _petGuildeOptionOnOff;
      }
      
      public function get petGuilde() : DictionaryData
      {
         if(_petGuilde == null)
         {
            _petGuilde = new DictionaryData();
            initPetGuilde(_petGuilde);
         }
         return _petGuilde;
      }
      
      private function initPetGuilde(param1:DictionaryData) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = undefined;
         _loc2_ = new Vector.<PetFarmGuildeInfo>();
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 90;
         _loc3_.PreArrowID = 0;
         _loc3_.NextArrowID = 91;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 91;
         _loc3_.PreArrowID = 90;
         _loc3_.NextArrowID = 92;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 92;
         _loc3_.PreArrowID = 91;
         _loc3_.NextArrowID = 93;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 93;
         _loc3_.PreArrowID = 92;
         _loc3_.NextArrowID = 0;
         _loc2_.push(_loc3_);
         _petGuilde.add(367,_loc2_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 94;
         _loc3_.PreArrowID = 0;
         _loc3_.NextArrowID = 95;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 95;
         _loc3_.PreArrowID = 94;
         _loc3_.NextArrowID = 97;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 97;
         _loc3_.PreArrowID = 95;
         _loc3_.NextArrowID = 0;
         _loc2_.push(_loc3_);
         _petGuilde.add(368,_loc2_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 99;
         _loc3_.PreArrowID = 0;
         _loc3_.NextArrowID = 0;
         _loc2_.push(_loc3_);
         _petGuilde.add(363,_loc2_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 120;
         _loc3_.PreArrowID = 0;
         _loc3_.NextArrowID = 100;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 100;
         _loc3_.PreArrowID = 120;
         _loc3_.NextArrowID = 101;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 101;
         _loc3_.PreArrowID = 100;
         _loc3_.NextArrowID = 102;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 102;
         _loc3_.PreArrowID = 101;
         _loc3_.NextArrowID = 103;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 103;
         _loc3_.PreArrowID = 102;
         _loc3_.NextArrowID = 0;
         _loc2_.push(_loc3_);
         _petGuilde.add(369,_loc2_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 119;
         _loc3_.PreArrowID = 0;
         _loc3_.NextArrowID = 107;
         _loc2_.push(_loc3_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 107;
         _loc3_.PreArrowID = 119;
         _loc3_.NextArrowID = 0;
         _loc2_.push(_loc3_);
         _petGuilde.add(370,_loc2_);
         _loc3_ = new PetFarmGuildeInfo();
         _loc3_.arrowID = 114;
         _loc3_.PreArrowID = 0;
         _loc3_.NextArrowID = 0;
         _loc2_.push(_loc3_);
         _petGuilde.add(366,_loc2_);
      }
      
      public function get currentPetBreakInfo() : BreakInfo
      {
         return _currentPetBreakInfo;
      }
      
      public function set currentPetBreakInfo(param1:BreakInfo) : void
      {
         _currentPetBreakInfo = param1;
      }
   }
}
