package cardSystem.view
{
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsUpgradeRuleInfo;
   import cardSystem.elements.CardCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.media.SoundTransform;
   import road7th.data.DictionaryEvent;
   
   public class UpGradeFrame extends Frame
   {
      
      public static const PROGRESS_HEIGHT:int = 29;
      
      public static const PROGRESS_WIDTH:int = 158;
       
      
      private var _BG:ScaleBitmapImage;
      
      private var _inputBg:Bitmap;
      
      private var _inputBg1:Bitmap;
      
      private var _card:CardCell;
      
      private var _cardNumBG:Bitmap;
      
      private var _progressBar:MovieClip;
      
      private var _progressBarMask:Sprite;
      
      private var _upGradeBtn:TextButton;
      
      private var _cardInfo:CardInfo;
      
      private var _helpBtn:BaseButton;
      
      private var _leftCardNumText:FilterFrameText;
      
      private var _progressText:FilterFrameText;
      
      private var _ruleText:FilterFrameText;
      
      private var _progressMoive:MovieClip;
      
      private var _upgradeRuleArr:Vector.<SetsUpgradeRuleInfo>;
      
      private var _levelBmp:Bitmap;
      
      private var _level:FilterFrameText;
      
      private var _helpFrame:Frame;
      
      private var _okBtn:TextButton;
      
      private var _content:MovieImage;
      
      private var _bg:Scale9CornerImage;
      
      private var _ruleInfo:SetsUpgradeRuleInfo;
      
      private var _lastGP:int = -1;
      
      private var _lastLevel:int = -1;
      
      private var upgradeMovie:MovieClip;
      
      private var _soundControl:SoundTransform;
      
      public function UpGradeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("ddt.cardSystem.UpGradeFrame.title");
         _BG = ComponentFactory.Instance.creatComponentByStylename("asset.upgradeFrame.bg");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset,ddtcardSystem.inputBg");
         _inputBg1 = ComponentFactory.Instance.creatBitmap("asset,ddtcardSystem.inputBg");
         PositionUtils.setPos(_inputBg1,"upgradeFrame.inputPos");
         _inputBg1.width = 155;
         _inputBg1.height = 20;
         _card = new CardCell(ComponentFactory.Instance.creatBitmap("asset.upgradeFrame.cardBG"));
         _card.setContentSize(120,175);
         _card.starVisible = false;
         PositionUtils.setPos(_card,"upgradeFrame.cellPos");
         _cardNumBG = ComponentFactory.Instance.creatBitmap("asset.upgradeFrame.cardNum");
         _progressBar = ClassUtils.CreatInstance("asset.upgradeFrame.progressBG") as MovieClip;
         PositionUtils.setPos(_progressBar,"upgradeFrame.progressPos");
         _progressBarMask = new Sprite();
         _progressBarMask.graphics.beginFill(16777215,1);
         _progressBarMask.graphics.drawRect(0,0,158,29);
         _progressBarMask.graphics.endFill();
         PositionUtils.setPos(_progressBarMask,"upgradeFrame.progressMaskPos");
         _progressBar.mask = _progressBarMask;
         _upGradeBtn = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame.button");
         _upGradeBtn.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.okLabel");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame.helpBtn");
         _leftCardNumText = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame.leftNum");
         _progressText = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame.progeressTxt");
         _ruleText = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame.ruleTxt");
         _progressMoive = ClassUtils.CreatInstance("asset.upgradeFrame.progressBarfalsh") as MovieClip;
         PositionUtils.setPos(_progressMoive,"upgradeFrame.progressMoivePos");
         _levelBmp = ComponentFactory.Instance.creatBitmap("asset.upgradeFrame.level");
         _level = ComponentFactory.Instance.creatComponentByStylename("cardSystem.level.big");
         PositionUtils.setPos(_level,"cardSystem.upgrade.level.pos");
         addToContent(_BG);
         addToContent(_inputBg1);
         addToContent(_inputBg);
         addToContent(_card);
         addToContent(_cardNumBG);
         addToContent(_progressBar);
         addToContent(_progressBarMask);
         addToContent(_upGradeBtn);
         addToContent(_helpBtn);
         addToContent(_leftCardNumText);
         addToContent(_progressText);
         addToContent(_ruleText);
         addToContent(_progressMoive);
         addToContent(_levelBmp);
         addToContent(_level);
         _progressMoive.visible = false;
         _progressBar["arrow"].visible = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _upGradeBtn.addEventListener("click",__upGradeHandler);
         PlayerManager.Instance.Self.cardBagDic.addEventListener("update",__upDateHandler);
         _helpBtn.addEventListener("click",__helpHandler);
         _progressMoive.addEventListener("complete",__progressPlayOver);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _upGradeBtn.removeEventListener("click",__upGradeHandler);
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("update",__upDateHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
         _progressMoive.removeEventListener("complete",__progressPlayOver);
      }
      
      private function __progressPlayOver(param1:Event) : void
      {
         _progressMoive.visible = false;
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_helpFrame == null)
         {
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame.helpFrame");
            _bg = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.BG1");
            _okBtn = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame.helpFrame.OK");
            _content = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.upgradeFrame.help");
            _okBtn.text = LanguageMgr.GetTranslation("ok");
            _helpFrame.titleText = LanguageMgr.GetTranslation("ddt.cardSystem.upgrade.explain");
            _helpFrame.addToContent(_bg);
            _helpFrame.addToContent(_content);
            _helpFrame.addToContent(_okBtn);
            _helpFrame.addToContent(_content);
            _okBtn.addEventListener("click",__closeHelpFrame);
            _helpFrame.addEventListener("response",__helpFrameRespose);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      protected function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            disposeHelpFrame();
         }
      }
      
      private function disposeHelpFrame() : void
      {
         _helpFrame.removeEventListener("response",__helpFrameRespose);
         _okBtn.removeEventListener("click",__closeHelpFrame);
         _helpFrame.dispose();
         _okBtn = null;
         _content = null;
         _helpFrame = null;
      }
      
      protected function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         disposeHelpFrame();
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __upDateHandler(param1:DictionaryEvent) : void
      {
         var _loc2_:CardInfo = param1.data as CardInfo;
         if(_loc2_.TemplateID != _cardInfo.TemplateID)
         {
            return;
         }
         if(_loc2_.CardGP - _lastGP == 0)
         {
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.upgradeFrame.upSuccess",_loc2_.CardGP - _lastGP),0,true);
         cardInfo = _loc2_;
         _progressMoive.visible = true;
         _progressMoive.gotoAndPlay(1);
         _progressBar.gotoAndPlay(1);
         _progressBar["arrow"].visible = true;
      }
      
      protected function __upGradeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_cardInfo.Count < _ruleInfo.UpdateCardCount)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.UpGradeFrame.moreCards"));
            return;
         }
         if(_cardInfo.Level >= 30)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.upgradeFrame.isMaxLevel"));
            return;
         }
         SocketManager.Instance.out.sendUpGradeCard(_cardInfo.Place);
         return;
         §§push(trace("点击按钮"));
      }
      
      public function set cardInfo(param1:CardInfo) : void
      {
         var _loc2_:int = 0;
         _cardInfo = param1;
         _upgradeRuleArr = CardManager.Instance.model.upgradeRuleVec;
         _loc2_ = 0;
         while(_loc2_ < _upgradeRuleArr.length)
         {
            if((_upgradeRuleArr[_loc2_] as SetsUpgradeRuleInfo).Level == param1.Level + 1)
            {
               _ruleInfo = _upgradeRuleArr[_loc2_];
               break;
            }
            _loc2_++;
         }
         upView();
      }
      
      private function upView() : void
      {
         _level.text = _cardInfo.Level < 10?"0" + _cardInfo.Level:_cardInfo.Level.toString();
         if(_lastLevel != -1 && _lastLevel + 1 == _cardInfo.Level)
         {
            if(upgradeMovie == null)
            {
               upgradeMovie = ClassUtils.CreatInstance("asset.upgradeFrame.upSuccess.movie") as MovieClip;
               LayerManager.Instance.addToLayer(upgradeMovie,0,false,2);
               _soundControl = new SoundTransform();
               if(SoundManager.instance.allowSound)
               {
                  _soundControl.volume = 1;
               }
               else
               {
                  _soundControl.volume = 0;
               }
               upgradeMovie.soundTransform = _soundControl;
               upgradeMovie.addEventListener("complete",__playOver);
               _upGradeBtn.enable = false;
            }
            PositionUtils.setPos(upgradeMovie,"upgradeFrame.upSuccessMoivePos");
         }
         _card.cardInfo = _cardInfo;
         _leftCardNumText.htmlText = LanguageMgr.GetTranslation("ddt.cardSystem.upgradeFrame.ownCardNum",_cardInfo.Count);
         if(_cardInfo.Level == 0)
         {
            _progressText.text = _cardInfo.CardGP + "/" + _ruleInfo.Exp;
            _progressBarMask.width = 158 * _cardInfo.CardGP / _ruleInfo.Exp;
         }
         else if(_cardInfo.Level < 30)
         {
            _progressText.text = String(_cardInfo.CardGP - _upgradeRuleArr[_cardInfo.Level - 1].Exp) + "/" + (String(_ruleInfo.Exp - _upgradeRuleArr[_cardInfo.Level - 1].Exp));
            _progressBarMask.width = 158 * (_cardInfo.CardGP - _upgradeRuleArr[_cardInfo.Level - 1].Exp) / (_upgradeRuleArr[_cardInfo.Level].Exp - _upgradeRuleArr[_cardInfo.Level - 1].Exp);
         }
         else
         {
            _progressText.visible = false;
            _progressBarMask.width = 0;
         }
         _ruleText.htmlText = LanguageMgr.GetTranslation("ddt.cardSystem.upgradeFrame.rule",_ruleInfo.Level > 30?30:int(_ruleInfo.Level),_ruleInfo.UpdateCardCount,_ruleInfo.MinExp,_ruleInfo.MaxExp);
         _lastGP = _cardInfo.CardGP;
         _lastLevel = _cardInfo.Level;
      }
      
      private function __playOver(param1:Event) : void
      {
         upgradeMovie.removeEventListener("complete",__playOver);
         _soundControl.volume = 0;
         upgradeMovie.soundTransform = _soundControl;
         _soundControl = null;
         if(upgradeMovie)
         {
            ObjectUtils.disposeObject(upgradeMovie);
         }
         upgradeMovie = null;
         _upGradeBtn.enable = true;
      }
      
      override public function dispose() : void
      {
         if(upgradeMovie)
         {
            upgradeMovie.removeEventListener("complete",__playOver);
            ObjectUtils.disposeObject(upgradeMovie);
         }
         removeEvent();
         super.dispose();
         _cardInfo = null;
         _upgradeRuleArr = null;
         _upGradeBtn = null;
         upgradeMovie = null;
         _BG = null;
         _inputBg = null;
         _card = null;
         _cardNumBG = null;
         _progressBar = null;
         _upGradeBtn = null;
         _helpBtn = null;
         _leftCardNumText = null;
         _progressText = null;
         _ruleText = null;
         _progressMoive = null;
         _inputBg1 = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
