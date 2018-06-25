package petsBag{   import ddt.data.player.PlayerInfo;   import ddt.manager.PlayerManager;   import ddt.utils.ConfirmAlertData;   import flash.events.Event;   import flash.events.EventDispatcher;   import pet.data.PetInfo;   import petsBag.data.BreakInfo;   import petsBag.data.PetAtlasInfo;   import petsBag.data.PetFarmGuildeInfo;   import petsBag.event.PetItemEvent;   import road7th.data.DictionaryData;      public class PetBagModel extends EventDispatcher   {                   private var _currentPetBreakInfo:BreakInfo;            private var _currentPetInfo:PetInfo;            private var _currentPlayerInfo:PlayerInfo;            private var _adoptPets:DictionaryData;            private var _adoptItems:DictionaryData;            private var _petsAtlas:DictionaryData;            private var _eatPetsInfo:DictionaryData;            public var eatPetsLevelUp:Boolean;            private var _petsListSelected:Array;            private var _benchBagList:Array;            private var _openCellConfirmData:ConfirmAlertData;            private var _unlockedCellNum:int;            private var _priceList:Vector.<int>;            public var isLoadPetTrainer:Boolean;            public var CurrentPetFarmGuildeArrow:Object;            public var IsFinishTask5:Boolean = false;            private var _petGuildeOptionOnOff:DictionaryData;            private var _petGuilde:DictionaryData;            public var nextShowArrowID:int = 0;            public var preShowArrowID:int = 0;            public function PetBagModel() { super(); }
            public function get adoptPets() : DictionaryData { return null; }
            public function get adoptItems() : DictionaryData { return null; }
            public function get petsAtlas() : DictionaryData { return null; }
            public function set petsAtlas(value:DictionaryData) : void { }
            public function get eatPetsInfo() : DictionaryData { return null; }
            public function set eatPetsInfo(value:DictionaryData) : void { }
            public function getPetAtlasSorted(page:int, count:int = 15) : Vector.<PetAtlasInfo> { return null; }
            public function getActivatePetAtlas() : DictionaryData { return null; }
            public function get petsListSelected() : Array { return null; }
            public function get petsListInBenchBag() : Array { return null; }
            public function petBagIsFull() : Boolean { return false; }
            public function petBenchIsFull() : Boolean { return false; }
            public function confirmData() : ConfirmAlertData { return null; }
            public function set unlockedCellNum(value:int) : void { }
            public function get unlockedCellNum() : int { return 0; }
            public function get cellMaxUnlockedPlace() : int { return 0; }
            public function getMoneyNeeded(times:int) : int { return 0; }
            public function set cellUnlockPrice(value:Vector.<int>) : void { }
            public function get cellUnlockPrice() : Vector.<int> { return null; }
            public function get curCellUnlockPrice() : int { return 0; }
            public function get currentPlayerInfo() : PlayerInfo { return null; }
            public function set currentPlayerInfo(value:PlayerInfo) : void { }
            public function get currentPetInfo() : PetInfo { return null; }
            public function set currentPetInfo(value:PetInfo) : void { }
            public function get petGuildeOptionOnOff() : DictionaryData { return null; }
            public function get petGuilde() : DictionaryData { return null; }
            private function initPetGuilde(petTask:DictionaryData) : void { }
            public function get currentPetBreakInfo() : BreakInfo { return null; }
            public function set currentPetBreakInfo(value:BreakInfo) : void { }
   }}