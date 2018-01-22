package cardSystem.view.cardEquip
{
   import baglocked.BaglockedManager;
   import cardSystem.CardControl;
   import cardSystem.CardManager;
   import cardSystem.CardTemplateInfoManager;
   import cardSystem.GrooveInfoManager;
   import cardSystem.data.CardGrooveInfo;
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import cardSystem.elements.CardCell;
   import cardSystem.view.CardPropress;
   import cardSystem.view.CardSelect;
   import cardSystem.view.CardSmallPropress;
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import trainer.view.NewHandContainer;
   
   public class CardEquipView extends Sprite implements Disposeable
   {
       
      
      private var _background:Bitmap;
      
      private var _background1:ScaleBitmapImage;
      
      private var _title:Bitmap;
      
      public var _equipCells:Vector.<CardCell>;
      
      private var _playerInfo:PlayerInfo;
      
      private var _viceCardBit:Vector.<Bitmap>;
      
      private var _mainCardBit:Bitmap;
      
      private var _clickEnable:Boolean = true;
      
      private var _cell3MouseSprite:Sprite;
      
      private var _cell4MouseSprite:Sprite;
      
      private var _open3Btn:TextButton;
      
      private var _open4Btn:TextButton;
      
      private var _dragArea:CardEquipDragArea;
      
      private var _collectBtn:TextButton;
      
      private var _resetSoulBtn:TextButton;
      
      private var _cardBtn:TextButton;
      
      private var _buyCardBoxBtn:TextButton;
      
      private var _cardList:CardSelect;
      
      private var _attackBg:Bitmap;
      
      private var _agilityBg:Bitmap;
      
      private var _defenceBg:Bitmap;
      
      private var _luckBg:Bitmap;
      
      private var _background2:MovieImage;
      
      private var _line:MovieImage;
      
      private var _textBg:Scale9CornerImage;
      
      private var _textBg1:Scale9CornerImage;
      
      private var _textBg2:Scale9CornerImage;
      
      private var _textBg3:Scale9CornerImage;
      
      private var _levelPorgress:CardPropress;
      
      private var _levelPorgress1:CardSmallPropress;
      
      private var _levelPorgress2:CardSmallPropress;
      
      private var _levelPorgress3:CardSmallPropress;
      
      private var _levelPorgress4:CardSmallPropress;
      
      private var _CardGrove:GrooveInfo;
      
      private var _HunzhiBg:Bitmap;
      
      private var _ballPlay:MovieClip;
      
      private var _ballPlaySp:Component;
      
      private var _ballPlaySpTip:OneLineTip;
      
      private var _ballPlayCountTxt:FilterFrameText;
      
      private var _levelTxt1:FilterFrameText;
      
      private var _levelTxt2:FilterFrameText;
      
      private var _levelTxt3:FilterFrameText;
      
      private var _levelTxt4:FilterFrameText;
      
      private var _levelTxt5:FilterFrameText;
      
      private var _levelNumTxt1:FilterFrameText;
      
      private var _levelNumTxt2:FilterFrameText;
      
      private var _levelNumTxt3:FilterFrameText;
      
      private var _levelNumTxt4:FilterFrameText;
      
      private var _levelNumTxt5:FilterFrameText;
      
      private var _GrooveTxt:FilterFrameText;
      
      private var _btnHelp:BaseButton;
      
      private var _quickBuyFrame:QuickBuyFrame;
      
      private var _achievementBtn:SimpleBitmapButton;
      
      private var _show3:Boolean;
      
      private var _showSelfOperation:Boolean;
      
      private var _tipsframe:BaseAlerFrame;
      
      private var _selectedCheckButton:SelectedCheckButton;
      
      private var _resetAlert:BaseAlerFrame;
      
      private var _moneyConfirm:BaseAlerFrame;
      
      private var _openFrame:BaseAlerFrame;
      
      private var _configFrame:BaseAlerFrame;
      
      public function CardEquipView()
      {
         super();
         initView();
         cardGuide();
      }
      
      public function set clickEnable(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_clickEnable == param1)
         {
            return;
         }
         _clickEnable = param1;
         if(_clickEnable)
         {
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               if(_equipCells[_loc3_])
               {
                  _equipCells[_loc3_].addEventListener("interactive_click",__clickHandler);
                  _equipCells[_loc3_].addEventListener("interactive_double_click",__doubleClickHandler);
                  _equipCells[_loc2_].setBtnVisible(true);
               }
               _loc3_++;
            }
            if(_equipCells[3].open)
            {
               _cell3MouseSprite.addEventListener("rollOver",__showOpenBtn);
               _cell3MouseSprite.addEventListener("rollOut",__hideOpenBtn);
            }
            if(_equipCells[4].open)
            {
               _cell4MouseSprite.addEventListener("rollOver",__showOpenBtn);
               _cell4MouseSprite.addEventListener("rollOut",__hideOpenBtn);
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               if(_equipCells[_loc2_])
               {
                  _equipCells[_loc2_].removeEventListener("interactive_click",__clickHandler);
                  _equipCells[_loc2_].removeEventListener("interactive_double_click",__doubleClickHandler);
               }
               _loc2_++;
            }
            if(!_equipCells[3].open)
            {
               _cell3MouseSprite.removeEventListener("rollOver",__showOpenBtn);
               _cell3MouseSprite.removeEventListener("rollOut",__hideOpenBtn);
            }
            if(!_equipCells[4].open)
            {
               _cell4MouseSprite.removeEventListener("rollOver",__showOpenBtn);
               _cell4MouseSprite.removeEventListener("rollOut",__hideOpenBtn);
            }
         }
         _collectBtn.visible = false;
         _resetSoulBtn.visible = false;
         _cardBtn.visible = false;
         _ballPlaySp.visible = false;
         _GrooveTxt.visible = false;
         _HunzhiBg.visible = false;
         _buyCardBoxBtn.visible = false;
         setCardsVisible(false);
      }
      
      private function cardGuide() : void
      {
         var _loc1_:* = null;
         if(!PlayerManager.Instance.Self.isNewOnceFinish(125))
         {
            if(PlayerManager.Instance.Self.Grade == 14 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(25)))
            {
               _loc1_ = PlayerManager.Instance.Self.cardBagDic;
               if(_loc1_.length > 0)
               {
                  NewHandContainer.Instance.showArrow(141,0,new Point(486,-107),"asset.trainer.txtCardGuide2","guide.card.txtPos2",this,0,true);
                  PlayerManager.Instance.Self.cardEquipDic.addEventListener("add",cardGuideComplete);
               }
            }
         }
      }
      
      private function cardGuideComplete(param1:DictionaryEvent) : void
      {
         PlayerManager.Instance.Self.cardEquipDic.removeEventListener("add",cardGuideComplete);
         NewHandContainer.Instance.clearArrowByID(141);
         SocketManager.Instance.out.syncWeakStep(125);
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _equipCells = new Vector.<CardCell>(5);
         _CardGrove = new GrooveInfo();
         _background = ComponentFactory.Instance.creatBitmap("asset.cardEquipView.BG");
         _background1 = ComponentFactory.Instance.creatComponentByStylename("cardEquipView.BG1");
         _background2 = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.view.bgTwo");
         _line = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.line");
         _dragArea = new CardEquipDragArea(this);
         _collectBtn = ComponentFactory.Instance.creatComponentByStylename("CardBagView.collectBtn");
         _collectBtn.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsRecordText");
         _resetSoulBtn = ComponentFactory.Instance.creatComponentByStylename("CardBagView.resetSoulBtn");
         _resetSoulBtn.text = LanguageMgr.GetTranslation("ddt.cardSystem.resetCardSoul");
         _cardBtn = ComponentFactory.Instance.creatComponentByStylename("CardBagView.CardBtn");
         _cardBtn.text = LanguageMgr.GetTranslation("ddt.cardSystem.CardsText");
         _buyCardBoxBtn = ComponentFactory.Instance.creatComponentByStylename("CardBagView.BuyCardBoxBtn");
         _buyCardBoxBtn.text = LanguageMgr.GetTranslation("ddt.cardSystem.BuyCardBox");
         _textBg = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystemTextView1");
         _textBg1 = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystemTextView2");
         _textBg2 = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystemTextView3");
         _textBg3 = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystemTextView4");
         _attackBg = ComponentFactory.Instance.creatBitmap("asset.playerinfo.gongji");
         _agilityBg = ComponentFactory.Instance.creatBitmap("asset.playerinfo.minjie");
         _defenceBg = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fangyu");
         _luckBg = ComponentFactory.Instance.creatBitmap("asset.playerinfo.luck");
         _HunzhiBg = ComponentFactory.Instance.creatBitmap("asset.ddtcardsytems.hunzhi");
         _levelTxt1 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelText1");
         _levelTxt2 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelText2");
         _levelTxt3 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelText3");
         _levelTxt4 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelText4");
         _levelTxt5 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelText5");
         _levelNumTxt1 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelNumerText1");
         _levelNumTxt2 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelNumerText2");
         _levelNumTxt3 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelNumerText3");
         _levelNumTxt4 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelNumerText4");
         _levelNumTxt5 = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelNumerText5");
         _achievementBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcard.achievementBtn");
         _achievementBtn.addEventListener("click",__onClickAchievement);
         __onUpdateProperty(null);
         PlayerManager.Instance.addEventListener("updatePlayerState",__onUpdateProperty);
         _GrooveTxt = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.GrooveText");
         _GrooveTxt.text = PlayerManager.Instance.Self.CardSoul.toString();
         if(CardManager.Instance.isPlayerInfoFrameOpen == false)
         {
            _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"cardSystem.texpSystem.btnHelp",{
               "x":624,
               "y":-164
            },LanguageMgr.GetTranslation("cardSystem.view.TexpView.helpTitle"),"cardSystem.help.content",408,488);
         }
         var _loc4_:* = LanguageMgr.GetTranslation("ddt.cardSystem.CardEquipView.levelText");
         _levelTxt5.text = _loc4_;
         _loc4_ = _loc4_;
         _levelTxt4.text = _loc4_;
         _loc4_ = _loc4_;
         _levelTxt3.text = _loc4_;
         _loc4_ = _loc4_;
         _levelTxt2.text = _loc4_;
         _levelTxt1.text = _loc4_;
         _loc4_ = "0";
         _levelNumTxt5.text = _loc4_;
         _loc4_ = _loc4_;
         _levelNumTxt4.text = _loc4_;
         _loc4_ = _loc4_;
         _levelNumTxt3.text = _loc4_;
         _loc4_ = _loc4_;
         _levelNumTxt2.text = _loc4_;
         _levelNumTxt1.text = _loc4_;
         if(!_ballPlay)
         {
            _ballPlay = ComponentFactory.Instance.creat("asset.cardSystem.ballPlay");
         }
         _ballPlayCountTxt = ComponentFactory.Instance.creatComponentByStylename("cardSystem.ballPlayCountTxt");
         _ballPlayCountTxt.text = PlayerManager.Instance.Self.GetSoulCount.toString();
         _ballPlaySp = new Component();
         _ballPlaySpTip = new OneLineTip();
         PositionUtils.setPos(_ballPlaySpTip,"cardSystem.ballPlaySpTipPos");
         _ballPlaySpTip.tipData = LanguageMgr.GetTranslation("ddt.cardSystem.buyCardSoulButtonTipsMsg");
         _ballPlaySp.buttonMode = true;
         _ballPlaySp.addEventListener("rollOver",__ballPlaySpMouseOver);
         _ballPlaySp.addEventListener("rollOut",__ballPlaySpMouseOut);
         _ballPlaySp.addChild(_ballPlay);
         _ballPlaySp.addChild(_ballPlayCountTxt);
         _HunzhiBg.x = 109;
         _HunzhiBg.y = 135;
         _attackBg.x = -9;
         _attackBg.y = 311;
         _agilityBg.x = 104;
         _agilityBg.y = 315;
         _defenceBg.x = -9;
         _defenceBg.y = 338;
         _luckBg.x = 104;
         _luckBg.y = 343;
         addChild(_background);
         addChild(_background1);
         addChild(_background2);
         addChild(_line);
         addChild(_dragArea);
         addChild(_collectBtn);
         addChild(_resetSoulBtn);
         addChild(_cardBtn);
         addChild(_buyCardBoxBtn);
         addChild(_textBg);
         addChild(_textBg1);
         addChild(_textBg2);
         addChild(_textBg3);
         addChild(_attackBg);
         addChild(_agilityBg);
         addChild(_defenceBg);
         addChild(_luckBg);
         addChild(_HunzhiBg);
         addChild(_ballPlay);
         addChild(_achievementBtn);
         _cardList = new CardSelect();
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            if(_loc3_ == 0)
            {
               _loc1_ = new CardCell(ComponentFactory.Instance.creatBitmap("asset.cardEquipView.mainCard"),_loc3_);
               _loc1_.setContentSize(110,155);
               _loc1_.setStarPos(59,154);
               _levelPorgress = ComponentFactory.Instance.creatComponentByStylename("CardEquipView.levelProgress");
            }
            else
            {
               _loc1_ = new CardCell(ComponentFactory.Instance.creatComponentByStylename("CardEquipView.viceCardBG" + _loc3_),_loc3_);
               _loc1_.setContentSize(94,133);
               _levelPorgress1 = ComponentFactory.Instance.creatComponentByStylename("CardEquipView.levelProgress1");
               _levelPorgress2 = ComponentFactory.Instance.creatComponentByStylename("CardEquipView.levelProgress2");
               _levelPorgress3 = ComponentFactory.Instance.creatComponentByStylename("CardEquipView.levelProgress3");
               _levelPorgress4 = ComponentFactory.Instance.creatComponentByStylename("CardEquipView.levelProgress4");
            }
            if(_clickEnable)
            {
               _loc1_.addEventListener("interactive_click",__clickHandler);
               _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            }
            _loc1_.addEventListener("mouseOver",_cellOverEff);
            _loc1_.addEventListener("mouseOut",_cellOutEff);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _equipCells[_loc3_] = _loc1_;
            addChild(_loc1_);
            _loc3_++;
         }
         _viceCardBit = new Vector.<Bitmap>(4);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _viceCardBit[_loc2_] = ComponentFactory.Instance.creatBitmap("asset.cardEquipView.viceCardBG");
            _loc2_++;
         }
         _mainCardBit = ComponentFactory.Instance.creatBitmap("asset.cardEquipView.mainCardBorder");
         setCellPos();
         addChild(_levelPorgress);
         addChild(_levelPorgress1);
         addChild(_levelPorgress2);
         addChild(_levelPorgress3);
         addChild(_levelPorgress4);
         addChild(_levelTxt1);
         addChild(_levelTxt2);
         addChild(_levelTxt3);
         addChild(_levelTxt4);
         addChild(_levelTxt5);
         addChild(_levelNumTxt1);
         addChild(_levelNumTxt2);
         addChild(_levelNumTxt3);
         addChild(_levelNumTxt4);
         addChild(_levelNumTxt5);
         addChild(_GrooveTxt);
         addChild(_ballPlaySp);
         _ballPlaySp.x = 160;
         _ballPlaySp.y = 107;
         addChild(_ballPlaySpTip);
         isBallPlaySpTip();
      }
      
      private function setCardsVisible(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _equipCells;
         for each(var _loc2_ in _equipCells)
         {
            if(_loc2_)
            {
               _loc2_.updatebtnVible = param1;
            }
         }
      }
      
      private function __ballPlaySpMouseOver(param1:MouseEvent) : void
      {
         _ballPlaySpTip.visible = true;
      }
      
      private function __ballPlaySpMouseOut(param1:MouseEvent) : void
      {
         isBallPlaySpTip();
      }
      
      private function isBallPlaySpTip() : void
      {
         _ballPlaySpTip.visible = false;
         if(playerInfo && playerInfo.ID == PlayerManager.Instance.Self.ID && PlayerManager.Instance.Self.GetSoulCount > 0)
         {
            _ballPlaySpTip.visible = true;
            if(PlayerManager.Instance.Self.GetSoulCount > 0)
            {
               _ballPlaySpTip.visible = true;
            }
            if(PlayerManager.Instance.Self.isViewOther)
            {
               _ballPlaySpTip.visible = false;
            }
         }
         if(PlayerManager.Instance.Self.isViewOther)
         {
            _ballPlaySpTip.visible = false;
         }
      }
      
      protected function __onUpdateProperty(param1:Event) : void
      {
         var _loc2_:PlayerInfo = _playerInfo;
         if(_playerInfo == null || _loc2_.propertyAddition == null)
         {
            return;
         }
      }
      
      private function createSprite(param1:CardCell) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16777215,0);
         _loc2_.graphics.drawRect(0,0,param1.width,param1.height);
         _loc2_.graphics.endFill();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.addEventListener("rollOver",__showOpenBtn);
         _loc2_.addEventListener("rollOut",__hideOpenBtn);
         return _loc2_;
      }
      
      private function removeSprite(param1:Sprite, param2:BaseButton) : void
      {
         if(param1)
         {
            param1.removeEventListener("rollOver",__showOpenBtn);
            param1.removeEventListener("rollOut",__hideOpenBtn);
            param2.removeEventListener("click",_openHandler);
            ObjectUtils.disposeObject(param1);
            ObjectUtils.disposeObject(param2);
         }
         param1 = null;
         param2 = null;
      }
      
      private function __showOpenBtn(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = param1.currentTarget as Sprite;
         if(_loc2_ == _cell3MouseSprite)
         {
            _show3 = true;
            TweenLite.to(_open3Btn,0.25,{
               "autoAlpha":1,
               "ease":Quad.easeOut
            });
         }
         else
         {
            _show3 = false;
            TweenLite.to(_open4Btn,0.25,{
               "autoAlpha":1,
               "ease":Quad.easeOut
            });
         }
      }
      
      private function __hideOpenBtn(param1:MouseEvent) : void
      {
         if(_show3)
         {
            TweenLite.to(_open3Btn,0.25,{
               "autoAlpha":0,
               "ease":Quad.easeOut
            });
         }
         else
         {
            TweenLite.to(_open4Btn,0.25,{
               "autoAlpha":0,
               "ease":Quad.easeOut
            });
         }
      }
      
      public function shineMain() : void
      {
         _equipCells[0].shine();
      }
      
      public function shineVice() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ < 5)
         {
            if(_equipCells[_loc1_].open)
            {
               _equipCells[_loc1_].shine();
            }
            _loc1_++;
         }
      }
      
      public function stopShine() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _equipCells[_loc1_].stopShine();
            _loc1_++;
         }
      }
      
      public function set playerInfo(param1:PlayerInfo) : void
      {
         if(_playerInfo == param1)
         {
            return;
         }
         _playerInfo = param1;
         initEvent();
         setCellsData();
         __onUpdateProperty(null);
         checkAchievementBtn();
      }
      
      public function get showSelfOperation() : Boolean
      {
         return _showSelfOperation;
      }
      
      public function set showSelfOperation(param1:Boolean) : void
      {
         _showSelfOperation = param1;
         checkAchievementBtn();
      }
      
      private function checkAchievementBtn() : void
      {
         if(!_showSelfOperation || _playerInfo == null || _playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            _achievementBtn.visible = false;
         }
         else
         {
            _achievementBtn.visible = true;
         }
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      private function setCellsData() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = playerInfo.cardEquipDic;
         for each(var _loc1_ in playerInfo.cardEquipDic)
         {
            if(_loc1_.Count <= -1)
            {
               _equipCells[_loc1_.Place].cardInfo = null;
            }
            else
            {
               _equipCells[_loc1_.Place].cardInfo = _loc1_;
            }
         }
      }
      
      private function setCellPos() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            PositionUtils.setPos(_equipCells[_loc2_],"CardCell.Pos" + _loc2_);
            _loc2_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            PositionUtils.setPos(_viceCardBit[_loc1_],"CardCell.viceBorder.Pos" + _loc1_);
            _loc1_++;
         }
         PositionUtils.setPos(_mainCardBit,"CardCell.mainBorder.Pos");
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(170),__GetCard);
         PlayerManager.Instance.Self.addEventListener("propertychange",__changeSoul);
         playerInfo.cardEquipDic.addEventListener("add",__upData);
         playerInfo.cardEquipDic.addEventListener("update",__upData);
         playerInfo.cardEquipDic.addEventListener("remove",__remove);
         _collectBtn.addEventListener("click",__collectHandler);
         _resetSoulBtn.addEventListener("click",__resetSoulHandler);
         _cardBtn.addEventListener("click",__cardHandler);
         _buyCardBoxBtn.addEventListener("click",__buyCardBoxHandler);
         _ballPlaySp.addEventListener("click",__ballPlaySpClickHandler);
         SocketManager.Instance.addEventListener("cards_soul",__getSoul);
      }
      
      private function __ballPlaySpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < ServerConfigManager.instance.buyCardSoulValueMoney)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(CardTemplateInfoManager.instance.isShowBuyFrameSelectedCheck)
         {
            showBuyCardSoulTips();
         }
         else
         {
            if(PlayerManager.Instance.Self.GetSoulCount != 0)
            {
               CardTemplateInfoManager.instance.isBuyCardsSoul = true;
            }
            CardTemplateInfoManager.instance.isBuyCardsSoul = true;
            SocketManager.Instance.out.sendGetCardSoul();
         }
      }
      
      private function showBuyCardSoulTips() : void
      {
         var _loc1_:Number = ServerConfigManager.instance.buyCardSoulValueMoney;
         _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.cardSystem.getCardSoulMoneyMsg",_loc1_),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         _selectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("cardSystem.buyFrameSelectedCheckButton");
         _selectedCheckButton.text = LanguageMgr.GetTranslation("ddt.cardSystem.buyFrameSelectedCheckButtonTextMsg");
         _selectedCheckButton.addEventListener("click",__onselectedCheckButtoClick);
         _tipsframe.addToContent(_selectedCheckButton);
         _tipsframe.addEventListener("response",__onResponse);
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         tipsDispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.GetSoulCount != 0)
            {
               CardTemplateInfoManager.instance.isBuyCardsSoul = true;
            }
            SocketManager.Instance.out.sendGetCardSoul();
         }
      }
      
      private function tipsDispose() : void
      {
         if(_selectedCheckButton)
         {
            _selectedCheckButton.removeEventListener("click",__onselectedCheckButtoClick);
            ObjectUtils.disposeObject(_selectedCheckButton);
            _selectedCheckButton = null;
         }
         if(_tipsframe)
         {
            _tipsframe.removeEventListener("response",__onResponse);
            ObjectUtils.disposeAllChildren(_tipsframe);
            ObjectUtils.disposeObject(_tipsframe);
            _tipsframe = null;
         }
      }
      
      private function __onselectedCheckButtoClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         CardTemplateInfoManager.instance.isShowBuyFrameSelectedCheck = !_selectedCheckButton.selected;
      }
      
      protected function __buyCardBoxHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(112150,1);
         var _loc3_:QuickBuyAlertBase = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickBuyAlert");
         _loc3_.setData(_loc2_.TemplateID,_loc2_.GoodsID,_loc2_.AValue1);
         LayerManager.Instance.addToLayer(_loc3_,3,true,1);
      }
      
      private function __changeSoul(param1:PlayerPropertyEvent) : void
      {
         _GrooveTxt.text = PlayerManager.Instance.Self.CardSoul.toString();
         _ballPlayCountTxt.text = PlayerManager.Instance.Self.GetSoulCount.toString();
         isBallPlaySpTip();
      }
      
      private function __getSoul(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = 0;
         if(!CardTemplateInfoManager.instance.isBuyCardsSoul)
         {
            return;
         }
         CardTemplateInfoManager.instance.isBuyCardsSoul = false;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         if(_loc2_)
         {
            _loc4_ = _loc3_.readInt();
            PlayerManager.Instance.Self.CardSoul = PlayerManager.Instance.Self.CardSoul + _loc4_;
            PlayerManager.Instance.Self.GetSoulCount = _loc3_.readInt();
         }
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(170),__GetCard);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__changeSoul);
         playerInfo.cardEquipDic.removeEventListener("add",__upData);
         playerInfo.cardEquipDic.removeEventListener("update",__upData);
         playerInfo.cardEquipDic.removeEventListener("remove",__remove);
         _collectBtn.removeEventListener("click",__collectHandler);
         _resetSoulBtn.removeEventListener("click",__resetSoulHandler);
         _cardBtn.removeEventListener("click",__cardHandler);
         _buyCardBoxBtn.removeEventListener("click",__buyCardBoxHandler);
      }
      
      private function __GetCard(param1:PkgEvent) : void
      {
         var _loc11_:int = 0;
         var _loc10_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:PackageIn = param1.pkg;
         CardManager.Instance.model.PlayerId = _loc8_.readInt();
         var _loc12_:int = _loc8_.readInt();
         var _loc3_:int = _loc8_.readInt();
         var _loc9_:int = _loc8_.readInt();
         var _loc4_:Vector.<GrooveInfo> = null;
         if(CardManager.Instance.model.GrooveInfoVector)
         {
            _loc4_ = CardManager.Instance.model.GrooveInfoVector;
         }
         else
         {
            _loc4_ = new Vector.<GrooveInfo>(5);
         }
         _loc11_ = 0;
         while(_loc11_ < _loc9_)
         {
            _loc10_ = new GrooveInfo();
            _loc10_.Place = _loc8_.readInt();
            _loc10_.Type = _loc8_.readInt();
            _loc10_.Level = _loc8_.readInt();
            _loc10_.GP = _loc8_.readInt();
            _loc6_ = GrooveInfoManager.instance.getInfoByLevel(String(_loc10_.Level),String(_loc10_.Type));
            _loc5_ = GrooveInfoManager.instance.getInfoByLevel(String(_loc10_.Level + 1),String(_loc10_.Type));
            if(_loc9_ == 1)
            {
               if(_loc10_.Level > _loc4_[_loc10_.Place].Level)
               {
                  if(_loc10_.Place == 0)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.MainUpdateCard",String(_loc10_.Level)));
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.UpdateCard",String(_loc10_.Place),String(_loc10_.Level)));
                  }
               }
            }
            if(_loc10_.Level == 45)
            {
               if(_loc10_.Place == 0)
               {
                  _levelNumTxt1.text = _loc10_.Level.toString();
                  _levelPorgress.setProgress(0,0);
                  _levelPorgress.labelText = "0%";
                  _loc4_[0] = _loc10_;
               }
               else if(_loc10_.Place == 1)
               {
                  _levelNumTxt2.text = _loc10_.Level.toString();
                  _levelPorgress1.setProgress(0,0);
                  _levelPorgress1.labelText = "0%";
                  _loc4_[1] = _loc10_;
               }
               else if(_loc10_.Place == 2)
               {
                  _levelNumTxt3.text = _loc10_.Level.toString();
                  _levelPorgress2.setProgress(0,0);
                  _levelPorgress2.labelText = "0%";
                  _loc4_[2] = _loc10_;
               }
               else if(_loc10_.Place == 3)
               {
                  _levelNumTxt4.text = _loc10_.Level.toString();
                  _levelPorgress3.setProgress(0,0);
                  _levelPorgress3.labelText = "0%";
                  _loc4_[3] = _loc10_;
               }
               if(_loc10_.Place == 4)
               {
                  _levelNumTxt5.text = _loc10_.Level.toString();
                  _levelPorgress4.setProgress(0,0);
                  _levelPorgress4.labelText = "0%";
                  _loc4_[4] = _loc10_;
               }
            }
            else
            {
               _loc7_ = _loc10_.GP - int(_loc6_.Exp);
               _loc2_ = int(_loc5_.Exp) - int(_loc6_.Exp);
               if(_loc7_ >= _loc2_)
               {
                  if(_playerInfo)
                  {
                     if(_playerInfo.ID == PlayerManager.Instance.Self.ID)
                     {
                        SocketManager.Instance.out.sendUpdateSLOT(_loc10_.Place,0);
                     }
                  }
               }
               if(_loc10_.Place == 0)
               {
                  _levelNumTxt1.text = _loc10_.Level.toString();
                  if(_loc10_.GP == 0)
                  {
                     _levelPorgress.setProgress(0,Number(_loc2_));
                  }
                  else
                  {
                     _levelPorgress.setProgress(_loc7_,Number(_loc2_));
                  }
                  _loc4_[0] = _loc10_;
               }
               if(_loc10_.Place == 1)
               {
                  _levelNumTxt2.text = _loc10_.Level.toString();
                  if(_loc10_.GP == 0)
                  {
                     _levelPorgress1.setProgress(0,Number(_loc2_));
                  }
                  else
                  {
                     _levelPorgress1.setProgress(_loc7_,Number(_loc2_));
                  }
                  _loc4_[1] = _loc10_;
               }
               if(_loc10_.Place == 2)
               {
                  _levelNumTxt3.text = _loc10_.Level.toString();
                  if(_loc10_.GP == 0)
                  {
                     _levelPorgress2.setProgress(0,Number(_loc2_));
                  }
                  else
                  {
                     _levelPorgress2.setProgress(_loc7_,Number(_loc2_));
                  }
                  _loc4_[2] = _loc10_;
               }
               if(_loc10_.Place == 3)
               {
                  _levelNumTxt4.text = _loc10_.Level.toString();
                  if(_loc10_.GP == 0)
                  {
                     _levelPorgress3.setProgress(0,Number(_loc2_));
                  }
                  else
                  {
                     _levelPorgress3.setProgress(_loc7_,Number(_loc2_));
                  }
                  _loc4_[3] = _loc10_;
               }
               if(_loc10_.Place == 4)
               {
                  _levelNumTxt5.text = _loc10_.Level.toString();
                  if(_loc10_.GP == 0)
                  {
                     _levelPorgress4.setProgress(0,Number(_loc2_));
                  }
                  else
                  {
                     _levelPorgress4.setProgress(_loc7_,Number(_loc2_));
                  }
                  _loc4_[4] = _loc10_;
               }
            }
            _loc11_++;
         }
         CardManager.Instance.model.GrooveInfoVector = _loc4_;
         PlayerManager.Instance.Self.CardSoul = _loc3_;
      }
      
      private function __collectHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CardControl.Instance.showCollectView();
      }
      
      private function __resetSoulHandler(param1:MouseEvent) : void
      {
         var _loc7_:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:Vector.<GrooveInfo> = CardManager.Instance.model.GrooveInfoVector;
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc6_ = _loc6_ + _loc3_[_loc7_].GP;
            _loc7_++;
         }
         if(_loc6_ <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.resetCardSoulNo"));
            return;
         }
         var _loc5_:String = LanguageMgr.GetTranslation("tank.view.card.resetCardSoulText1");
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("CardSystem.resetCardSoul.alertText");
         var _loc4_:String = ServerConfigManager.instance.cardResetCardSoulMoney;
         _loc2_.htmlText = LanguageMgr.GetTranslation("tank.view.card.resetCardSoulText2",_loc6_,_loc4_);
         _resetAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc5_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,1,-11);
         _resetAlert.height = 210;
         _resetAlert.containerY = 73;
         _resetAlert.addChild(_loc2_);
         _resetAlert.mouseEnabled = false;
         _resetAlert.addEventListener("response",__resetAlertResponse);
      }
      
      private function __resetAlertResponse(param1:FrameEvent) : void
      {
         if(_resetAlert.hasEventListener("response"))
         {
            _resetAlert.removeEventListener("response",__resetAlertResponse);
         }
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               break;
            case 2:
            case 3:
            case 4:
               CheckMoneyUtils.instance.checkMoney(_resetAlert.isBand,int(ServerConfigManager.instance.cardResetCardSoulMoney),onCheckComplete);
         }
         if(_resetAlert)
         {
            _resetAlert.dispose();
         }
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendResetCardSoul(CheckMoneyUtils.instance.isBind);
         __resetAllText();
      }
      
      private function __moneyConfirmHandler(param1:FrameEvent) : void
      {
         _moneyConfirm.removeEventListener("response",__moneyConfirmHandler);
         _moneyConfirm.dispose();
         _moneyConfirm = null;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               LeavePageManager.leaveToFillPath();
         }
      }
      
      private function __resetAllText() : void
      {
         _levelNumTxt1.text = "0";
         _levelPorgress.setProgress(0,0);
         _levelPorgress.labelText = "0%";
         _levelNumTxt2.text = "0";
         _levelPorgress1.setProgress(0,0);
         _levelPorgress1.labelText = "0%";
         _levelNumTxt3.text = "0";
         _levelPorgress2.setProgress(0,0);
         _levelPorgress2.labelText = "0%";
         _levelNumTxt4.text = "0";
         _levelPorgress3.setProgress(0,0);
         _levelPorgress3.labelText = "0%";
         _levelNumTxt5.text = "0";
         _levelPorgress4.setProgress(0,0);
         _levelPorgress4.labelText = "0%";
         _GrooveTxt.text = PlayerManager.Instance.Self.CardSoul.toString();
         _ballPlayCountTxt.text = PlayerManager.Instance.Self.GetSoulCount.toString();
      }
      
      private function __cardHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Point = _cardBtn.localToGlobal(new Point(0,0));
         _cardList.x = _loc2_.x + _cardBtn.width;
         _cardList.y = 440;
         _cardList.setVisible = true;
      }
      
      private function _openHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:String = !!_show3?LanguageMgr.GetTranslation("ddt.cardSystem.cardEquip.openVice3"):LanguageMgr.GetTranslation("ddt.cardSystem.cardEquip.openVice4");
         var _loc2_:String = !!_show3?LanguageMgr.GetTranslation("ddt.cardSystem.cardEquip.open3"):LanguageMgr.GetTranslation("ddt.cardSystem.cardEquip.open4");
         _openFrame = AlertManager.Instance.simpleAlert(_loc3_,_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1);
         _openFrame.addEventListener("response",__openFramehandler);
      }
      
      private function __openFramehandler(param1:FrameEvent) : void
      {
         _openFrame.removeEventListener("response",__openFramehandler);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               openActive();
         }
         _openFrame.dispose();
         _openFrame = null;
      }
      
      private function openActive() : void
      {
         var _loc1_:* = null;
         if(_show3 && CardManager.Instance.model.fourIsOpen() || !_show3 && (CardManager.Instance.model.fiveIsOpen() || CardManager.Instance.model.fiveIsOpen2()))
         {
            if(_show3)
            {
               _equipCells[3].open = true;
               SocketManager.Instance.out.sendOpenViceCard(3);
               removeSprite(_cell3MouseSprite,_open3Btn);
            }
            else
            {
               _equipCells[4].open = true;
               SocketManager.Instance.out.sendOpenViceCard(4);
               removeSprite(_cell4MouseSprite,_open4Btn);
            }
         }
         else
         {
            _loc1_ = !!_show3?LanguageMgr.GetTranslation("ddt.cardSystem.cardEquip.cannotOpen3"):LanguageMgr.GetTranslation("ddt.cardSystem.cardEquip.cannotOpen4");
            _configFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc1_,LanguageMgr.GetTranslation("ok"),"",false,false,true,1);
            _configFrame.addEventListener("response",__configResponseHandler);
         }
      }
      
      private function __configResponseHandler(param1:FrameEvent) : void
      {
         _configFrame.removeEventListener("response",__configResponseHandler);
         _configFrame.dispose();
         _configFrame = null;
      }
      
      private function __remove(param1:DictionaryEvent) : void
      {
         var _loc2_:CardInfo = param1.data as CardInfo;
         if(_equipCells[_loc2_.Place])
         {
            _equipCells[_loc2_.Place].cardInfo = null;
         }
      }
      
      private function __upData(param1:DictionaryEvent) : void
      {
         var _loc2_:CardInfo = param1.data as CardInfo;
         if(_loc2_ && _equipCells[_loc2_.Place])
         {
            if(_loc2_.Count <= -1)
            {
               _equipCells[_loc2_.Place].cardInfo = null;
            }
            else
            {
               _equipCells[_loc2_.Place].cardInfo = _loc2_;
               _equipCells[_loc2_.Place].playerInfo = _playerInfo;
            }
         }
      }
      
      private function __onClickAchievement(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         CardControl.Instance.showCardAchievementFrame();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         PlayerManager.Instance.Self.isViewOther = false;
         SocketManager.Instance.removeEventListener("cards_soul",__getSoul);
         TweenLite.killTweensOf(_open3Btn);
         TweenLite.killTweensOf(_open4Btn);
         removeEvent();
         removeSprite(_cell3MouseSprite,_open3Btn);
         removeSprite(_cell4MouseSprite,_open4Btn);
         _cell3MouseSprite = null;
         _cell3MouseSprite = null;
         _open3Btn = null;
         _open4Btn = null;
         _playerInfo = null;
         if(_dragArea)
         {
            _dragArea.dispose();
         }
         _dragArea = null;
         if(_background)
         {
            ObjectUtils.disposeObject(_background);
         }
         _background = null;
         if(_background1)
         {
            ObjectUtils.disposeObject(_background1);
         }
         _background1 = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_mainCardBit)
         {
            ObjectUtils.disposeObject(_mainCardBit);
         }
         _mainCardBit = null;
         if(_collectBtn)
         {
            ObjectUtils.disposeObject(_collectBtn);
         }
         _collectBtn = null;
         if(_resetSoulBtn)
         {
            ObjectUtils.disposeObject(_resetSoulBtn);
         }
         _resetSoulBtn = null;
         if(_cardBtn)
         {
            ObjectUtils.disposeObject(_cardBtn);
         }
         _cardBtn = null;
         if(_buyCardBoxBtn)
         {
            ObjectUtils.disposeObject(_buyCardBoxBtn);
         }
         _buyCardBoxBtn = null;
         if(_btnHelp)
         {
            ObjectUtils.disposeObject(_btnHelp);
         }
         _btnHelp = null;
         if(_textBg)
         {
            ObjectUtils.disposeObject(_textBg);
         }
         _textBg = null;
         if(_textBg1)
         {
            ObjectUtils.disposeObject(_textBg1);
         }
         _textBg1 = null;
         if(_textBg2)
         {
            ObjectUtils.disposeObject(_textBg2);
         }
         _textBg2 = null;
         if(_textBg3)
         {
            ObjectUtils.disposeObject(_textBg3);
         }
         _textBg3 = null;
         if(_agilityBg)
         {
            ObjectUtils.disposeObject(_agilityBg);
         }
         _agilityBg = null;
         if(_attackBg)
         {
            ObjectUtils.disposeObject(_attackBg);
         }
         _attackBg = null;
         if(_defenceBg)
         {
            ObjectUtils.disposeObject(_defenceBg);
         }
         _defenceBg = null;
         if(_luckBg)
         {
            ObjectUtils.disposeObject(_luckBg);
         }
         _luckBg = null;
         if(_GrooveTxt)
         {
            ObjectUtils.disposeObject(_GrooveTxt);
         }
         _GrooveTxt = null;
         if(_levelNumTxt1)
         {
            ObjectUtils.disposeObject(_levelNumTxt1);
         }
         _levelNumTxt1 = null;
         if(_levelNumTxt2)
         {
            ObjectUtils.disposeObject(_levelNumTxt2);
         }
         _levelNumTxt2 = null;
         if(_levelNumTxt3)
         {
            ObjectUtils.disposeObject(_levelNumTxt3);
         }
         _levelNumTxt3 = null;
         if(_levelNumTxt4)
         {
            ObjectUtils.disposeObject(_levelNumTxt4);
         }
         _levelNumTxt4 = null;
         if(_levelNumTxt5)
         {
            ObjectUtils.disposeObject(_levelNumTxt5);
         }
         _levelNumTxt5 = null;
         if(_levelPorgress)
         {
            ObjectUtils.disposeObject(_levelPorgress);
         }
         _levelPorgress = null;
         if(_levelPorgress1)
         {
            ObjectUtils.disposeObject(_levelPorgress1);
         }
         _levelPorgress1 = null;
         if(_levelPorgress2)
         {
            ObjectUtils.disposeObject(_levelPorgress2);
         }
         _levelPorgress2 = null;
         if(_levelPorgress3)
         {
            ObjectUtils.disposeObject(_levelPorgress3);
         }
         _levelPorgress3 = null;
         if(_levelPorgress4)
         {
            ObjectUtils.disposeObject(_levelPorgress4);
         }
         _levelPorgress4 = null;
         if(_levelTxt1)
         {
            ObjectUtils.disposeObject(_levelTxt1);
         }
         _levelTxt1 = null;
         if(_levelTxt2)
         {
            ObjectUtils.disposeObject(_levelTxt2);
         }
         _levelTxt2 = null;
         if(_levelTxt3)
         {
            ObjectUtils.disposeObject(_levelTxt3);
         }
         _levelTxt3 = null;
         if(_levelTxt4)
         {
            ObjectUtils.disposeObject(_levelTxt4);
         }
         _levelTxt4 = null;
         if(_levelTxt5)
         {
            ObjectUtils.disposeObject(_levelTxt5);
         }
         _levelTxt5 = null;
         if(_HunzhiBg)
         {
            ObjectUtils.disposeObject(_HunzhiBg);
         }
         _HunzhiBg = null;
         if(_ballPlay)
         {
            ObjectUtils.disposeObject(_ballPlay);
         }
         _ballPlay = null;
         if(_achievementBtn)
         {
            _achievementBtn.removeEventListener("click",__onClickAchievement);
         }
         ObjectUtils.disposeObject(_achievementBtn);
         _achievementBtn = null;
         if(_moneyConfirm)
         {
            ObjectUtils.disposeObject(_moneyConfirm);
         }
         _moneyConfirm = null;
         ObjectUtils.disposeObject(_background2);
         _background2 = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         PlayerManager.Instance.removeEventListener("updatePlayerState",__onUpdateProperty);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(_equipCells[_loc2_])
            {
               _equipCells[_loc2_].dispose();
               _equipCells[_loc2_].removeEventListener("interactive_click",__clickHandler);
               _equipCells[_loc2_].removeEventListener("interactive_double_click",__doubleClickHandler);
               _equipCells[_loc2_].removeEventListener("mouseOver",_cellOverEff);
               _equipCells[_loc2_].removeEventListener("mouseOut",_cellOutEff);
               _equipCells[_loc2_] = null;
            }
            _loc2_++;
         }
         _equipCells = null;
         _loc1_ = 0;
         while(_loc1_ < _viceCardBit.length)
         {
            if(_viceCardBit[_loc1_])
            {
               ObjectUtils.disposeObject(_viceCardBit[_loc1_]);
            }
            _viceCardBit[_loc1_] = null;
            _loc1_++;
         }
         _viceCardBit = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      protected function __clickHandler(param1:Event) : void
      {
         var _loc3_:* = null;
         param1.stopImmediatePropagation();
         if(param1.target is BaseButton)
         {
            return;
         }
         var _loc2_:CardCell = param1.currentTarget as CardCell;
         if(_loc2_)
         {
            _loc3_ = _loc2_.info as ItemTemplateInfo;
         }
         if(_loc3_ == null)
         {
            return;
         }
         if(!_loc2_.locked)
         {
            SoundManager.instance.play("008");
            _loc2_.dragStart();
         }
      }
      
      protected function __doubleClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:CardCell = param1.currentTarget as CardCell;
         if(_loc2_.cardInfo)
         {
            param1.stopImmediatePropagation();
            if(_loc2_ && !_loc2_.locked)
            {
               SocketManager.Instance.out.sendMoveCards(_loc2_.cardInfo.Place,_loc2_.cardInfo.Place);
            }
         }
      }
      
      protected function _cellOverEff(param1:MouseEvent) : void
      {
      }
      
      protected function _cellOutEff(param1:MouseEvent) : void
      {
      }
   }
}
