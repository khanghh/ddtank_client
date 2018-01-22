package midAutumnWorshipTheMoon.model
{
   import midAutumnWorshipTheMoon.i.IWorshipTheMoonMainFrame;
   
   public class WorshipTheMoonModel
   {
      
      private static var instance:WorshipTheMoonModel;
       
      
      private var _view:IWorshipTheMoonMainFrame;
      
      private var _isopen:Boolean = false;
      
      private var _timesRemain:int = -1;
      
      private var _usedTimes:int = -1;
      
      private var _on200timesGainID:int;
      
      private var _currentMoonType:int;
      
      private var _awardsBoxInfoList:Vector.<WorshipTheMoonAwardsBoxInfo>;
      
      private var _itemsCanGainsIDList:Vector.<int>;
      
      private var _pricePerWorship:int;
      
      private var _isOnceBtnShowBuyTipThisLogin:Boolean = true;
      
      private var _isOnceBtnUseBindMoney:Boolean = false;
      
      private var _isTensBtnShowBuyTipThisLogin:Boolean = true;
      
      private var _isTensBtnUseBindMoney:Boolean = false;
      
      private var _timesGoingToWorship:int = 0;
      
      private var _state200AwardsBoxIcon:int;
      
      public function WorshipTheMoonModel(param1:inner){super();}
      
      public static function getInstance() : WorshipTheMoonModel{return null;}
      
      public function init(param1:IWorshipTheMoonMainFrame) : void{}
      
      public function dispose() : void{}
      
      public function getIsActivityOpen() : Boolean{return false;}
      
      public function onceBtnShowTipsAgain() : void{}
      
      public function tensBtnShowTipsAgain() : void{}
      
      public function onceBtnNotShowBuyTipsAgainThisLogin(param1:Boolean) : void{}
      
      public function tensBtnNotShowBuyTipsAgainThisLogin(param1:Boolean) : void{}
      
      public function getPricePerWorship() : int{return 0;}
      
      public function getIsOnceBtnShowBuyTipThisLogin() : Boolean{return false;}
      
      public function getIsTensBtnShowBuyTipThisLogin() : Boolean{return false;}
      
      public function updateIsOnceBtnUseBindMoney(param1:Boolean) : void{}
      
      public function updateIsTensBtnUseBindMoney(param1:Boolean) : void{}
      
      public function getIsOnceBtnUseBindMoney() : Boolean{return false;}
      
      public function getIsTensBtnUseBindMoney() : Boolean{return false;}
      
      public function getNeedMoneyTimes(param1:int) : int{return 0;}
      
      public function getNeedMoney(param1:int) : int{return 0;}
      
      public function getTimesRemain() : int{return 0;}
      
      public function getUsedTimes() : int{return 0;}
      
      public function getAwardsGainedBoxInfoList() : Vector.<WorshipTheMoonAwardsBoxInfo>{return null;}
      
      public function getItemsCanGainsIDList() : Vector.<int>{return null;}
      
      public function getCurrentMoonType() : int{return 0;}
      
      public function get200TimesGainsID() : int{return 0;}
      
      public function updateIsOpen(param1:Boolean) : void{}
      
      public function updatePrice(param1:int) : void{}
      
      public function update200TimesGain(param1:int) : void{}
      
      public function updateFreeCounts(param1:int) : void{}
      
      public function updateWorshipedCounts(param1:int) : void{}
      
      public function update200State(param1:int) : void{}
      
      public function canGain200AwardsBox() : int{return 0;}
      
      public function updateAwardsBoxInfoList(param1:Vector.<WorshipTheMoonAwardsBoxInfo>) : void{}
      
      public function updateItemsCanGainsIDList(param1:Vector.<int>) : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
