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
      
      public function set petsAtlas(value:DictionaryData) : void
      {
         _petsAtlas = value;
      }
      
      public function get eatPetsInfo() : DictionaryData
      {
         if(_eatPetsInfo == null)
         {
            _eatPetsInfo = new DictionaryData();
         }
         return _eatPetsInfo;
      }
      
      public function set eatPetsInfo(value:DictionaryData) : void
      {
         _eatPetsInfo = value;
         dispatchEvent(new PetItemEvent("eat_pets_complete"));
      }
      
      public function getPetAtlasSorted(page:int, count:int = 15) : Vector.<PetAtlasInfo>
      {
         var startIndex:int = 0;
         var len:int = 0;
         var i:int = 0;
         var result:Vector.<PetAtlasInfo> = new Vector.<PetAtlasInfo>(count);
         var totlaPage:int = Math.ceil(_petsAtlas.length / count);
         if(page > 0 && page <= totlaPage)
         {
            startIndex = 0 + count * (page - 1);
            len = Math.min(_petsAtlas.length - startIndex,count);
            for(i = 0; i < len; )
            {
               result[i] = _petsAtlas.list[startIndex + i];
               i++;
            }
         }
         return result;
      }
      
      public function getActivatePetAtlas() : DictionaryData
      {
         var petList:DictionaryData = PlayerManager.Instance.Self.pets;
         var petAtlas:DictionaryData = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = petList;
         for each(var petInfo in petList)
         {
            if(!petAtlas.hasKey(petInfo.CollectID) || petInfo.Level > petAtlas[petInfo.CollectID].Level || petInfo.Level == petAtlas[petInfo.CollectID].Level && petInfo.StarLevel > petAtlas[petInfo.CollectID].StarLevel)
            {
               petAtlas.add(petInfo.CollectID,petInfo);
            }
         }
         return petAtlas;
      }
      
      public function get petsListSelected() : Array
      {
         _petsListSelected = [];
         var petList:DictionaryData = PlayerManager.Instance.Self.pets;
         var _loc4_:int = 0;
         var _loc3_:* = petList;
         for each(var petInfo in petList)
         {
            if(petInfo.Place < 3)
            {
               _petsListSelected.push(petInfo);
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
         var petList:DictionaryData = PlayerManager.Instance.Self.pets;
         var _loc4_:int = 0;
         var _loc3_:* = petList;
         for each(var petInfo in petList)
         {
            if(petInfo.Place >= 3)
            {
               _benchBagList.push(petInfo);
            }
         }
         return _benchBagList;
      }
      
      public function petBagIsFull() : Boolean
      {
         var pets:DictionaryData = PlayerManager.Instance.Self.pets;
         return pets[0] && pets[1] && pets[2];
      }
      
      public function petBenchIsFull() : Boolean
      {
         var pets:DictionaryData = PlayerManager.Instance.Self.pets;
         var len:int = cellMaxUnlockedPlace;
         var i:int = 3;
         while(i < len)
         {
            if(pets[i] == null)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function confirmData() : ConfirmAlertData
      {
         return _openCellConfirmData;
      }
      
      public function set unlockedCellNum(value:int) : void
      {
         _unlockedCellNum = value;
      }
      
      public function get unlockedCellNum() : int
      {
         return _unlockedCellNum + 5;
      }
      
      public function get cellMaxUnlockedPlace() : int
      {
         return _unlockedCellNum + 8;
      }
      
      public function getMoneyNeeded(times:int) : int
      {
         var i:int = 0;
         var tempUnlockPlace:int = _unlockedCellNum;
         var moneyNeed:int = 0;
         for(i = 0; i < times; )
         {
            moneyNeed = moneyNeed + _priceList[tempUnlockPlace];
            tempUnlockPlace++;
            i++;
         }
         return moneyNeed;
      }
      
      public function set cellUnlockPrice(value:Vector.<int>) : void
      {
         _priceList = value;
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
      
      public function set currentPlayerInfo(value:PlayerInfo) : void
      {
         _currentPlayerInfo = value;
      }
      
      public function get currentPetInfo() : PetInfo
      {
         return _currentPetInfo;
      }
      
      public function set currentPetInfo(value:PetInfo) : void
      {
         if(value == _currentPetInfo)
         {
            return;
         }
         _currentPetInfo = value;
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
      
      private function initPetGuilde(petTask:DictionaryData) : void
      {
         var petGuildeTaskInfo:* = null;
         var petGuildeTaskList:* = undefined;
         petGuildeTaskList = new Vector.<PetFarmGuildeInfo>();
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 90;
         petGuildeTaskInfo.PreArrowID = 0;
         petGuildeTaskInfo.NextArrowID = 91;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 91;
         petGuildeTaskInfo.PreArrowID = 90;
         petGuildeTaskInfo.NextArrowID = 92;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 92;
         petGuildeTaskInfo.PreArrowID = 91;
         petGuildeTaskInfo.NextArrowID = 93;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 93;
         petGuildeTaskInfo.PreArrowID = 92;
         petGuildeTaskInfo.NextArrowID = 0;
         petGuildeTaskList.push(petGuildeTaskInfo);
         _petGuilde.add(367,petGuildeTaskList);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 94;
         petGuildeTaskInfo.PreArrowID = 0;
         petGuildeTaskInfo.NextArrowID = 95;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 95;
         petGuildeTaskInfo.PreArrowID = 94;
         petGuildeTaskInfo.NextArrowID = 97;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 97;
         petGuildeTaskInfo.PreArrowID = 95;
         petGuildeTaskInfo.NextArrowID = 0;
         petGuildeTaskList.push(petGuildeTaskInfo);
         _petGuilde.add(368,petGuildeTaskList);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 99;
         petGuildeTaskInfo.PreArrowID = 0;
         petGuildeTaskInfo.NextArrowID = 0;
         petGuildeTaskList.push(petGuildeTaskInfo);
         _petGuilde.add(363,petGuildeTaskList);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 120;
         petGuildeTaskInfo.PreArrowID = 0;
         petGuildeTaskInfo.NextArrowID = 100;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 100;
         petGuildeTaskInfo.PreArrowID = 120;
         petGuildeTaskInfo.NextArrowID = 101;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 101;
         petGuildeTaskInfo.PreArrowID = 100;
         petGuildeTaskInfo.NextArrowID = 102;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 102;
         petGuildeTaskInfo.PreArrowID = 101;
         petGuildeTaskInfo.NextArrowID = 103;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 103;
         petGuildeTaskInfo.PreArrowID = 102;
         petGuildeTaskInfo.NextArrowID = 0;
         petGuildeTaskList.push(petGuildeTaskInfo);
         _petGuilde.add(369,petGuildeTaskList);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 119;
         petGuildeTaskInfo.PreArrowID = 0;
         petGuildeTaskInfo.NextArrowID = 107;
         petGuildeTaskList.push(petGuildeTaskInfo);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 107;
         petGuildeTaskInfo.PreArrowID = 119;
         petGuildeTaskInfo.NextArrowID = 0;
         petGuildeTaskList.push(petGuildeTaskInfo);
         _petGuilde.add(370,petGuildeTaskList);
         petGuildeTaskInfo = new PetFarmGuildeInfo();
         petGuildeTaskInfo.arrowID = 114;
         petGuildeTaskInfo.PreArrowID = 0;
         petGuildeTaskInfo.NextArrowID = 0;
         petGuildeTaskList.push(petGuildeTaskInfo);
         _petGuilde.add(366,petGuildeTaskList);
      }
      
      public function get currentPetBreakInfo() : BreakInfo
      {
         return _currentPetBreakInfo;
      }
      
      public function set currentPetBreakInfo(value:BreakInfo) : void
      {
         _currentPetBreakInfo = value;
      }
   }
}
