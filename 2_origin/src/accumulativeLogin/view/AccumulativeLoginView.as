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
      
      public function setState(type:int, id:int) : void
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
         var matrix:Array = [];
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0,0,0,1,0]);
         _filter = new ColorMatrixFilter(matrix);
      }
      
      public function initEvent() : void
      {
         AccumulativeManager.instance.addEventListener("accumulativeLoginAwardRefresh",__refreshAward);
      }
      
      protected function __refreshAward(event:Event) : void
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
         var j:int = 0;
         var dayTxt:* = null;
         var k:int = 0;
         var progressBarItem:* = null;
         var ll:int = 0;
         var clickSp:* = null;
         var i:int = 0;
         var movieClip:* = null;
         _back = ComponentFactory.Instance.creat("wonderfulactivity.login.back");
         addChild(_back);
         _loginDayTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.accumulativeLogin.dayTxt");
         addChild(_loginDayTxt);
         for(j = 1; j < 8; )
         {
            dayTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.accumulativeLogin.dayTxt");
            addChild(dayTxt);
            dayTxt.text = "" + j;
            dayTxt.x = j == 7?700:Number(334 + 62 * (j - 1));
            dayTxt.y = 150;
            _dayTxtArr.push(dayTxt);
            j++;
         }
         _progressBarBack = ComponentFactory.Instance.creat("wonderfulactivity.login.barback");
         addChild(_progressBarBack);
         _progressBar = ComponentFactory.Instance.creat("wonderfulactivity.login.bar");
         addChild(_progressBar);
         for(k = 0; k < 6; )
         {
            progressBarItem = ComponentFactory.Instance.creat("wonderfulactivity.login.barItem");
            progressBarItem.x = 334 + 62 * k;
            progressBarItem.y = 170;
            addChild(progressBarItem);
            _progressBarItemArr.push(progressBarItem);
            k++;
         }
         _progressCompleteItem = ComponentFactory.Instance.creat("wonderfulactivity.login.barCompleteItem");
         addChild(_progressCompleteItem);
         _progressCompleteItem.y = 170;
         for(ll = 0; ll < 7; )
         {
            clickSp = new Sprite();
            clickSp.buttonMode = true;
            clickSp.graphics.beginFill(0,0);
            if(ll != 6)
            {
               clickSp.graphics.drawRect(_progressBarItemArr[ll].x,170,_progressBarItemArr[ll].width,_progressBarItemArr[ll].height);
            }
            else
            {
               clickSp.graphics.drawRect(_progressBarItemArr[5].x + 58,170,_progressBarItemArr[5].width + 8,_progressBarItemArr[5].height);
            }
            clickSp.graphics.endFill();
            clickSp.addEventListener("click",__showAwardHandler);
            addChild(clickSp);
            _clickSpriteArr.push(clickSp);
            ll++;
         }
         _hBox = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulativeLogin.Hbox");
         addChild(_hBox);
         for(i = 0; i < _movieStringArr.length; )
         {
            movieClip = new AccumulativeMovieSprite(_movieStringArr[i]);
            movieClip.addEventListener("click",__onClickHandler);
            addChild(movieClip);
            PositionUtils.setPos(movieClip,"wonderful.accumulativeLogin.moviePos" + (i + 1));
            _movieVector.push(movieClip);
            i++;
         }
         _getButton = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.GetButton");
         addChild(_getButton);
         _getButton.enable = false;
      }
      
      protected function __showAwardHandler(event:MouseEvent) : void
      {
         var index:int = _clickSpriteArr.indexOf(event.target);
         if(index != -1 && index + 1 != selectedDay)
         {
            selectedDay = index + 1;
         }
      }
      
      protected function __onClickHandler(event:MouseEvent) : void
      {
         if(_loginDayNum < 7)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulactivity.accumulativelogin.txt"));
            return;
         }
         if(event.currentTarget.state == 3)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _movieVector;
         for each(var movie in _movieVector)
         {
            if(movie == event.currentTarget)
            {
               movie.state = 3;
               _selectedFiveWeaponId = movie.data.ID;
            }
            else
            {
               movie.state = 1;
            }
         }
      }
      
      protected function __onOverHandler(event:MouseEvent) : void
      {
         (event.target as MovieClip).gotoAndPlay(2);
      }
      
      private function checkMovieCanClick() : void
      {
         if(_loginDayNum >= 7 && _awardDayNum >= 7)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _movieVector;
            for each(var movie in _movieVector)
            {
               movie.removeEventListener("click",__onClickHandler);
               movie.state = 1;
            }
         }
         if(_loginDayNum >= 7 && _awardDayNum < 7)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _movieVector;
            for each(var accMovie in _movieVector)
            {
               accMovie.state = 2;
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
         var k:int = 0;
         var arr:* = null;
         var bagCellSp:* = null;
         var i:int = 0;
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
         k = 1;
         while(k < 8)
         {
            arr = [];
            var _loc7_:int = 0;
            var _loc6_:* = _dataDic[k];
            for each(var data in _dataDic[k])
            {
               bagCellSp = createBagCellSp(data,k);
               arr.push(bagCellSp);
            }
            _dayGiftPackDic[k] = arr;
            k++;
         }
         for(i = 0; i < _movieVector.length; )
         {
            _movieVector[i].tipData = _fiveWeaponArr[i].tipData;
            _movieVector[i].data = _dataDic[7][i];
            i++;
         }
      }
      
      private function __getAward(event:MouseEvent) : void
      {
         if(_loginDayNum >= 7 && _selectedFiveWeaponId == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulactivity.accumulativelogin.txt2"));
            return;
         }
         SocketManager.Instance.out.sendAccumulativeLoginAward(_selectedFiveWeaponId);
      }
      
      private function set selectedDay(value:int) : void
      {
         _selectedDay = value;
         if(_selectedDay > 7)
         {
            _selectedDay = 7;
         }
         _hBox.removeAllChild();
         var _loc4_:int = 0;
         var _loc3_:* = _dayGiftPackDic[_selectedDay];
         for each(var bagCellSp in _dayGiftPackDic[_selectedDay])
         {
            if(_selectedDay <= _awardDayNum)
            {
               graySp(bagCellSp);
            }
            else
            {
               bagCellSp.filters = null;
            }
            _hBox.addChild(bagCellSp);
         }
      }
      
      private function graySp(sp:Sprite) : void
      {
         sp.filters = [_filter];
      }
      
      private function get selectedDay() : int
      {
         return _selectedDay;
      }
      
      private function createBagCellSp(data:AccumulativeLoginRewardData, index:int) : Sprite
      {
         var sp:Sprite = new Sprite();
         var bagCellBg:Bitmap = ComponentFactory.Instance.creat("wonderfulactivity.login.bagCellBg");
         var _loc7_:* = 0.7;
         bagCellBg.scaleY = _loc7_;
         bagCellBg.scaleX = _loc7_;
         sp.addChild(bagCellBg);
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = data.RewardItemID;
         info = ItemManager.fill(info);
         info.IsBinds = data.IsBind;
         info.ValidDate = data.RewardItemValid;
         info.StrengthenLevel = data.StrengthenLevel;
         info.AttackCompose = data.AttackCompose;
         info.DefendCompose = data.DefendCompose;
         info.AgilityCompose = data.AgilityCompose;
         info.LuckCompose = data.LuckCompose;
         var bagCell:BagCell = new BagCell(0);
         bagCell.info = info;
         bagCell.setCount(data.RewardItemCount);
         bagCell.setBgVisible(false);
         _loc7_ = 4;
         bagCell.y = _loc7_;
         bagCell.x = _loc7_;
         sp.addChild(bagCell);
         if(index == 7)
         {
            _fiveWeaponArr.push(bagCell);
         }
         return sp;
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
         var k:int = 0;
         var sprite:* = null;
         var i:int = 0;
         AccumulativeManager.instance.removeEventListener("accumulativeLoginAwardRefresh",__refreshAward);
         var _loc10_:int = 0;
         var _loc9_:* = _dayGiftPackDic;
         for each(var bagCellArr in _dayGiftPackDic)
         {
            for(k = 0; k < bagCellArr.length; )
            {
               sprite = bagCellArr[k];
               ObjectUtils.disposeAllChildren(sprite);
               ObjectUtils.disposeObject(sprite);
               k++;
            }
         }
         _dayGiftPackDic = null;
         var _loc12_:int = 0;
         var _loc11_:* = _fiveWeaponArr;
         for each(var bCell in _fiveWeaponArr)
         {
            ObjectUtils.disposeObject(bCell);
            bCell = null;
         }
         _fiveWeaponArr = null;
         for(i = 0; i < _movieVector.length; )
         {
            _movieVector[i].removeEventListener("click",__onClickHandler);
            _movieVector[i].dispose();
            _movieVector[i] = null;
            i++;
         }
         _movieVector = null;
         var _loc14_:int = 0;
         var _loc13_:* = _progressBarItemArr;
         for each(var bitmap in _progressBarItemArr)
         {
            if(bitmap)
            {
               ObjectUtils.disposeObject(bitmap);
            }
            bitmap = null;
         }
         _progressBarItemArr = null;
         var _loc16_:int = 0;
         var _loc15_:* = _clickSpriteArr;
         for each(var sp in _clickSpriteArr)
         {
            if(sp)
            {
               sp.graphics.clear();
            }
            sp.removeEventListener("click",__showAwardHandler);
            sp = null;
         }
         _clickSpriteArr = null;
         var _loc18_:int = 0;
         var _loc17_:* = _dayTxtArr;
         for each(var txt in _dayTxtArr)
         {
            if(txt)
            {
               ObjectUtils.disposeObject(txt);
            }
            txt = null;
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
