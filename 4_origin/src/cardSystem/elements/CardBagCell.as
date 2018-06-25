package cardSystem.elements
{
   import baglocked.BaglockedManager;
   import cardSystem.CardControl;
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import com.greensock.TimelineMax;
   import com.greensock.TweenLite;
   import com.greensock.events.TweenEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CardBagCell extends CardCell
   {
       
      
      private var _upGradeBtn:BaseButton;
      
      private var _buttonAndNumBG:Bitmap;
      
      private var _count:FilterFrameText;
      
      private var _timeLine:TimelineMax;
      
      private var _isMouseOver:Boolean;
      
      private var _tween0:TweenLite;
      
      private var _tween1:TweenLite;
      
      private var _tween2:TweenLite;
      
      private var _tween3:TweenLite;
      
      private var _mainCardBaiJin:Bitmap;
      
      private var _mainCardJin:Bitmap;
      
      private var _mainCardYin:Bitmap;
      
      private var _mainCardTong:Bitmap;
      
      private var _mainFont:Bitmap;
      
      private var _deputy:Bitmap;
      
      private var _collectCard:Boolean;
      
      public function CardBagCell(bg:DisplayObject, place:int = -1, $info:CardInfo = null, showLoading:Boolean = false, showTip:Boolean = true)
      {
         super(bg,place,$info,showLoading,showTip);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _mainCardBaiJin = ComponentFactory.Instance.creatBitmap("asset.ddtcardSystem.baijin");
         _mainCardJin = ComponentFactory.Instance.creatBitmap("asset.ddtcardSystem.jin");
         _mainCardYin = ComponentFactory.Instance.creatBitmap("asset.ddtcardSystem.yin");
         _mainCardTong = ComponentFactory.Instance.creatBitmap("asset.ddtcardSystem.tong");
         _mainFont = ComponentFactory.Instance.creatBitmap("asset.ddtcardSystem.mainFont");
         _deputy = ComponentFactory.Instance.creatBitmap("asset.ddtcardbag.bg");
         _buttonAndNumBG = ComponentFactory.Instance.creatBitmap("asset.cardBag.cell.buttonbg");
         _count = ComponentFactory.Instance.creatComponentByStylename("CardBagCell.count");
         addChild(_buttonAndNumBG);
         addChild(_count);
         addChild(_mainCardBaiJin);
         addChild(_mainCardJin);
         addChild(_mainCardYin);
         addChild(_mainCardTong);
         addChild(_mainFont);
         addChild(_deputy);
         if(_updateBtn)
         {
            _updateBtn.visible = false;
         }
         if(_resetGradeBtn)
         {
            PositionUtils.setPos(_resetGradeBtn,"PropResetBtnPos");
            _resetGradeBtn.visible = false;
         }
         if(_mainGold)
         {
            _mainGold.visible = false;
         }
         if(_mainsilver)
         {
            _mainsilver.visible = false;
         }
         if(_maincopper)
         {
            _maincopper.visible = false;
         }
         if(_deputyGold)
         {
            _deputyGold.visible = false;
         }
         if(_deputysilver)
         {
            _deputysilver.visible = false;
         }
         if(_deputycopper)
         {
            _deputycopper.visible = false;
         }
         if(_deputyWhiteGold)
         {
            _deputyWhiteGold.visible = false;
         }
         _mainCardBaiJin.visible = false;
         _mainCardBaiJin.x = 5;
         _mainCardBaiJin.y = 75;
         _mainCardJin.visible = false;
         _mainCardJin.x = 5;
         _mainCardJin.y = 75;
         _mainCardYin.visible = false;
         _mainCardYin.x = 5;
         _mainCardYin.y = 75;
         _mainCardTong.visible = false;
         _mainCardTong.x = 5;
         _mainCardTong.y = 75;
         _mainFont.visible = false;
         _deputy.visible = false;
         _count.alpha = 0;
         _buttonAndNumBG.alpha = 0;
         _timeLine = new TimelineMax();
         _timeLine.addEventListener("complete",__timelineComplete);
         _tween0 = new TweenLite(_starContainer,0.05,{
            "autoAlpha":0,
            "y":"5"
         });
         _timeLine.append(_tween0);
         _tween1 = new TweenLite(_buttonAndNumBG,0.1,{
            "autoAlpha":1,
            "y":"-5"
         });
         _timeLine.append(_tween1);
         _timeLine.stop();
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
         super.onMouseOver(evt);
         if(cardInfo && cardInfo.isFirstGet)
         {
            stopShine();
            if(PlayerManager.Instance.Self.cardBagDic[cardInfo.Place])
            {
               PlayerManager.Instance.Self.cardBagDic[cardInfo.Place].isFirstGet = false;
            }
         }
         if(cardInfo == null)
         {
            if(_updateBtn)
            {
               _updateBtn.visible = false;
            }
            if(_resetGradeBtn)
            {
               _resetGradeBtn.visible = false;
            }
            return;
         }
         _isMouseOver = true;
         if(_collectCard)
         {
            _resetGradeBtn.visible = false;
         }
         if(_updateBtn)
         {
            _updateBtn.visible = false;
         }
      }
      
      override protected function onMouseOut(evt:MouseEvent) : void
      {
         super.onMouseOut(evt);
         if(cardInfo == null)
         {
            return;
         }
         _isMouseOver = false;
         if(_updateBtn)
         {
            _updateBtn.visible = false;
         }
         if(_resetGradeBtn)
         {
            _resetGradeBtn.visible = false;
         }
         __timelineComplete();
      }
      
      private function __timelineComplete(event:TweenEvent = null) : void
      {
         if(_timeLine.currentTime < _timeLine.totalDuration)
         {
            return;
         }
         if(_isMouseOver || locked)
         {
            return;
         }
         _timeLine.reverse();
      }
      
      protected function __upGrade(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         CardControl.Instance.showUpGradeFrame(cardInfo);
      }
      
      override public function set cardInfo(value:CardInfo) : void
      {
         var _grooveinfo:GrooveInfo = new GrooveInfo();
         if(super.cardInfo == value && !super.cardInfo)
         {
            return;
         }
         .super.cardInfo = value;
         setStar();
         if(cardInfo)
         {
            if(cardInfo.isFirstGet && canShine)
            {
               shine();
            }
            else
            {
               stopShine();
            }
            _count.text = String(cardInfo.Count);
            if(_tween2)
            {
               _tween2.kill();
               _timeLine.remove(_tween2);
            }
            if(cardInfo.Count == 0)
            {
               _count.visible = false;
            }
            else
            {
               _count.visible = true;
               _count.alpha = 0;
               _tween2 = new TweenLite(_count,0.05,{"autoAlpha":1});
               _timeLine.append(_tween2,-0.1);
            }
            if(_tween3)
            {
               _tween3.kill();
               _timeLine.remove(_tween3);
            }
            if(cardInfo.Level >= 30)
            {
               if(_resetGradeBtn)
               {
                  _resetGradeBtn.visible = false;
               }
               if(_upGradeBtn)
               {
                  _upGradeBtn.visible = false;
               }
               if(_updateBtn)
               {
                  _updateBtn.visible = false;
               }
               if(_mainGold)
               {
                  _mainGold.visible = false;
               }
               if(_mainsilver)
               {
                  _mainsilver.visible = false;
               }
               if(_maincopper)
               {
                  _maincopper.visible = false;
               }
               if(_deputyGold)
               {
                  _deputyGold.visible = false;
               }
               if(_deputysilver)
               {
                  _deputysilver.visible = false;
               }
               if(_deputycopper)
               {
                  _deputycopper.visible = false;
               }
               if(_deputyWhiteGold)
               {
                  _deputyWhiteGold.visible = false;
               }
               _tween3 = new TweenLite(_resetGradeBtn,0.05,{"alpha":1});
               _timeLine.append(_tween3,-0.15);
               tipStyle = "core.CardsTip";
            }
            else
            {
               if(_upGradeBtn == null)
               {
                  _upGradeBtn = ComponentFactory.Instance.creatComponentByStylename("CardBagCell.upGradeBtn");
                  addChild(_upGradeBtn);
                  _upGradeBtn.alpha = 0;
                  _upGradeBtn.addEventListener("mouseDown",__upGrade);
               }
               _upGradeBtn.visible = false;
               _upGradeBtn.alpha = 0;
               if(_resetGradeBtn)
               {
                  _resetGradeBtn.visible = false;
               }
               if(_updateBtn)
               {
                  _updateBtn.visible = false;
               }
               if(_mainGold)
               {
                  _mainGold.visible = false;
               }
               if(_mainsilver)
               {
                  _mainsilver.visible = false;
               }
               if(_maincopper)
               {
                  _maincopper.visible = false;
               }
               if(_deputyGold)
               {
                  _deputyGold.visible = false;
               }
               if(_deputysilver)
               {
                  _deputysilver.visible = false;
               }
               if(_deputycopper)
               {
                  _deputycopper.visible = false;
               }
               if(_updateBtn)
               {
                  _updateBtn.visible = false;
               }
               if(_mainGold)
               {
                  _mainGold.visible = false;
               }
               if(_mainsilver)
               {
                  _mainsilver.visible = false;
               }
               if(_maincopper)
               {
                  _maincopper.visible = false;
               }
               if(_deputyGold)
               {
                  _deputyGold.visible = false;
               }
               if(_deputysilver)
               {
                  _deputysilver.visible = false;
               }
               if(_deputycopper)
               {
                  _deputycopper.visible = false;
               }
               if(_deputyWhiteGold)
               {
                  _deputyWhiteGold.visible = false;
               }
               _tween3 = new TweenLite(_upGradeBtn,0.05,{"alpha":1});
               _timeLine.append(_tween3,-0.15);
            }
            if(CardManager.Instance.signLockedCard == cardInfo.TemplateID)
            {
               locked = true;
            }
            if(cardInfo.templateInfo.Property8 == "1")
            {
               _mainFont.visible = true;
               _deputy.visible = false;
            }
            else
            {
               _mainFont.visible = false;
               _deputy.visible = true;
            }
            if(cardInfo.CardType == 1)
            {
               _mainCardJin.visible = true;
            }
            else
            {
               _mainCardJin.visible = false;
            }
            if(cardInfo.CardType == 2)
            {
               _mainCardYin.visible = true;
            }
            else
            {
               _mainCardYin.visible = false;
            }
            if(cardInfo.CardType == 3)
            {
               _mainCardTong.visible = true;
            }
            else
            {
               _mainCardTong.visible = false;
            }
            if(cardInfo.CardType == 4)
            {
               _mainCardBaiJin.visible = true;
            }
            else
            {
               _mainCardBaiJin.visible = false;
            }
         }
         else
         {
            .super.info = null;
            tipData = null;
            stopShine();
            _count.text = "";
            _timeLine.restart();
            _timeLine.stop();
            _starContainer.visible = false;
            _mainCardBaiJin.visible = false;
            _mainCardJin.visible = false;
            _mainCardYin.visible = false;
            _mainCardTong.visible = false;
            _mainFont.visible = false;
            if(_upGradeBtn)
            {
               _upGradeBtn.visible = false;
            }
            if(_updateBtn)
            {
               _updateBtn.visible = false;
            }
            if(_mainGold)
            {
               _mainGold.visible = false;
            }
            if(_mainsilver)
            {
               _mainsilver.visible = false;
            }
            if(_maincopper)
            {
               _maincopper.visible = false;
            }
            if(_deputyGold)
            {
               _deputyGold.visible = false;
            }
            if(_deputysilver)
            {
               _deputysilver.visible = false;
            }
            if(_deputycopper)
            {
               _deputycopper.visible = false;
            }
            if(_resetGradeBtn)
            {
               _resetGradeBtn.visible = false;
            }
            if(_updateBtn)
            {
               _updateBtn.visible = false;
            }
            if(_mainGold)
            {
               _mainGold.visible = false;
            }
            if(_mainsilver)
            {
               _mainsilver.visible = false;
            }
            if(_maincopper)
            {
               _maincopper.visible = false;
            }
            if(_deputyGold)
            {
               _deputyGold.visible = false;
            }
            if(_deputysilver)
            {
               _deputysilver.visible = false;
            }
            if(_deputycopper)
            {
               _deputycopper.visible = false;
            }
            if(_deputyWhiteGold)
            {
               _deputyWhiteGold.visible = false;
            }
            _count.visible = false;
            _buttonAndNumBG.visible = false;
         }
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      public function get collectCard() : Boolean
      {
         return _collectCard;
      }
      
      public function set collectCard(value:Boolean) : void
      {
         _collectCard = value;
      }
      
      override public function dispose() : void
      {
         _timeLine.removeEventListener("complete",__timelineComplete);
         if(_upGradeBtn)
         {
            _upGradeBtn.removeEventListener("mouseDown",__upGrade);
         }
         ObjectUtils.disposeObject(_upGradeBtn);
         _upGradeBtn = null;
         ObjectUtils.disposeObject(_mainCardBaiJin);
         _mainCardBaiJin = null;
         ObjectUtils.disposeObject(_mainCardJin);
         _mainCardJin = null;
         ObjectUtils.disposeObject(_mainCardTong);
         _mainCardTong = null;
         ObjectUtils.disposeObject(_mainCardYin);
         _mainCardYin = null;
         ObjectUtils.disposeObject(_mainFont);
         _mainFont = null;
         ObjectUtils.disposeObject(_mainCardJin);
         _mainCardJin = null;
         ObjectUtils.disposeObject(_mainCardTong);
         _mainCardTong = null;
         ObjectUtils.disposeObject(_mainCardYin);
         _mainCardYin = null;
         ObjectUtils.disposeObject(_mainFont);
         _mainFont = null;
         _timeLine.kill();
         _timeLine = null;
         ObjectUtils.disposeAllChildren(this);
         _count = null;
         _buttonAndNumBG = null;
         super.dispose();
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         if(sp)
         {
            sp.height = _contentHeight;
            sp.width = _contentWidth;
            sp.x = (_bg.width - _contentWidth) / 2;
            sp.y = (_bg.height - _contentHeight) / 2;
         }
      }
      
      override protected function createContentComplete() : void
      {
         clearLoading();
         updateSize(_pic);
      }
      
      override public function set locked(value:Boolean) : void
      {
         .super.locked = value;
         if(value == true)
         {
            _timeLine.restart();
            _timeLine.stop();
         }
      }
   }
}
