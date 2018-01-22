package homeTemple.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import homeTemple.HomeTempleController;
   import homeTemple.event.HomeTempleEvent;
   
   public class HomeTempleLevel extends Sprite implements Disposeable
   {
       
      
      private var _primaryImmolation:BagCell;
      
      private var _highImmolation:BagCell;
      
      private var _selectCell:BagCell;
      
      private var _rockBuy:BaseButton;
      
      private var _isInjectSelect:SelectedCheckButton;
      
      private var _immolationBtn:SimpleBitmapButton;
      
      private var _progress:HomeImmolationProgressBar;
      
      private var _textValue:HomeTempleTextValue;
      
      private var _levelMovie:MovieClip;
      
      private var _currentLevelTip:Image;
      
      private var _icon1Bmp:Bitmap;
      
      private var _icon2Bmp:Bitmap;
      
      private var _nowBmp:Bitmap;
      
      private var _levelLabelBmp:Bitmap;
      
      private var _nums:N_BitmapDataNumber;
      
      private var _levelBmp:Bitmap;
      
      private var _item1Txt:FilterFrameText;
      
      private var _item2Txt:FilterFrameText;
      
      public function HomeTempleLevel()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _primaryImmolation = new BagCell(1,ItemManager.Instance.getTemplateById(11176),true);
         _primaryImmolation.scaleX = 0.7;
         _primaryImmolation.scaleY = 0.7;
         _primaryImmolation.tbxCount.alpha = 0;
         PositionUtils.setPos(_primaryImmolation,"home.temple.levle.primaryImmolationPos");
         addChild(_primaryImmolation);
         _primaryImmolation.buttonMode = true;
         _highImmolation = new BagCell(1,ItemManager.Instance.getTemplateById(11177),true);
         _highImmolation.scaleX = 0.7;
         _highImmolation.scaleY = 0.7;
         _highImmolation.tbxCount.alpha = 0;
         PositionUtils.setPos(_highImmolation,"home.temple.levle.highImmolationPos");
         addChild(_highImmolation);
         _highImmolation.buttonMode = true;
         _item1Txt = ComponentFactory.Instance.creat("homeTemple.item1.txt");
         _item1Txt.text = "000";
         addChild(_item1Txt);
         _item2Txt = ComponentFactory.Instance.creat("homeTemple.item2.txt");
         _item2Txt.text = "000";
         addChild(_item2Txt);
         setImmolationInfo();
         _rockBuy = ComponentFactory.Instance.creatComponentByStylename("home.temple.level.buyRock");
         addChild(_rockBuy);
         _isInjectSelect = ComponentFactory.Instance.creatComponentByStylename("home.temple.level.isInjectSelect");
         addChild(_isInjectSelect);
         _immolationBtn = ComponentFactory.Instance.creatComponentByStylename("home.temple.immolationBtn");
         addChild(_immolationBtn);
         _immolationBtn.enable = HomeTempleController.Instance.currentInfo.CurrentLevel < HomeTempleController.MAXLEVEL?true:false;
         _progress = ComponentFactory.Instance.creatComponentByStylename("home.temple.levelProgress");
         _progress.initProgress();
         addChild(_progress);
         _textValue = new HomeTempleTextValue();
         _textValue.x = 449;
         _textValue.y = -82;
         addChild(_textValue);
         _textValue.setPropertyValue();
         creatLevelMovie();
         _currentLevelTip = ComponentFactory.Instance.creatComponentByStylename("home.temple.currentTipBtn");
         _currentLevelTip.tipData = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.currentPropertyTxt");
         addChild(_currentLevelTip);
         _icon1Bmp = ComponentFactory.Instance.creatBitmap("asset.home.temple.icon1");
         PositionUtils.setPos(_icon1Bmp,"home.temple.icon1Pos");
         addChild(_icon1Bmp);
         _icon2Bmp = ComponentFactory.Instance.creatBitmap("asset.home.temple.icon2");
         PositionUtils.setPos(_icon2Bmp,"home.temple.icon2Pos");
         addChild(_icon2Bmp);
         _nowBmp = ComponentFactory.Instance.creatBitmap("asset.home.temple.now");
         PositionUtils.setPos(_nowBmp,"home.temple.nowPos");
         addChild(_nowBmp);
         _levelLabelBmp = ComponentFactory.Instance.creatBitmap("asset.home.temple.level");
         PositionUtils.setPos(_levelLabelBmp,"home.temple.levelLabelPos");
         addChild(_levelLabelBmp);
         _nums = new N_BitmapDataNumber();
         _nums.numList = new Vector.<BitmapData>();
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _nums.numList.push(ComponentFactory.Instance.creatBitmapData("asset.home.temple.n" + _loc1_.toString()));
            _loc1_++;
         }
         _nums.rect = new Rectangle(1,1,45,20);
         _nums.gap = -1;
         _levelBmp = new Bitmap(_nums.getNumber("0"));
         PositionUtils.setPos(_levelBmp,"home.temple.levelBmpPos");
         addChild(_levelBmp);
         setLevelText();
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__onBagUpdate);
         _rockBuy.addEventListener("click",__onBuyRockClick);
         _isInjectSelect.addEventListener("click",__onInjectSelectClick);
         if(_immolationBtn.enable)
         {
            _immolationBtn.addEventListener("click",__onImmolationClick);
            _immolationBtn.addEventListener("mouseOver",__onImmolationOver);
            _immolationBtn.addEventListener("mouseOut",__onImmolationOut);
         }
         _primaryImmolation.addEventListener("click",__onPrimaryClick);
         _highImmolation.addEventListener("click",__onHighClick);
         HomeTempleController.Instance.addEventListener("homeTempleUpdateProperty",__onUpdateProperty);
         HomeTempleController.Instance.addEventListener("homeTempleUpdateBlessingState",__onUpdateBlessingState);
      }
      
      protected function __onUpdateBlessingState(param1:HomeTempleEvent) : void
      {
         creatLevelMovie();
      }
      
      private function creatLevelMovie() : void
      {
         if(_levelMovie)
         {
            removeChild(_levelMovie);
            ObjectUtils.disposeObject(_levelMovie);
            _levelMovie = null;
         }
         var _loc1_:int = HomeTempleController.Instance.getStarNum();
         _levelMovie = ComponentFactory.Instance.creat("asset.home.temple.a00" + _loc1_);
         var _loc2_:* = 0.6;
         _levelMovie.scaleY = _loc2_;
         _levelMovie.scaleX = _loc2_;
         PositionUtils.setPos(_levelMovie,"home.temple.levle.levelPos");
         addChild(_levelMovie);
      }
      
      private function setImmolationInfo() : void
      {
         var _loc1_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11176);
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11177);
         _item1Txt.text = _loc1_.toString();
         _item2Txt.text = _loc2_.toString();
         _primaryImmolation.setCount(_loc1_);
         _highImmolation.setCount(_loc2_);
         setSelectImagePos(_loc1_ > 0?_primaryImmolation:_highImmolation);
      }
      
      private function setSelectImagePos(param1:BagCell) : void
      {
         if(_selectCell != param1)
         {
            _selectCell = param1;
         }
      }
      
      protected function __onPrimaryClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         setSelectImagePos(_primaryImmolation);
      }
      
      protected function __onHighClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         setSelectImagePos(_highImmolation);
      }
      
      protected function __onUpdateProperty(param1:HomeTempleEvent) : void
      {
         _textValue.setPropertyValue();
         var _loc2_:int = param1.data[0] < 6?param1.data[0]:5;
         var _loc3_:int = param1.data[1] < 6?param1.data[1]:5;
         playBombAnimation(_loc2_,_loc3_);
         _progress.setProgress();
         setLevelText();
         _item1Txt.text = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11176).toString();
         _item2Txt.text = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11177).toString();
         _primaryImmolation.setCount(PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11176));
         _highImmolation.setCount(PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11177));
      }
      
      private function setLevelText() : void
      {
         var _loc1_:int = HomeTempleController.Instance.getStarLevelNum();
         _levelBmp.bitmapData = _nums.getNumber(_loc1_.toString());
      }
      
      private function playBombAnimation(param1:int, param2:int) : void
      {
         min = param1;
         max = param2;
         playUpradeOver = function():void
         {
            playBombAnimation(min,max);
         };
         deleteMovie = function():void
         {
            if(contains(upgrade))
            {
               removeChild(upgrade);
            }
         };
         tweenTo = function():void
         {
            TweenLite.to(upgrade,speed / 2,{
               "y":0,
               "scaleX":0,
               "scaleY":0,
               "alpha":0,
               "onComplete":deleteMovie
            });
         };
         var speed:Number = 0.2;
         var upgrade:MovieClip = ComponentFactory.Instance.creat("home.temple.upgradeAnimation");
         if(min > 0)
         {
            min = Number(min) - 1;
            upgrade.upgradeText.text = "+150%";
            addChild(upgrade);
            TweenLite.to(upgrade,speed,{
               "y":72,
               "scaleX":1.5,
               "scaleY":1.5,
               "alpha":1,
               "onComplete":playUpradeOver
            });
         }
         else if(max > 0)
         {
            max = Number(max) - 1;
            upgrade.upgradeText.text = "+200%";
            addChild(upgrade);
            TweenLite.to(upgrade,speed,{
               "y":72,
               "scaleX":1.5,
               "scaleY":1.5,
               "alpha":1,
               "onComplete":playUpradeOver
            });
         }
      }
      
      protected function __onImmolationClick(param1:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:Boolean = false;
         if(_primaryImmolation.getCount() == 0 && _highImmolation.getCount() == 0)
         {
            _rockBuy.dispatchEvent(new MouseEvent("click"));
         }
         else
         {
            if(_primaryImmolation.getCount() > 0)
            {
               setSelectImagePos(_primaryImmolation);
            }
            else if(_highImmolation.getCount() > 0)
            {
               setSelectImagePos(_highImmolation);
            }
            else
            {
               _loc2_ = true;
               _rockBuy.dispatchEvent(new MouseEvent("click"));
            }
            if(!_loc2_)
            {
               SoundManager.instance.playButtonSound();
               SocketManager.Instance.out.setHomeTempleImmolation(_selectCell.info.TemplateID,_isInjectSelect.selected);
            }
         }
      }
      
      protected function __onImmolationOver(param1:MouseEvent) : void
      {
         _textValue.setPropertyValue(true);
      }
      
      protected function __onImmolationOut(param1:MouseEvent) : void
      {
         _textValue.setPropertyValue();
      }
      
      protected function __onInjectSelectClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      protected function __onBuyRockClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(11177,1);
         var _loc3_:QuickBuyAlertBase = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickBuyAlert");
         _loc3_.setData(_loc2_.TemplateID,_loc2_.GoodsID,_loc2_.AValue1);
         LayerManager.Instance.addToLayer(_loc3_,3,true,1);
      }
      
      protected function __onBagUpdate(param1:BagEvent) : void
      {
         _item1Txt.text = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11176).toString();
         _item2Txt.text = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11177).toString();
         _primaryImmolation.setCount(PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11176));
         _highImmolation.setCount(PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11177));
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__onBagUpdate);
         _rockBuy.removeEventListener("click",__onBuyRockClick);
         _isInjectSelect.removeEventListener("click",__onInjectSelectClick);
         _immolationBtn.removeEventListener("click",__onImmolationClick);
         _immolationBtn.removeEventListener("mouseOver",__onImmolationOver);
         _immolationBtn.removeEventListener("mouseOut",__onImmolationOut);
         _primaryImmolation.removeEventListener("click",__onPrimaryClick);
         _highImmolation.removeEventListener("click",__onHighClick);
         HomeTempleController.Instance.removeEventListener("homeTempleUpdateProperty",__onUpdateProperty);
         HomeTempleController.Instance.removeEventListener("homeTempleUpdateBlessingState",__onUpdateBlessingState);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_item1Txt);
         _item1Txt = null;
         ObjectUtils.disposeObject(_item2Txt);
         _item2Txt = null;
         ObjectUtils.disposeObject(_icon1Bmp);
         _icon1Bmp = null;
         ObjectUtils.disposeObject(_icon2Bmp);
         _icon2Bmp = null;
         ObjectUtils.disposeObject(_nowBmp);
         _nowBmp = null;
         ObjectUtils.disposeObject(_levelLabelBmp);
         _levelLabelBmp = null;
         ObjectUtils.disposeObject(_nums);
         _nums = null;
         ObjectUtils.disposeObject(_levelBmp);
         _levelBmp = null;
         ObjectUtils.disposeObject(_rockBuy);
         _rockBuy = null;
         ObjectUtils.disposeObject(_isInjectSelect);
         _isInjectSelect = null;
         ObjectUtils.disposeObject(_immolationBtn);
         _immolationBtn = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_textValue);
         _textValue = null;
         ObjectUtils.disposeObject(_levelMovie);
         _levelMovie = null;
         ObjectUtils.disposeObject(_currentLevelTip);
         _currentLevelTip = null;
      }
   }
}
