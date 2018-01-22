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
      
      public function WorshipTheMoonModel(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : WorshipTheMoonModel
      {
         if(!instance)
         {
            instance = new WorshipTheMoonModel(new inner());
         }
         return instance;
      }
      
      public function init(param1:IWorshipTheMoonMainFrame) : void
      {
         _view = param1;
      }
      
      public function dispose() : void
      {
         _view = null;
      }
      
      public function getIsActivityOpen() : Boolean
      {
         return _isopen;
      }
      
      public function onceBtnShowTipsAgain() : void
      {
         _isOnceBtnShowBuyTipThisLogin = true;
      }
      
      public function tensBtnShowTipsAgain() : void
      {
         _isTensBtnShowBuyTipThisLogin = true;
      }
      
      public function onceBtnNotShowBuyTipsAgainThisLogin(param1:Boolean) : void
      {
         _isOnceBtnShowBuyTipThisLogin = false;
         _isOnceBtnUseBindMoney = param1;
      }
      
      public function tensBtnNotShowBuyTipsAgainThisLogin(param1:Boolean) : void
      {
         _isTensBtnShowBuyTipThisLogin = false;
         _isTensBtnUseBindMoney = param1;
      }
      
      public function getPricePerWorship() : int
      {
         return _pricePerWorship;
      }
      
      public function getIsOnceBtnShowBuyTipThisLogin() : Boolean
      {
         return _isOnceBtnShowBuyTipThisLogin;
      }
      
      public function getIsTensBtnShowBuyTipThisLogin() : Boolean
      {
         return _isTensBtnShowBuyTipThisLogin;
      }
      
      public function updateIsOnceBtnUseBindMoney(param1:Boolean) : void
      {
         _isOnceBtnUseBindMoney = param1;
      }
      
      public function updateIsTensBtnUseBindMoney(param1:Boolean) : void
      {
         _isTensBtnUseBindMoney = param1;
      }
      
      public function getIsOnceBtnUseBindMoney() : Boolean
      {
         return _isOnceBtnUseBindMoney;
      }
      
      public function getIsTensBtnUseBindMoney() : Boolean
      {
         return _isTensBtnUseBindMoney;
      }
      
      public function getNeedMoneyTimes(param1:int) : int
      {
         return Math.max(0,param1 - _timesRemain);
      }
      
      public function getNeedMoney(param1:int) : int
      {
         return _pricePerWorship * getNeedMoneyTimes(param1);
      }
      
      public function getTimesRemain() : int
      {
         return _timesRemain;
      }
      
      public function getUsedTimes() : int
      {
         return _usedTimes;
      }
      
      public function getAwardsGainedBoxInfoList() : Vector.<WorshipTheMoonAwardsBoxInfo>
      {
         return _awardsBoxInfoList;
      }
      
      public function getItemsCanGainsIDList() : Vector.<int>
      {
         return _itemsCanGainsIDList;
      }
      
      public function getCurrentMoonType() : int
      {
         return _currentMoonType;
      }
      
      public function get200TimesGainsID() : int
      {
         return _on200timesGainID;
      }
      
      public function updateIsOpen(param1:Boolean) : void
      {
         _isopen = param1;
      }
      
      public function updatePrice(param1:int) : void
      {
         _pricePerWorship = param1;
      }
      
      public function update200TimesGain(param1:int) : void
      {
         _on200timesGainID = param1;
      }
      
      public function updateFreeCounts(param1:int) : void
      {
         _timesRemain = param1;
      }
      
      public function updateWorshipedCounts(param1:int) : void
      {
         _usedTimes = param1;
      }
      
      public function update200State(param1:int) : void
      {
         if((param1 + 1) * 300 - _usedTimes > 0)
         {
            _state200AwardsBoxIcon = 1;
         }
         else
         {
            _state200AwardsBoxIcon = 2;
         }
      }
      
      public function canGain200AwardsBox() : int
      {
         return _state200AwardsBoxIcon;
      }
      
      public function updateAwardsBoxInfoList(param1:Vector.<WorshipTheMoonAwardsBoxInfo>) : void
      {
         _awardsBoxInfoList = param1;
         if(_awardsBoxInfoList.length == 1)
         {
            _currentMoonType = _awardsBoxInfoList[0].moonType;
            _view && _view.playOnceAnimation();
         }
         else
         {
            _view && _view.playTenTimesAnimation();
         }
      }
      
      public function updateItemsCanGainsIDList(param1:Vector.<int>) : void
      {
         _itemsCanGainsIDList = param1;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
