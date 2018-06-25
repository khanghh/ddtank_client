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
         var i:int = 0;
         var rectTipBtn:* = null;
         for(i = 0; i < 6; )
         {
            rectTipBtn = ComponentFactory.Instance.creatComponentByStylename("home.temple.rectTipBtn");
            rectTipBtn.tipData = LanguageMgr.GetTranslation("home.temple.rectTipText0");
            PositionUtils.setPos(rectTipBtn,"home.temple.rectTipBtnPos" + i);
            addChild(rectTipBtn);
            _tipBtnVec.push(rectTipBtn);
            i++;
         }
      }
      
      private function setTextInfo() : void
      {
         var templeModel:HomeTempleModel = HomeTempleController.Instance.getPropertyInfoByIndex(StartNum);
         _bloodText.text = LanguageMgr.GetTranslation("MaxHp") + ":" + templeModel.Blood.toString();
         _defenseText.text = LanguageMgr.GetTranslation("defence") + ":" + templeModel.Defence.toString();
         _attackText.text = LanguageMgr.GetTranslation("attack") + ":" + templeModel.Attack.toString();
         _luckyText.text = LanguageMgr.GetTranslation("luck") + ":" + templeModel.Luck.toString();
         _resistanceText.text = LanguageMgr.GetTranslation("enchant.addMagicDenfenceTxt") + templeModel.MagicDefence.toString();
         _armorText.text = LanguageMgr.GetTranslation("recovery") + ":" + templeModel.Guard.toString();
      }
      
      private function initEvent() : void
      {
         _leftBtn.addEventListener("click",__onLeftBtnClick);
         _rightBtn.addEventListener("click",__onRightBtnClick);
         HomeTempleController.Instance.addEventListener("homeTempleUpdateBlessingState",__onUpdateBlessingState);
      }
      
      protected function __onUpdateBlessingState(event:HomeTempleEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < 6; )
         {
            if(i >= HomeTempleController.Instance.getStarNum())
            {
               _blessList[i].filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               _blessList[i].filters = null;
            }
            i++;
         }
         updateBlessPos();
      }
      
      private function creatBless() : void
      {
         var i:int = 0;
         var bless:* = null;
         var index:int = 0;
         for(i = 0; i < 6; )
         {
            bless = new HomeTempleBlessItem(i);
            bless.blessBtn.addEventListener("click",__onBlessClick);
            index = getPosIndex(i);
            PositionUtils.setPos(bless,_blessPosArr[index]);
            var _loc4_:* = index == 0?1.2:0.8;
            bless.blessMovie.scaleY = _loc4_;
            bless.blessMovie.scaleX = _loc4_;
            if(i >= HomeTempleController.Instance.getStarNum())
            {
               bless.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               bless.filters = null;
            }
            _blessList[i] = bless;
            _blessSprite.addChild(_blessList[i]);
            i++;
         }
      }
      
      protected function __onBlessClick(event:MouseEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < _blessList.length; )
         {
            if(_blessList[i].blessBtn == event.currentTarget)
            {
               StartNum = i + 1;
               break;
            }
            i++;
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
         var i:int = 0;
         var index:int = 0;
         var point:* = null;
         var scaleValue:Number = NaN;
         for(i = 0; i < 6; )
         {
            index = getPosIndex(i);
            point = _blessPosArr[index];
            scaleValue = index == 0?1.2:0.8;
            TweenLite.to(_blessList[i],1,{
               "x":point.x,
               "y":point.y
            });
            TweenLite.to(_blessList[i].blessMovie,1,{
               "scaleX":scaleValue,
               "scaleY":scaleValue
            });
            i++;
         }
         setTextInfo();
         updateTipBtn();
      }
      
      private function updateTipBtn() : void
      {
         var i:int = 0;
         for(i = 0; i < 6; )
         {
            _tipBtnVec[i].tipData = LanguageMgr.GetTranslation("home.temple.rectTipText" + Math.max(StartNum - 1,0).toString());
            i++;
         }
      }
      
      private function getPosIndex(i:int) : int
      {
         var num:int = StartNum == 0?1:StartNum;
         var index:int = i + 1 - num;
         if(index < 0)
         {
            index = index + 6;
         }
         else if(index > 5)
         {
            index = 0;
         }
         return index;
      }
      
      protected function __onLeftBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         StartNum = Number(StartNum) - 1;
         if(StartNum < 1)
         {
            StartNum = 6;
         }
         updateBlessPos();
      }
      
      protected function __onRightBtnClick(event:MouseEvent) : void
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
         var i:int = 0;
         var j:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         for(i = 0; i < _blessList.length; )
         {
            _blessList[i].blessBtn.removeEventListener("click",__onBlessClick);
            ObjectUtils.disposeObject(_blessList[i]);
            _blessList[i] = null;
            i++;
         }
         _blessList = null;
         for(j = 0; j < _tipBtnVec.length; )
         {
            ObjectUtils.disposeObject(_tipBtnVec[j]);
            _tipBtnVec[j] = null;
            j++;
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
