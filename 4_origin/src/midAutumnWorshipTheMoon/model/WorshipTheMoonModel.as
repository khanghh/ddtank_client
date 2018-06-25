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
      
      public function WorshipTheMoonModel(single:inner)
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
      
      public function init($view:IWorshipTheMoonMainFrame) : void
      {
         _view = $view;
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
      
      public function onceBtnNotShowBuyTipsAgainThisLogin(isUseBindMoney:Boolean) : void
      {
         _isOnceBtnShowBuyTipThisLogin = false;
         _isOnceBtnUseBindMoney = isUseBindMoney;
      }
      
      public function tensBtnNotShowBuyTipsAgainThisLogin(isUseBindMoney:Boolean) : void
      {
         _isTensBtnShowBuyTipThisLogin = false;
         _isTensBtnUseBindMoney = isUseBindMoney;
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
      
      public function updateIsOnceBtnUseBindMoney(value:Boolean) : void
      {
         _isOnceBtnUseBindMoney = value;
      }
      
      public function updateIsTensBtnUseBindMoney(value:Boolean) : void
      {
         _isTensBtnUseBindMoney = value;
      }
      
      public function getIsOnceBtnUseBindMoney() : Boolean
      {
         return _isOnceBtnUseBindMoney;
      }
      
      public function getIsTensBtnUseBindMoney() : Boolean
      {
         return _isTensBtnUseBindMoney;
      }
      
      public function getNeedMoneyTimes(timesGoingToRequire:int) : int
      {
         return Math.max(0,timesGoingToRequire - _timesRemain);
      }
      
      public function getNeedMoney(times:int) : int
      {
         return _pricePerWorship * getNeedMoneyTimes(times);
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
      
      public function updateIsOpen(value:Boolean) : void
      {
         _isopen = value;
      }
      
      public function updatePrice(value:int) : void
      {
         _pricePerWorship = value;
      }
      
      public function update200TimesGain(id:int) : void
      {
         _on200timesGainID = id;
      }
      
      public function updateFreeCounts(value:int) : void
      {
         _timesRemain = value;
      }
      
      public function updateWorshipedCounts(value:int) : void
      {
         _usedTimes = value;
      }
      
      public function update200State(gained:int) : void
      {
         if((gained + 1) * 300 - _usedTimes > 0)
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
      
      public function updateAwardsBoxInfoList(value:Vector.<WorshipTheMoonAwardsBoxInfo>) : void
      {
         _awardsBoxInfoList = value;
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
      
      public function updateItemsCanGainsIDList(value:Vector.<int>) : void
      {
         _itemsCanGainsIDList = value;
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
