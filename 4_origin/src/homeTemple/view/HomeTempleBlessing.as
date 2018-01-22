package homeTemple.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import homeTemple.HomeTempleController;
   import homeTemple.data.HomeTempleModel;
   import homeTemple.event.HomeTempleEvent;
   
   public class HomeTempleBlessing extends Sprite implements Disposeable
   {
      
      public static var StartNum:int = 0;
       
      
      private var _bloodText:FilterFrameText;
      
      private var _defenseText:FilterFrameText;
      
      private var _attackText:FilterFrameText;
      
      private var _armorText:FilterFrameText;
      
      private var _resistanceText:FilterFrameText;
      
      private var _luckyText:FilterFrameText;
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _blessSprite:Sprite;
      
      private var _blessList:Vector.<HomeTempleBlessItem>;
      
      private var _tipBtnVec:Vector.<BaseButton>;
      
      private var _blessPosArr:Array;
      
      public function HomeTempleBlessing()
      {
         _blessPosArr = [PositionUtils.creatPoint("home.temple.bless.blessPos0"),PositionUtils.creatPoint("home.temple.bless.blessPos1"),PositionUtils.creatPoint("home.temple.bless.blessPos2"),PositionUtils.creatPoint("home.temple.bless.blessPos3"),PositionUtils.creatPoint("home.temple.bless.blessPos4"),PositionUtils.creatPoint("home.temple.bless.blessPos5")];
         super();
         _blessList = new Vector.<HomeTempleBlessItem>(6);
         _tipBtnVec = new Vector.<BaseButton>();
         StartNum = HomeTempleController.Instance.currentInfo.CurrentSelectIndex;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         this.x = -45;
         this.y = -89;
         _blessSprite = new Sprite();
         PositionUtils.setPos(_blessSprite,"home.temple.blessViewPos");
         addChild(_blessSprite);
         creatBless();
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("home.temple.leftBtn");
         addChild(_leftBtn);
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("home.temple.rightBtn");
         addChild(_rightBtn);
         _bloodText = ComponentFactory.Instance.creatComponentByStylename("home.temple.bloodText");
         addChild(_bloodText);
         _defenseText = ComponentFactory.Instance.creatComponentByStylename("home.temple.defenseText");
         addChild(_defenseText);
         _attackText = ComponentFactory.Instance.creatComponentByStylename("home.temple.attackText");
         addChild(_attackText);
         _luckyText = ComponentFactory.Instance.creatComponentByStylename("home.temple.luckyText");
         addChild(_luckyText);
         _resistanceText = ComponentFactory.Instance.creatComponentByStylename("home.temple.resistanceText");
         addChild(_resistanceText);
         _armorText = ComponentFactory.Instance.creatComponentByStylename("home.temple.armorText");
         addChild(_armorText);
         setTextInfo();
         creatTipBtn();
      }
      
      private function creatTipBtn() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("home.temple.rectTipBtn");
            _loc1_.tipData = LanguageMgr.GetTranslation("home.temple.rectTipText0");
            PositionUtils.setPos(_loc1_,"home.temple.rectTipBtnPos" + _loc2_);
            addChild(_loc1_);
            _tipBtnVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function setTextInfo() : void
      {
         var _loc1_:HomeTempleModel = HomeTempleController.Instance.getPropertyInfoByIndex(StartNum);
         _bloodText.text = LanguageMgr.GetTranslation("MaxHp") + ":" + _loc1_.Blood.toString();
         _defenseText.text = LanguageMgr.GetTranslation("defence") + ":" + _loc1_.Defence.toString();
         _attackText.text = LanguageMgr.GetTranslation("attack") + ":" + _loc1_.Attack.toString();
         _luckyText.text = LanguageMgr.GetTranslation("luck") + ":" + _loc1_.Luck.toString();
         _resistanceText.text = LanguageMgr.GetTranslation("enchant.addMagicDenfenceTxt") + _loc1_.MagicDefence.toString();
         _armorText.text = LanguageMgr.GetTranslation("recovery") + ":" + _loc1_.Guard.toString();
      }
      
      private function initEvent() : void
      {
         _leftBtn.addEventListener("click",__onLeftBtnClick);
         _rightBtn.addEventListener("click",__onRightBtnClick);
         HomeTempleController.Instance.addEventListener("homeTempleUpdateBlessingState",__onUpdateBlessingState);
      }
      
      protected function __onUpdateBlessingState(param1:HomeTempleEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            if(_loc2_ >= HomeTempleController.Instance.getStarNum())
            {
               _blessList[_loc2_].filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               _blessList[_loc2_].filters = null;
            }
            _loc2_++;
         }
         updateBlessPos();
      }
      
      private function creatBless() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc2_ = new HomeTempleBlessItem(_loc3_);
            _loc2_.blessBtn.addEventListener("click",__onBlessClick);
            _loc1_ = getPosIndex(_loc3_);
            PositionUtils.setPos(_loc2_,_blessPosArr[_loc1_]);
            var _loc4_:* = _loc1_ == 0?1.2:0.8;
            _loc2_.blessMovie.scaleY = _loc4_;
            _loc2_.blessMovie.scaleX = _loc4_;
            if(_loc3_ >= HomeTempleController.Instance.getStarNum())
            {
               _loc2_.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               _loc2_.filters = null;
            }
            _blessList[_loc3_] = _loc2_;
            _blessSprite.addChild(_blessList[_loc3_]);
            _loc3_++;
         }
      }
      
      protected function __onBlessClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _blessList.length)
         {
            if(_blessList[_loc2_].blessBtn == param1.currentTarget)
            {
               StartNum = _loc2_ + 1;
               break;
            }
            _loc2_++;
         }
         updateBlessPos();
      }
      
      public function resetBlessingPos() : void
      {
         StartNum = HomeTempleController.Instance.currentInfo.CurrentSelectIndex;
         updateBlessPos();
      }
      
      private function updateBlessPos() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:Number = NaN;
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc2_ = getPosIndex(_loc4_);
            _loc1_ = _blessPosArr[_loc2_];
            _loc3_ = _loc2_ == 0?1.2:0.8;
            TweenLite.to(_blessList[_loc4_],1,{
               "x":_loc1_.x,
               "y":_loc1_.y
            });
            TweenLite.to(_blessList[_loc4_].blessMovie,1,{
               "scaleX":_loc3_,
               "scaleY":_loc3_
            });
            _loc4_++;
         }
         setTextInfo();
         updateTipBtn();
      }
      
      private function updateTipBtn() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _tipBtnVec[_loc1_].tipData = LanguageMgr.GetTranslation("home.temple.rectTipText" + Math.max(StartNum - 1,0).toString());
            _loc1_++;
         }
      }
      
      private function getPosIndex(param1:int) : int
      {
         var _loc3_:int = StartNum == 0?1:StartNum;
         var _loc2_:int = param1 + 1 - _loc3_;
         if(_loc2_ < 0)
         {
            _loc2_ = _loc2_ + 6;
         }
         else if(_loc2_ > 5)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      protected function __onLeftBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         StartNum = Number(StartNum) - 1;
         if(StartNum < 1)
         {
            StartNum = 6;
         }
         updateBlessPos();
      }
      
      protected function __onRightBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         StartNum = Number(StartNum) + 1;
         if(StartNum > 6)
         {
            StartNum = 1;
         }
         updateBlessPos();
      }
      
      private function removeEvent() : void
      {
         _leftBtn.removeEventListener("click",__onLeftBtnClick);
         _rightBtn.removeEventListener("click",__onRightBtnClick);
         HomeTempleController.Instance.removeEventListener("homeTempleUpdateBlessingState",__onUpdateBlessingState);
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         _loc2_ = 0;
         while(_loc2_ < _blessList.length)
         {
            _blessList[_loc2_].blessBtn.removeEventListener("click",__onBlessClick);
            ObjectUtils.disposeObject(_blessList[_loc2_]);
            _blessList[_loc2_] = null;
            _loc2_++;
         }
         _blessList = null;
         _loc1_ = 0;
         while(_loc1_ < _tipBtnVec.length)
         {
            ObjectUtils.disposeObject(_tipBtnVec[_loc1_]);
            _tipBtnVec[_loc1_] = null;
            _loc1_++;
         }
         _tipBtnVec = null;
         ObjectUtils.disposeObject(_bloodText);
         _bloodText = null;
         ObjectUtils.disposeObject(_defenseText);
         _defenseText = null;
         ObjectUtils.disposeObject(_attackText);
         _attackText = null;
         ObjectUtils.disposeObject(_armorText);
         _armorText = null;
         ObjectUtils.disposeObject(_resistanceText);
         _resistanceText = null;
         ObjectUtils.disposeObject(_luckyText);
         _luckyText = null;
      }
   }
}
