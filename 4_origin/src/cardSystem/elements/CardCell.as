package cardSystem.elements
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import cardSystem.CardControl;
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import cardSystem.view.CardInputFrame;
   import com.greensock.TweenMax;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CardCell extends BaseCell
   {
       
      
      private var _open:Boolean;
      
      private var isVible:Boolean = true;
      
      private var _cardInfo:CardInfo;
      
      private var _playerInfo:PlayerInfo;
      
      private var _place:int;
      
      private var _cardID:int;
      
      protected var _starContainer:Sprite;
      
      protected var _levelBG:Bitmap;
      
      protected var _level:FilterFrameText;
      
      private var _starVisible:Boolean = true;
      
      private var _cardName:FilterFrameText;
      
      private var _shine:IEffect;
      
      protected var _isShine:Boolean;
      
      private var _canShine:Boolean;
      
      protected var _updateBtn:TextButton;
      
      protected var _resetGradeBtn:TextButton;
      
      protected var _mainWhiteGold:Bitmap;
      
      protected var _mainGold:ScaleFrameImage;
      
      protected var _mainsilver:ScaleFrameImage;
      
      protected var _maincopper:ScaleFrameImage;
      
      protected var _deputyWhiteGold:Bitmap;
      
      protected var _deputyGold:ScaleFrameImage;
      
      protected var _deputysilver:ScaleFrameImage;
      
      protected var _deputycopper:ScaleFrameImage;
      
      private var _tweenMax:TweenMax;
      
      public function CardCell(bg:DisplayObject, place:int = -1, $info:CardInfo = null, showLoading:Boolean = false, showTip:Boolean = true)
      {
         _place = place;
         super(bg,_cardInfo == null?null:ItemManager.Instance.getTemplateById(_cardInfo.TemplateID),showLoading,showTip);
         open = true;
         cardInfo = $info;
         setStar();
      }
      
      public function set canShine(value:Boolean) : void
      {
         _canShine = value;
      }
      
      public function get canShine() : Boolean
      {
         return _canShine;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      public function set playerInfo(value:PlayerInfo) : void
      {
         _playerInfo = value;
      }
      
      public function showCardName(name:String) : void
      {
         if(_cardName == null)
         {
            _cardName = ComponentFactory.Instance.creatComponentByStylename("CardBagCell.name");
            addChild(_cardName);
         }
         _cardName.text = name;
         _cardName.y = _bg.height / 2 - _cardName.textHeight / 2;
      }
      
      public function set cardID(value:int) : void
      {
         if(_cardID == value)
         {
            return;
         }
         _cardID = value;
      }
      
      public function get cardID() : int
      {
         return _cardID;
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         createStar();
      }
      
      public function shine() : void
      {
         if(_tweenMax != null)
         {
            TweenMax.killTweensOf(this);
            _tweenMax.kill();
            _tweenMax = null;
            filters = null;
            if(open)
            {
               open = true;
            }
            else
            {
               open = false;
            }
         }
         _tweenMax = TweenMax.to(this,0.5,{
            "repeat":-1,
            "yoyo":true,
            "glowFilter":{
               "color":16777011,
               "alpha":1,
               "blurX":8,
               "blurY":8,
               "strength":3
            }
         });
      }
      
      public function stopShine() : void
      {
         TweenMax.killTweensOf(this);
         filters = null;
         if(open)
         {
            open = true;
         }
         else
         {
            open = false;
         }
      }
      
      protected function createStar() : void
      {
         _starContainer = new Sprite();
         addChild(_starContainer);
         _mainWhiteGold = ComponentFactory.Instance.creatBitmap("asset.ddtcardSystem.mainwhitegold");
         addChild(_mainWhiteGold);
         _mainGold = ComponentFactory.Instance.creatComponentByStylename("ddtcard.cardCell.maingold");
         _mainGold.setFrame(1);
         addChild(_mainGold);
         _mainsilver = ComponentFactory.Instance.creatComponentByStylename("ddtcard.cardCell.mainsilver");
         _mainsilver.setFrame(1);
         addChild(_mainsilver);
         _maincopper = ComponentFactory.Instance.creatComponentByStylename("ddtcard.cardCell.maincopper");
         _maincopper.setFrame(1);
         addChild(_maincopper);
         var _loc1_:* = false;
         _maincopper.visible = _loc1_;
         _loc1_ = _loc1_;
         _mainsilver.visible = _loc1_;
         _loc1_ = _loc1_;
         _mainGold.visible = _loc1_;
         _mainWhiteGold.visible = _loc1_;
         _loc1_ = 0;
         _maincopper.x = _loc1_;
         _loc1_ = _loc1_;
         _mainsilver.x = _loc1_;
         _mainGold.x = _loc1_;
         _loc1_ = 1;
         _maincopper.y = _loc1_;
         _loc1_ = _loc1_;
         _mainsilver.y = _loc1_;
         _mainGold.y = _loc1_;
         _mainWhiteGold.x = 2;
         _mainWhiteGold.y = 5;
         _deputyWhiteGold = ComponentFactory.Instance.creatBitmap("asset.cardSystem.deputywhitegold");
         _deputyWhiteGold.x = 1;
         _deputyWhiteGold.y = 10;
         addChild(_deputyWhiteGold);
         _deputyGold = ComponentFactory.Instance.creatComponentByStylename("ddtcard.cardCell.deputygold");
         _deputyGold.setFrame(1);
         addChild(_deputyGold);
         _deputysilver = ComponentFactory.Instance.creatComponentByStylename("ddtcard.cardCell.deputysilver");
         _deputysilver.setFrame(1);
         addChild(_deputysilver);
         _deputycopper = ComponentFactory.Instance.creatComponentByStylename("ddtcard.cardCell.deputycopple");
         _deputycopper.setFrame(1);
         addChild(_deputycopper);
         _loc1_ = false;
         _deputycopper.visible = _loc1_;
         _loc1_ = _loc1_;
         _deputysilver.visible = _loc1_;
         _loc1_ = _loc1_;
         _deputyGold.visible = _loc1_;
         _deputyWhiteGold.visible = _loc1_;
         _updateBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcard.BtnUpdate");
         _updateBtn.text = LanguageMgr.GetTranslation("tank.view.card.Grooveupdate");
         PositionUtils.setPos(_updateBtn,"cardSystem.UpdateBtn.pos");
         addChild(_updateBtn);
         _updateBtn.addEventListener("mouseDown",_UpdateHandler);
         _resetGradeBtn = ComponentFactory.Instance.creatComponentByStylename("CardBagCell.propReset");
         _resetGradeBtn.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.reset");
         _resetGradeBtn.x = _updateBtn.x - 50;
         _resetGradeBtn.y = _updateBtn.y;
         addChild(_resetGradeBtn);
         _resetGradeBtn.addEventListener("mouseDown",__propReset);
         if(_place != 0)
         {
            _levelBG = ComponentFactory.Instance.creatBitmap("asset.cardBag.cell.smalllevelbg");
            _level = ComponentFactory.Instance.creatComponentByStylename("cardSystem.level.small");
            PositionUtils.setPos(_level,"cardSystem.level.small.pos");
            _starContainer.x = _bg.width - _levelBG.width - 3;
            _starContainer.y = _bg.height - _levelBG.height - 3;
         }
         else
         {
            _levelBG = ComponentFactory.Instance.creatBitmap("asset.cardEquipView.cell.levelBg");
            _level = ComponentFactory.Instance.creatComponentByStylename("cardSystem.level.big");
            PositionUtils.setPos(_level,"cardSystem.level.big.pos");
            PositionUtils.setPos(_updateBtn,"cardSystem.UpdateBtnOne.pos");
            _resetGradeBtn.x = _updateBtn.x - 60;
            _resetGradeBtn.y = _updateBtn.y;
            _starContainer.x = _bg.width - _levelBG.width + 13;
            _starContainer.y = _bg.height - _levelBG.height - 4;
         }
      }
      
      private function _UpdateHandler(event:MouseEvent) : void
      {
         var alert1:* = null;
         event.stopImmediatePropagation();
         if(event.currentTarget is BaseButton)
         {
            SoundManager.instance.play("008");
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(CardManager.Instance.model.GrooveInfoVector[_place].Level >= 45)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.HightLevel"));
               return;
            }
            alert1 = ComponentFactory.Instance.creatComponentByStylename("cardSystem.CardInputFrame");
            LayerManager.Instance.addToLayer(alert1,1,alert1.info.frameCenter,1);
            alert1.moveEnable = false;
            alert1.place = _place;
            event.stopPropagation();
         }
      }
      
      protected function __propReset(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         CardControl.Instance.showPropResetFrame(cardInfo);
      }
      
      public function setStarPos(posX:int, posY:int) : void
      {
         _starContainer.x = posX;
         _starContainer.y = posY;
      }
      
      public function set cardInfo(value:CardInfo) : void
      {
         var currentFrame:int = 0;
         var maxNum:int = 0;
         var _grooveinfo:GrooveInfo = new GrooveInfo();
         _cardInfo = value;
         if(_cardInfo == null)
         {
            .super.info = null;
            if(_cardName)
            {
               _cardName.visible = true;
            }
            var _loc5_:* = false;
            _maincopper.visible = _loc5_;
            _loc5_ = _loc5_;
            _mainsilver.visible = _loc5_;
            _loc5_ = _loc5_;
            _mainGold.visible = _loc5_;
            _mainWhiteGold.visible = _loc5_;
            _loc5_ = false;
            _deputycopper.visible = _loc5_;
            _loc5_ = _loc5_;
            _deputysilver.visible = _loc5_;
            _loc5_ = _loc5_;
            _deputyGold.visible = _loc5_;
            _deputyWhiteGold.visible = _loc5_;
            ShowTipManager.Instance.removeAllTip();
            _tipData = _place;
            tipStyle = "core.CardsTip";
         }
         else
         {
            .super.info = _cardInfo.templateInfo;
            if(_cardInfo.TemplateID > 0)
            {
               _pic.parent.setChildIndex(_pic,1);
            }
            if(_cardName)
            {
               _cardName.visible = false;
            }
            currentFrame = 1;
            maxNum = _cardInfo.templateInfo.Property2;
            if(_cardInfo.Attack >= maxNum && _cardInfo.Defence >= maxNum && _cardInfo.Agility >= maxNum && _cardInfo.Luck >= maxNum)
            {
               currentFrame = 2;
            }
            if(_cardInfo.CardType == 1 && _cardInfo.Place == 0)
            {
               _mainGold.visible = true;
               _mainGold.setFrame(currentFrame);
               _maincopper.visible = false;
               _mainsilver.visible = false;
               _mainWhiteGold.visible = false;
            }
            else if(_cardInfo.CardType == 2 && _cardInfo.Place == 0)
            {
               _mainsilver.visible = true;
               _mainsilver.setFrame(currentFrame);
               _maincopper.visible = false;
               _mainGold.visible = false;
               _mainWhiteGold.visible = false;
            }
            else if(_cardInfo.CardType == 3 && _cardInfo.Place == 0)
            {
               _maincopper.visible = true;
               _maincopper.setFrame(currentFrame);
               _mainGold.visible = false;
               _mainsilver.visible = false;
               _mainWhiteGold.visible = false;
            }
            if(_cardInfo.CardType == 4 && _cardInfo.Place == 0)
            {
               _mainGold.visible = false;
               _maincopper.visible = false;
               _mainsilver.visible = false;
               _mainWhiteGold.visible = true;
            }
            else if(_cardInfo.CardType == 1 && _cardInfo.Place != 0)
            {
               _deputyGold.visible = true;
               _deputyGold.setFrame(currentFrame);
               _deputycopper.visible = false;
               _deputysilver.visible = false;
               _deputyWhiteGold.visible = false;
            }
            else if(_cardInfo.CardType == 2 && _cardInfo.Place != 0)
            {
               _deputysilver.visible = true;
               _deputysilver.setFrame(currentFrame);
               _deputycopper.visible = false;
               _deputyGold.visible = false;
               _deputyWhiteGold.visible = false;
            }
            else if(_cardInfo.CardType == 3 && _cardInfo.Place != 0)
            {
               _deputycopper.visible = true;
               _deputycopper.setFrame(currentFrame);
               _deputysilver.visible = false;
               _deputyGold.visible = false;
               _deputyWhiteGold.visible = false;
            }
            else if(_cardInfo.CardType == 4 && _cardInfo.Place != 0)
            {
               _deputyGold.visible = false;
               _deputycopper.visible = false;
               _deputysilver.visible = false;
               _deputyWhiteGold.visible = true;
            }
            else
            {
               _loc5_ = false;
               _maincopper.visible = _loc5_;
               _loc5_ = _loc5_;
               _mainsilver.visible = _loc5_;
               _loc5_ = _loc5_;
               _mainGold.visible = _loc5_;
               _mainWhiteGold.visible = _loc5_;
               _loc5_ = false;
               _deputycopper.visible = _loc5_;
               _loc5_ = _loc5_;
               _deputysilver.visible = _loc5_;
               _loc5_ = _loc5_;
               _deputyGold.visible = _loc5_;
               _deputyWhiteGold.visible = _loc5_;
            }
            tipData = value;
            ShowTipManager.Instance.removeAllTip();
            tipStyle = "core.EquipmentCardsTips";
         }
         ShowTipManager.Instance.removeAllTip();
         setStar();
      }
      
      public function get cardInfo() : CardInfo
      {
         return _cardInfo;
      }
      
      public function set updatebtnVible(value:Boolean) : void
      {
         isVible = value;
      }
      
      public function get updatebtnVible() : Boolean
      {
         return isVible;
      }
      
      protected function setStar() : void
      {
         if(cardInfo == null)
         {
            _starContainer.visible = false;
            _updateBtn.visible = false;
            _resetGradeBtn.visible = false;
         }
         else
         {
            if(_starVisible)
            {
               _starContainer.visible = true;
            }
            _level.text = _cardInfo.Level < 10?"0" + _cardInfo.Level:_cardInfo.Level.toString();
         }
      }
      
      public function set starVisible(value:Boolean) : void
      {
         _starVisible = value;
         _starContainer.visible = value;
      }
      
      public function set Visibles(value:Boolean) : void
      {
         _mainWhiteGold.visible = value;
         _mainGold.visible = value;
         _mainsilver.visible = value;
         _maincopper.visible = value;
         _deputyGold.visible = value;
         _deputysilver.visible = value;
         _deputycopper.visible = value;
         _deputyWhiteGold.visible = value;
      }
      
      public function set open(value:Boolean) : void
      {
         _open = value;
         if(value)
         {
            filters = null;
            mouseEnabled = true;
         }
         else
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
            mouseEnabled = false;
         }
      }
      
      public function get open() : Boolean
      {
         return _open;
      }
      
      public function set place(value:int) : void
      {
         if(_place == value)
         {
            return;
         }
         _place = value;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      override public function dragStart() : void
      {
         if(_cardInfo && !locked && stage && allowDrag)
         {
            if(DragManager.startDrag(this,_cardInfo,createDragImg(),stage.mouseX,stage.mouseY,"move",true,false,false,true))
            {
               locked = true;
               CardManager.Instance.signLockedCard = cardInfo.TemplateID;
            }
         }
         if(_info && _pic.numChildren > 0)
         {
            dispatchEvent(new CellEvent("dragStart",this.cardInfo,true));
         }
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var cInfo:* = null;
         if(effect.data is CardInfo)
         {
            cInfo = effect.data as CardInfo;
            if(locked)
            {
               if(cInfo == cardInfo)
               {
                  locked = false;
                  DragManager.acceptDrag(this);
               }
               else
               {
                  DragManager.acceptDrag(this,"none");
               }
            }
            else
            {
               if(_place != -1)
               {
                  if(!open)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.CardCell.notOpen"));
                     effect.action = "none";
                  }
                  else if(_place == 0 && cInfo.templateInfo.Property8 == "0")
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.CardCell.cannotMoveCardMain"));
                     effect.action = "none";
                  }
                  else if(_place <= 4 && _place > 0 && cInfo.templateInfo.Property8 == "1")
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.CardCell.cannotMoveCardOther"));
                     effect.action = "none";
                  }
                  else if(_place > 4 && cInfo.Place < 5)
                  {
                     SocketManager.Instance.out.sendMoveCards(cInfo.Place,cInfo.Place);
                     effect.action = "none";
                  }
                  else
                  {
                     SocketManager.Instance.out.sendMoveCards(cInfo.Place,_place);
                     effect.action = "none";
                  }
               }
               DragManager.acceptDrag(this);
            }
         }
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new CellEvent("dragStop",null,true));
         effect.action = "none";
         locked = false;
      }
      
      override public function dispose() : void
      {
         TweenMax.killTweensOf(this);
         _cardInfo = null;
         ObjectUtils.disposeAllChildren(this);
         _starContainer = null;
         _levelBG = null;
         _cardName = null;
         _updateBtn = null;
         _resetGradeBtn = null;
         _mainGold = null;
         _mainsilver = null;
         _maincopper = null;
         _deputyGold = null;
         _deputysilver = null;
         _deputycopper = null;
         removeEvent();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         if(sp)
         {
            sp.height = _contentHeight;
            sp.width = _contentWidth;
            sp.x = (_bg.width - _contentWidth) / 2;
            sp.y = (_bg.height - _contentHeight) / 2 - 9;
         }
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
         if(open && !locked)
         {
            this.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
         if(cardInfo == null)
         {
            if(_updateBtn && _resetGradeBtn)
            {
               if(CardManager.Instance.model.PlayerId == PlayerManager.Instance.Self.ID && isVible)
               {
                  _updateBtn.visible = true;
                  _resetGradeBtn.visible = false;
               }
               else
               {
                  _updateBtn.visible = false;
                  _resetGradeBtn.visible = false;
               }
            }
         }
         else if(_updateBtn && _resetGradeBtn)
         {
            if(CardManager.Instance.model.PlayerId == PlayerManager.Instance.Self.ID && isVible)
            {
               _updateBtn.visible = true;
               _resetGradeBtn.visible = true;
            }
            else
            {
               _updateBtn.visible = false;
               _resetGradeBtn.visible = false;
            }
         }
      }
      
      public function setBtnVisible(value:Boolean) : Boolean
      {
         var _loc2_:* = value;
         _updateBtn.visible = _loc2_;
         return _loc2_;
      }
      
      override protected function onMouseClick(evt:MouseEvent) : void
      {
         if(_updateBtn)
         {
            _updateBtn.visible = false;
         }
         if(_resetGradeBtn)
         {
            _resetGradeBtn.visible = false;
         }
      }
      
      override protected function onMouseOut(evt:MouseEvent) : void
      {
         if(open && !locked)
         {
            this.filters = null;
         }
         if(_updateBtn)
         {
            _updateBtn.visible = false;
         }
         if(_resetGradeBtn)
         {
            _resetGradeBtn.visible = false;
         }
      }
      
      override protected function createDragImg() : DisplayObject
      {
         var img:* = null;
         if(_pic && _pic.width > 0 && _pic.height > 0)
         {
            img = new Bitmap(new BitmapData(_pic.width / _pic.scaleX,_pic.height / _pic.scaleY,true,0),"auto",true);
            img.bitmapData.draw(_pic);
            img.width = 103;
            img.height = 144;
            return img;
         }
         return null;
      }
   }
}
