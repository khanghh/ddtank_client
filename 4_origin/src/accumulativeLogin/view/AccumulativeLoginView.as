package accumulativeLogin.view
{
   import accumulativeLogin.AccumulativeManager;
   import accumulativeLogin.data.AccumulativeLoginRewardData;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.Dictionary;
   
   public class AccumulativeLoginView extends Sprite
   {
       
      
      private var _back:Bitmap;
      
      private var _progressBarBack:Bitmap;
      
      private var _progressBar:Bitmap;
      
      private var _progressBarItemArr:Array;
      
      private var _clickSpriteArr:Array;
      
      private var _progressCompleteItem:MovieClip;
      
      private var _dayTxtArr:Array;
      
      private var _loginDayTxt:FilterFrameText;
      
      private var _loginDayNum:int;
      
      private var _awardDayNum:int;
      
      private var _hBox:HBox;
      
      private var _dataDic:Dictionary;
      
      private var _selectedDay:int;
      
      private var _selectedFiveWeaponId:int;
      
      private var _dayGiftPackDic:Dictionary;
      
      private var _fiveWeaponArr:Array;
      
      private var _bagCellBgArr:Array;
      
      private var _filter:ColorMatrixFilter;
      
      private var _movieStringArr:Array;
      
      private var _movieVector:Vector.<AccumulativeMovieSprite>;
      
      private var _getButton:SimpleBitmapButton;
      
      public function AccumulativeLoginView()
      {
         _movieStringArr = ["wonderfulactivity.login.gun","wonderfulactivity.login.axe","wonderfulactivity.login.chick","wonderfulactivity.login.boomerang","wonderfulactivity.login.cannon"];
         super();
         _movieVector = new Vector.<AccumulativeMovieSprite>();
         _progressBarItemArr = [];
         _clickSpriteArr = [];
         _dayTxtArr = [];
         _dayGiftPackDic = new Dictionary();
         _bagCellBgArr = [];
         _fiveWeaponArr = [];
      }
      
      public function setState(param1:int, param2:int) : void
      {
      }
      
      public function init() : void
      {
         createFilter();
         initEvent();
         initView();
         initData();
         initViewWithData();
         selectedDay = _loginDayNum;
      }
      
      private function createFilter() : void
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([0.3086,0.6094,0.082,0,0]);
         _loc1_ = _loc1_.concat([0.3086,0.6094,0.082,0,0]);
         _loc1_ = _loc1_.concat([0.3086,0.6094,0.082,0,0]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         _filter = new ColorMatrixFilter(_loc1_);
      }
      
      public function initEvent() : void
      {
         AccumulativeManager.instance.addEventListener("accumulativeLoginAwardRefresh",__refreshAward);
      }
      
      protected function __refreshAward(param1:Event) : void
      {
         _loginDayNum = PlayerManager.Instance.Self.accumulativeLoginDays > 7?7:PlayerManager.Instance.Self.accumulativeLoginDays;
         _awardDayNum = PlayerManager.Instance.Self.accumulativeAwardDays;
         checkMovieCanClick();
         if(_awardDayNum >= _loginDayNum)
         {
            _getButton.enable = false;
         }
         else
         {
            _getButton.enable = true;
         }
         selectedDay = _selectedDay;
      }
      
      private function initView() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         _back = ComponentFactory.Instance.creat("wonderfulactivity.login.back");
         addChild(_back);
         _loginDayTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.accumulativeLogin.dayTxt");
         addChild(_loginDayTxt);
         _loc5_ = 1;
         while(_loc5_ < 8)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.accumulativeLogin.dayTxt");
            addChild(_loc4_);
            _loc4_.text = "" + _loc5_;
            _loc4_.x = _loc5_ == 7?700:Number(334 + 62 * (_loc5_ - 1));
            _loc4_.y = 150;
            _dayTxtArr.push(_loc4_);
            _loc5_++;
         }
         _progressBarBack = ComponentFactory.Instance.creat("wonderfulactivity.login.barback");
         addChild(_progressBarBack);
         _progressBar = ComponentFactory.Instance.creat("wonderfulactivity.login.bar");
         addChild(_progressBar);
         _loc6_ = 0;
         while(_loc6_ < 6)
         {
            _loc3_ = ComponentFactory.Instance.creat("wonderfulactivity.login.barItem");
            _loc3_.x = 334 + 62 * _loc6_;
            _loc3_.y = 170;
            addChild(_loc3_);
            _progressBarItemArr.push(_loc3_);
            _loc6_++;
         }
         _progressCompleteItem = ComponentFactory.Instance.creat("wonderfulactivity.login.barCompleteItem");
         addChild(_progressCompleteItem);
         _progressCompleteItem.y = 170;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new Sprite();
            _loc1_.buttonMode = true;
            _loc1_.graphics.beginFill(0,0);
            if(_loc2_ != 6)
            {
               _loc1_.graphics.drawRect(_progressBarItemArr[_loc2_].x,170,_progressBarItemArr[_loc2_].width,_progressBarItemArr[_loc2_].height);
            }
            else
            {
               _loc1_.graphics.drawRect(_progressBarItemArr[5].x + 58,170,_progressBarItemArr[5].width + 8,_progressBarItemArr[5].height);
            }
            _loc1_.graphics.endFill();
            _loc1_.addEventListener("click",__showAwardHandler);
            addChild(_loc1_);
            _clickSpriteArr.push(_loc1_);
            _loc2_++;
         }
         _hBox = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulativeLogin.Hbox");
         addChild(_hBox);
         _loc8_ = 0;
         while(_loc8_ < _movieStringArr.length)
         {
            _loc7_ = new AccumulativeMovieSprite(_movieStringArr[_loc8_]);
            _loc7_.addEventListener("click",__onClickHandler);
            addChild(_loc7_);
            PositionUtils.setPos(_loc7_,"wonderful.accumulativeLogin.moviePos" + (_loc8_ + 1));
            _movieVector.push(_loc7_);
            _loc8_++;
         }
         _getButton = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.GetButton");
         addChild(_getButton);
         _getButton.enable = false;
      }
      
      protected function __showAwardHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = _clickSpriteArr.indexOf(param1.target);
         if(_loc2_ != -1 && _loc2_ + 1 != selectedDay)
         {
            selectedDay = _loc2_ + 1;
         }
      }
      
      protected function __onClickHandler(param1:MouseEvent) : void
      {
         if(_loginDayNum < 7)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulactivity.accumulativelogin.txt"));
            return;
         }
         if(param1.currentTarget.state == 3)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _movieVector;
         for each(var _loc2_ in _movieVector)
         {
            if(_loc2_ == param1.currentTarget)
            {
               _loc2_.state = 3;
               _selectedFiveWeaponId = _loc2_.data.ID;
            }
            else
            {
               _loc2_.state = 1;
            }
         }
      }
      
      protected function __onOverHandler(param1:MouseEvent) : void
      {
         (param1.target as MovieClip).gotoAndPlay(2);
      }
      
      private function checkMovieCanClick() : void
      {
         if(_loginDayNum >= 7 && _awardDayNum >= 7)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _movieVector;
            for each(var _loc1_ in _movieVector)
            {
               _loc1_.removeEventListener("click",__onClickHandler);
               _loc1_.state = 1;
            }
         }
         if(_loginDayNum >= 7 && _awardDayNum < 7)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _movieVector;
            for each(var _loc2_ in _movieVector)
            {
               _loc2_.state = 2;
            }
         }
      }
      
      private function initData() : void
      {
         _loginDayNum = PlayerManager.Instance.Self.accumulativeLoginDays > 7?7:PlayerManager.Instance.Self.accumulativeLoginDays;
         _awardDayNum = PlayerManager.Instance.Self.accumulativeAwardDays;
         if(_awardDayNum < _loginDayNum && _awardDayNum < 7)
         {
            _getButton.enable = true;
            _getButton.addEventListener("click",__getAward);
         }
         else
         {
            _getButton.enable = false;
         }
         _dataDic = AccumulativeManager.instance.dataDic;
      }
      
      private function initViewWithData() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         checkMovieCanClick();
         _loginDayTxt.text = "" + _loginDayNum;
         if(_loginDayNum < 7)
         {
            _progressBar.width = !!_progressBarItemArr[_loginDayNum - 1]?_progressBarItemArr[_loginDayNum - 1].x - 265:0;
            _progressCompleteItem.x = _progressBar.width + 256;
         }
         else if(_loginDayNum >= 7)
         {
            _progressBar.width = _progressBarItemArr[5].x - 265 + 55;
            _progressCompleteItem.x = _progressBar.width + 258;
         }
         if(!_dataDic)
         {
            return;
         }
         _loc4_ = 1;
         while(_loc4_ < 8)
         {
            _loc1_ = [];
            var _loc7_:int = 0;
            var _loc6_:* = _dataDic[_loc4_];
            for each(var _loc2_ in _dataDic[_loc4_])
            {
               _loc3_ = createBagCellSp(_loc2_,_loc4_);
               _loc1_.push(_loc3_);
            }
            _dayGiftPackDic[_loc4_] = _loc1_;
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _movieVector.length)
         {
            _movieVector[_loc5_].tipData = _fiveWeaponArr[_loc5_].tipData;
            _movieVector[_loc5_].data = _dataDic[7][_loc5_];
            _loc5_++;
         }
      }
      
      private function __getAward(param1:MouseEvent) : void
      {
         if(_loginDayNum >= 7 && _selectedFiveWeaponId == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulactivity.accumulativelogin.txt2"));
            return;
         }
         SocketManager.Instance.out.sendAccumulativeLoginAward(_selectedFiveWeaponId);
      }
      
      private function set selectedDay(param1:int) : void
      {
         _selectedDay = param1;
         if(_selectedDay > 7)
         {
            _selectedDay = 7;
         }
         _hBox.removeAllChild();
         var _loc4_:int = 0;
         var _loc3_:* = _dayGiftPackDic[_selectedDay];
         for each(var _loc2_ in _dayGiftPackDic[_selectedDay])
         {
            if(_selectedDay <= _awardDayNum)
            {
               graySp(_loc2_);
            }
            else
            {
               _loc2_.filters = null;
            }
            _hBox.addChild(_loc2_);
         }
      }
      
      private function graySp(param1:Sprite) : void
      {
         param1.filters = [_filter];
      }
      
      private function get selectedDay() : int
      {
         return _selectedDay;
      }
      
      private function createBagCellSp(param1:AccumulativeLoginRewardData, param2:int) : Sprite
      {
         var _loc5_:Sprite = new Sprite();
         var _loc4_:Bitmap = ComponentFactory.Instance.creat("wonderfulactivity.login.bagCellBg");
         var _loc7_:* = 0.7;
         _loc4_.scaleY = _loc7_;
         _loc4_.scaleX = _loc7_;
         _loc5_.addChild(_loc4_);
         var _loc6_:InventoryItemInfo = new InventoryItemInfo();
         _loc6_.TemplateID = param1.RewardItemID;
         _loc6_ = ItemManager.fill(_loc6_);
         _loc6_.IsBinds = param1.IsBind;
         _loc6_.ValidDate = param1.RewardItemValid;
         _loc6_.StrengthenLevel = param1.StrengthenLevel;
         _loc6_.AttackCompose = param1.AttackCompose;
         _loc6_.DefendCompose = param1.DefendCompose;
         _loc6_.AgilityCompose = param1.AgilityCompose;
         _loc6_.LuckCompose = param1.LuckCompose;
         var _loc3_:BagCell = new BagCell(0);
         _loc3_.info = _loc6_;
         _loc3_.setCount(param1.RewardItemCount);
         _loc3_.setBgVisible(false);
         _loc7_ = 4;
         _loc3_.y = _loc7_;
         _loc3_.x = _loc7_;
         _loc5_.addChild(_loc3_);
         if(param2 == 7)
         {
            _fiveWeaponArr.push(_loc3_);
         }
         return _loc5_;
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         AccumulativeManager.instance.removeEventListener("accumulativeLoginAwardRefresh",__refreshAward);
         var _loc10_:int = 0;
         var _loc9_:* = _dayGiftPackDic;
         for each(var _loc4_ in _dayGiftPackDic)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc5_ = _loc4_[_loc6_];
               ObjectUtils.disposeAllChildren(_loc5_);
               ObjectUtils.disposeObject(_loc5_);
               _loc6_++;
            }
         }
         _dayGiftPackDic = null;
         var _loc12_:int = 0;
         var _loc11_:* = _fiveWeaponArr;
         for each(var _loc3_ in _fiveWeaponArr)
         {
            ObjectUtils.disposeObject(_loc3_);
            _loc3_ = null;
         }
         _fiveWeaponArr = null;
         _loc8_ = 0;
         while(_loc8_ < _movieVector.length)
         {
            _movieVector[_loc8_].removeEventListener("click",__onClickHandler);
            _movieVector[_loc8_].dispose();
            _movieVector[_loc8_] = null;
            _loc8_++;
         }
         _movieVector = null;
         var _loc14_:int = 0;
         var _loc13_:* = _progressBarItemArr;
         for each(var _loc2_ in _progressBarItemArr)
         {
            if(_loc2_)
            {
               ObjectUtils.disposeObject(_loc2_);
            }
            _loc2_ = null;
         }
         _progressBarItemArr = null;
         var _loc16_:int = 0;
         var _loc15_:* = _clickSpriteArr;
         for each(var _loc1_ in _clickSpriteArr)
         {
            if(_loc1_)
            {
               _loc1_.graphics.clear();
            }
            _loc1_.removeEventListener("click",__showAwardHandler);
            _loc1_ = null;
         }
         _clickSpriteArr = null;
         var _loc18_:int = 0;
         var _loc17_:* = _dayTxtArr;
         for each(var _loc7_ in _dayTxtArr)
         {
            if(_loc7_)
            {
               ObjectUtils.disposeObject(_loc7_);
            }
            _loc7_ = null;
         }
         _dayTxtArr = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_hBox)
         {
            ObjectUtils.disposeObject(_hBox);
         }
         _hBox = null;
         if(_progressCompleteItem)
         {
            ObjectUtils.disposeObject(_progressCompleteItem);
         }
         _progressCompleteItem = null;
         if(_loginDayTxt)
         {
            ObjectUtils.disposeObject(_loginDayTxt);
         }
         _loginDayTxt = null;
         if(_progressBarBack)
         {
            ObjectUtils.disposeObject(_progressBarBack);
         }
         _progressBarBack = null;
         if(_progressBar)
         {
            ObjectUtils.disposeObject(_progressBar);
         }
         _progressBar = null;
         if(_getButton)
         {
            _getButton.removeEventListener("click",__getAward);
         }
         ObjectUtils.disposeObject(_getButton);
         _getButton = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
