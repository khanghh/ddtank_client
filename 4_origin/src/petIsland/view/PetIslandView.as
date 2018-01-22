package petIsland.view
{
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.greensock.easing.Elastic;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import petIsland.PetIslandManager;
   import petIsland.event.PetIslandEvent;
   
   public class PetIslandView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _returnBtn:PetIslandReturnBar;
      
      private var _mask:Shape;
      
      private var _contain:Sprite;
      
      private var numberArr:Array;
      
      private var pList:Array;
      
      private var points:int = 0;
      
      private var nowPoints:int = 0;
      
      private var flyFlash:MovieClip;
      
      private var _buyBtn:BaseButton;
      
      private var _buySkillTwoBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _playerMathContain:Sprite;
      
      private var _npcMathContain:Sprite;
      
      private var _roundMc:Sprite;
      
      private var _beginBtn:BaseButton;
      
      private var _playerScore:Bitmap;
      
      private var _npcScore:Bitmap;
      
      private var _begin:Bitmap;
      
      private var _continue:Bitmap;
      
      private var _roundTxt:FilterFrameText;
      
      private var _playerBloodTxt:FilterFrameText;
      
      private var _npcBloodTxt:FilterFrameText;
      
      private var _bloodContain:Sprite;
      
      private var _info:FilterFrameText;
      
      private var _currentStep:int;
      
      private var _playerBlood:Bitmap;
      
      private var playerMask:Sprite;
      
      private var _npcBlood:Bitmap;
      
      private var npcMask:Sprite;
      
      private var prizeView:PetIslandPrizeView;
      
      private var bloodFlash:MovieClip;
      
      private var success:MovieClip;
      
      private var fail:MovieClip;
      
      private var beginFlash:MovieClip;
      
      private var npcHead:MovieClip;
      
      private var playerHead:Sprite;
      
      private var blackBg:Sprite;
      
      private var stopPlayBlackBg:Sprite;
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headBitmap:Bitmap;
      
      private var _skillTimesTxt:FilterFrameText;
      
      private var _skillTimesTxt1:FilterFrameText;
      
      private var _redBall:Bitmap;
      
      private var _redBallTwo:Bitmap;
      
      private var tweenFlag:Boolean = true;
      
      private var _helpframe:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var gameOver:Boolean = false;
      
      private var alert:BaseAlerFrame;
      
      private var alart1:BaseAlerFrame;
      
      private var useSkillType:int;
      
      private var canClickNum:int = 0;
      
      private var canClick:Boolean = true;
      
      private var isMove:Boolean = false;
      
      private var saveDestroyArr:Array;
      
      private var useSkillScore:int = 0;
      
      public function PetIslandView()
      {
         _contain = new Sprite();
         numberArr = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];
         pList = [];
         _playerMathContain = new Sprite();
         _npcMathContain = new Sprite();
         _roundMc = new Sprite();
         _bloodContain = new Sprite();
         playerHead = new Sprite();
         blackBg = new Sprite();
         stopPlayBlackBg = new Sprite();
         saveDestroyArr = [];
         super();
         initView();
         initEvent();
         initData();
         loadHead();
      }
      
      private function loadHead() : void
      {
         if(_headLoader)
         {
            _headLoader.dispose();
            _headLoader = null;
         }
         _headLoader = new SceneCharacterLoaderHead(PlayerManager.Instance.Self);
         _headLoader.load(headLoaderCallBack);
      }
      
      private function headLoaderCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1)
         {
            if(!_headBitmap)
            {
               _headBitmap = new Bitmap();
            }
            _loc3_ = new Rectangle(0,0,120,103);
            _loc4_ = new BitmapData(120,103,true,0);
            _loc4_.copyPixels(param1.getContent()[0] as BitmapData,_loc3_,new Point(0,0));
            _headBitmap.bitmapData = _loc4_;
            param1.dispose();
            _headBitmap.rotationY = 180;
            _headBitmap.x = 137;
            _headBitmap.y = 80;
            playerHead.addChild(_headBitmap);
         }
      }
      
      private function initData() : void
      {
         setPlayerScore();
         setNpcScore();
         setBegin();
      }
      
      private function setBegin() : void
      {
         switch(int(PetIslandManager.instance.model.openType))
         {
            case 0:
               _begin.visible = true;
               beginFlash.visible = true;
               beginFlash.play();
               stopPlayBlackBg.visible = true;
               _continue.visible = false;
               _roundMc.visible = false;
               canClick = false;
               break;
            case 1:
               _begin.visible = false;
               beginFlash.visible = false;
               beginFlash.stop();
               stopPlayBlackBg.visible = false;
               _continue.visible = false;
               _roundMc.visible = true;
               canClick = true;
               setStep();
               break;
            case 2:
               _begin.visible = false;
               beginFlash.visible = true;
               beginFlash.play();
               _continue.visible = true;
               stopPlayBlackBg.visible = true;
               _roundMc.visible = false;
               canClick = false;
         }
      }
      
      private function setSaveLifeCount() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         while(_bloodContain.numChildren > 0)
         {
            _bloodContain.removeChildAt(0);
         }
         _loc2_ = 0;
         while(_loc2_ < PetIslandManager.instance.model.saveLifeCount)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.petIsland.blood");
            _loc1_.x = 125 + _loc1_.width * _loc2_;
            _loc1_.y = 90;
            _bloodContain.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function setStep() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _currentStep = PetIslandManager.instance.model.step;
         while(_roundMc.numChildren > 0)
         {
            _roundMc.removeChildAt(0);
         }
         if(PetIslandManager.instance.model.currentLevel > ServerConfigManager.instance.petDisappearPlaySoncount.length)
         {
            _loc2_ = "";
         }
         else
         {
            _loc2_ = String(parseInt(ServerConfigManager.instance.petDisappearPlaySoncount[PetIslandManager.instance.model.currentLevel - 1]) - PetIslandManager.instance.model.step);
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = ComponentFactory.Instance.creat("asset.petIsland.bigMathMc");
            _loc1_.gotoAndStop(1 + parseInt(_loc2_.substr(_loc3_,1)));
            if(_loc2_.length > 1)
            {
               _loc1_.x = 35 * _loc3_ - 18;
            }
            _roundMc.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function setPlayerScore() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         while(_playerMathContain.numChildren > 0)
         {
            _playerMathContain.removeChildAt(0);
         }
         var _loc2_:String = String(PetIslandManager.instance.model.playerScore);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = ComponentFactory.Instance.creat("asset.petIsland.mathMc");
            _loc1_.gotoAndStop(1 + parseInt(_loc2_.substr(_loc3_,1)));
            _loc1_.x = 18 * _loc3_;
            _playerMathContain.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function setNpcScore() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         while(_npcMathContain.numChildren > 0)
         {
            _npcMathContain.removeChildAt(0);
         }
         var _loc2_:String = String(PetIslandManager.instance.model.npcScore);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = ComponentFactory.Instance.creat("asset.petIsland.mathMc");
            _loc1_.gotoAndStop(1 + parseInt(_loc2_.substr(_loc3_,1)));
            _loc1_.x = 18 * _loc3_;
            _npcMathContain.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function initView() : void
      {
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.petIsland.bg");
         addChild(_bg);
         _returnBtn = ComponentFactory.Instance.creat("asset.petIsland.returnMenu");
         _mask = new Shape();
         _mask.graphics.beginFill(255);
         _mask.graphics.drawRect(317,222,375,375);
         addChild(_mask);
         _contain.mask = _mask;
         PositionUtils.setPos(_contain,"asset.petIsland.mask.position");
         pList = PetIslandManager.instance.model.pList;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(pList.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < numberArr.length)
            {
               _loc2_ = 0;
               while(_loc2_ < numberArr[_loc3_].length)
               {
                  _loc1_ = pList[_loc3_][_loc2_] as PetIslandCell;
                  _contain.addChild(_loc1_);
                  _loc1_.x = _loc2_ * 70;
                  _loc1_.y = _loc3_ * 70;
                  _loc2_++;
               }
               _loc3_++;
            }
         }
         else
         {
            refresh();
         }
         flyFlash = ComponentFactory.Instance.creat("asset.petIsland.flyFlash");
         flyFlash.visible = false;
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("asset.petIsland.buyBtn");
         _buyBtn.tipData = LanguageMgr.GetTranslation("ddt.petIsland.useSkillTip");
         _buySkillTwoBtn = ComponentFactory.Instance.creatComponentByStylename("asset.petIsland.buySkillTwoBtn");
         _buySkillTwoBtn.tipData = LanguageMgr.GetTranslation("ddt.petIsland.useCrossSkillTip");
         if(PetIslandManager.instance.model.currentLevel > ServerConfigManager.instance.petDisappearMaxLevel)
         {
         }
         _redBall = ComponentFactory.Instance.creatBitmap("asset.petIsland.redBall");
         _redBallTwo = ComponentFactory.Instance.creatBitmap("asset.petIsland.redBall");
         PositionUtils.setPos(_redBallTwo,"asset.petIsland.redBallTwo");
         _skillTimesTxt = ComponentFactory.Instance.creatComponentByStylename("petIsland.view.skillTimesTxt");
         _skillTimesTxt.text = String(ServerConfigManager.instance.petDisappearSkillMaxTimes - PetIslandManager.instance.model.saveLifeCount);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("asset.petIsland.helpBtn");
         _skillTimesTxt1 = ComponentFactory.Instance.creatComponentByStylename("petIsland.view.skillTimesTxt");
         _skillTimesTxt1.text = String(ServerConfigManager.instance.petDisappearSkillTwoMaxTimes - PetIslandManager.instance.model.saveLife2Count);
         PositionUtils.setPos(_skillTimesTxt1,"petIsland.view.skillTwoTimesTxt.position");
         PositionUtils.setPos(_playerMathContain,"asset.petIsland.playerScore.position");
         PositionUtils.setPos(_npcMathContain,"asset.petIsland.npcScore.position");
         PositionUtils.setPos(_roundMc,"asset.petIsland.round.position");
         _beginBtn = ComponentFactory.Instance.creatComponentByStylename("asset.petIsland.beginBgBtn");
         _begin = ComponentFactory.Instance.creatBitmap("asset.petIsland.begin");
         _continue = ComponentFactory.Instance.creatBitmap("asset.petIsland.continue");
         beginFlash = ComponentFactory.Instance.creat("asset.petIsland.beginFlash");
         beginFlash.x = 227;
         beginFlash.y = 128;
         var _loc4_:* = false;
         beginFlash.mouseChildren = _loc4_;
         beginFlash.mouseEnabled = _loc4_;
         _roundTxt = ComponentFactory.Instance.creatComponentByStylename("petIsland.view.roundTxt");
         _playerScore = ComponentFactory.Instance.creatBitmap("asset.petIsland.score");
         _npcScore = ComponentFactory.Instance.creatBitmap("asset.petIsland.score");
         PositionUtils.setPos(_playerScore,"asset.petIsland.playerScore.position1");
         PositionUtils.setPos(_npcScore,"asset.petIsland.npcScore.position1");
         _playerBlood = ComponentFactory.Instance.creatBitmap("asset.petIsland.playerBlood");
         playerMask = new Sprite();
         playerMask.graphics.beginFill(16777215,1);
         playerMask.graphics.drawRect(0,0,_playerBlood.width,_playerBlood.height);
         playerMask.graphics.endFill();
         playerMask.x = _playerBlood.x;
         playerMask.y = _playerBlood.y;
         _playerBlood.mask = playerMask;
         _playerBloodTxt = ComponentFactory.Instance.creatComponentByStylename("petIsland.view.playerBloodTxt");
         _npcBlood = ComponentFactory.Instance.creatBitmap("asset.petIsland.npcBlood");
         npcMask = new Sprite();
         npcMask.graphics.beginFill(16777215,1);
         npcMask.graphics.drawRect(0,0,_npcBlood.width,_npcBlood.height);
         npcMask.graphics.endFill();
         npcMask.x = _npcBlood.x;
         npcMask.y = _npcBlood.y;
         _npcBlood.mask = npcMask;
         _npcBloodTxt = ComponentFactory.Instance.creatComponentByStylename("petIsland.view.npcBloodTxt");
         npcHead = ComponentFactory.Instance.creat("asset.petIsland.npcHead");
         npcHead.x = 870;
         npcHead.y = 78;
         npcHead.gotoAndStop(PetIslandManager.instance.model.currentLevel);
         prizeView = new PetIslandPrizeView();
         prizeView.setPrizeView();
         bloodFlash = ComponentFactory.Instance.creat("asset.petIsland.bloodFlash");
         success = ComponentFactory.Instance.creat("asset.petIsland.success");
         success.x = 65;
         success.y = 107;
         _loc4_ = 0.6;
         success.scaleY = _loc4_;
         success.scaleX = _loc4_;
         fail = ComponentFactory.Instance.creat("asset.petIsland.fail");
         fail.x = 415;
         fail.y = 260;
         blackBg.graphics.beginFill(0,0.6);
         blackBg.graphics.drawRect(0,0,1000,600);
         blackBg.graphics.endFill();
         blackBg.visible = false;
         stopPlayBlackBg.graphics.beginFill(0,0.6);
         stopPlayBlackBg.graphics.drawRect(320,230,360,360);
         stopPlayBlackBg.graphics.endFill();
         stopPlayBlackBg.visible = false;
         _info = ComponentFactory.Instance.creatComponentByStylename("petIsland.view.infoTxt");
         _info.htmlText = PetIslandManager.instance.model.infoStr;
         if(PetIslandManager.instance.model.currentLevel > ServerConfigManager.instance.petDisappearMaxLevel)
         {
            npcMask.width = Math.floor(PetIslandManager.instance.model.npcBlood / ServerConfigManager.instance.petDisappearNPCBlood[ServerConfigManager.instance.petDisappearMaxLevel - 1] * _npcBlood.width * 100) / 100;
            playerMask.width = Math.floor(PetIslandManager.instance.model.playerBlood / ServerConfigManager.instance.petDisappearPlayerBlood[ServerConfigManager.instance.petDisappearMaxLevel - 1] * _playerBlood.width * 100) / 100;
            _npcBloodTxt.text = PetIslandManager.instance.model.npcBlood + "/" + ServerConfigManager.instance.petDisappearNPCBlood[ServerConfigManager.instance.petDisappearMaxLevel - 1];
            _playerBloodTxt.text = PetIslandManager.instance.model.playerBlood + "/" + ServerConfigManager.instance.petDisappearPlayerBlood[ServerConfigManager.instance.petDisappearMaxLevel - 1];
            _roundTxt.text = LanguageMgr.GetTranslation("ddt.petIsland.roundTxt",PetIslandManager.instance.model.round,ServerConfigManager.instance.petDisappearPlaycount[ServerConfigManager.instance.petDisappearMaxLevel - 1]);
         }
         else
         {
            npcMask.width = Math.floor(PetIslandManager.instance.model.npcBlood / ServerConfigManager.instance.petDisappearNPCBlood[PetIslandManager.instance.model.currentLevel - 1] * _npcBlood.width * 100) / 100;
            playerMask.width = Math.floor(PetIslandManager.instance.model.playerBlood / ServerConfigManager.instance.petDisappearPlayerBlood[PetIslandManager.instance.model.currentLevel - 1] * _playerBlood.width * 100) / 100;
            _npcBloodTxt.text = PetIslandManager.instance.model.npcBlood + "/" + ServerConfigManager.instance.petDisappearNPCBlood[PetIslandManager.instance.model.currentLevel - 1];
            _playerBloodTxt.text = PetIslandManager.instance.model.playerBlood + "/" + ServerConfigManager.instance.petDisappearPlayerBlood[PetIslandManager.instance.model.currentLevel - 1];
            _roundTxt.text = LanguageMgr.GetTranslation("ddt.petIsland.roundTxt",PetIslandManager.instance.model.round,ServerConfigManager.instance.petDisappearPlaycount[PetIslandManager.instance.model.currentLevel - 1]);
         }
         npcMask.x = _npcBlood.x + _npcBlood.width - npcMask.width;
         addChild(_contain);
         addChild(_returnBtn);
         addChild(flyFlash);
         addChild(_playerMathContain);
         addChild(_npcMathContain);
         addChild(_beginBtn);
         addChild(_begin);
         addChild(_roundMc);
         addChild(_continue);
         addChild(_roundTxt);
         addChild(_playerScore);
         addChild(_npcScore);
         addChild(_bloodContain);
         addChild(_playerBlood);
         addChild(playerMask);
         addChild(_npcBlood);
         addChild(npcMask);
         addChild(prizeView);
         addChild(_npcBloodTxt);
         addChild(bloodFlash);
         addChild(npcHead);
         addChild(playerHead);
         addChild(_playerBloodTxt);
         addChild(_info);
         addChild(beginFlash);
         addChild(_buyBtn);
         addChild(_buySkillTwoBtn);
         addChild(_redBall);
         addChild(_redBallTwo);
         addChild(_skillTimesTxt);
         addChild(_skillTimesTxt1);
         addChild(_helpBtn);
         addChild(stopPlayBlackBg);
         addChild(blackBg);
         addChild(success);
         addChild(fail);
      }
      
      private function stepChangeHandler(param1:PetIslandEvent) : void
      {
         if(param1.resultData)
         {
            canClickNum = Number(canClickNum) + 1;
            if(canClickNum == 2)
            {
               canClick = true;
               canClickNum = 0;
            }
         }
         else
         {
            PetIslandManager.instance.dispatchEvent(new PetIslandEvent("return_petIsLand"));
         }
      }
      
      private function refresh(param1:PetIslandEvent = null) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:* = null;
         if(param1 != null)
         {
            PetIslandManager.instance.model.infoStr = LanguageMgr.GetTranslation("ddt.petIsland.continue") + "\n" + PetIslandManager.instance.model.infoStr;
            _info.htmlText = PetIslandManager.instance.model.infoStr;
         }
         while(_contain.numChildren > 0)
         {
            _contain.removeChildAt(0);
         }
         var _loc8_:* = [];
         PetIslandManager.instance.model.pList = _loc8_;
         pList = _loc8_;
         _loc7_ = 0;
         while(_loc7_ < numberArr.length)
         {
            _loc5_ = [];
            _loc6_ = 0;
            while(_loc6_ < numberArr[_loc7_].length)
            {
               while(true)
               {
                  _loc2_ = randomInt(4);
                  numberArr[_loc7_][_loc6_] = _loc2_;
                  _loc3_ = checkArr(_loc7_,_loc6_,numberArr);
                  if(!_loc3_)
                  {
                     continue;
                  }
                  break;
               }
               _loc4_ = new PetIslandCell(_loc2_,_loc7_,_loc6_);
               _contain.addChild(_loc4_);
               _loc5_.push(_loc4_);
               _loc4_.x = _loc6_ * 70;
               _loc4_.y = _loc7_ * 70;
               _loc6_++;
            }
            pList.push(_loc5_);
            _loc7_++;
         }
      }
      
      private function initEvent() : void
      {
         PetIslandManager.instance.addEventListener("return_petIsLand",__onReturn);
         PetIslandManager.instance.addEventListener("pet_click",__petClickHandler);
         PetIslandManager.instance.addEventListener("destroy",__destroyHandler);
         PetIslandManager.instance.model.addEventListener("npcscore",_npcScoreChange);
         PetIslandManager.instance.model.addEventListener("playerscore",_playerScoreChange);
         PetIslandManager.instance.model.addEventListener("round",__currentRoundChange);
         PetIslandManager.instance.model.addEventListener("rewardRecord",__rewardRecordChange);
         PetIslandManager.instance.model.addEventListener("step",__stepChange);
         PetIslandManager.instance.model.addEventListener("playerBlood",__playerBloodChange);
         PetIslandManager.instance.model.addEventListener("npcBlood",__npcBloodChange);
         PetIslandManager.instance.model.addEventListener("openType",__opentypeChange);
         PetIslandManager.instance.model.addEventListener("currentLevel",__currentLevelChange);
         PetIslandManager.instance.model.addEventListener("useSkill",__useSkillChange);
         PetIslandManager.instance.model.addEventListener("useSkillTwo",__useSkillTwoChange);
         PetIslandManager.instance.addEventListener("saveLifeCount",__saveLifeCountChange);
         PetIslandManager.instance.addEventListener("refresh",refresh);
         PetIslandManager.instance.addEventListener("stepChange",stepChangeHandler);
         _beginBtn.addEventListener("click",__beginBtnClickHandler);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         _buySkillTwoBtn.addEventListener("click",__buySkillTwoBtnClickHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         success.addEventListener("com",completeHandler);
         fail.addEventListener("com",completeHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_helpframe)
         {
            _helpframe = ComponentFactory.Instance.creatComponentByStylename("petIsland.frame.help.main");
            _helpframe.titleText = LanguageMgr.GetTranslation("zodiac.mainframe.title");
            _helpframe.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("petIsland.frame.help.bgHelp");
            _content = ComponentFactory.Instance.creat("petIsland.frame.help.content");
            PositionUtils.setPos(_content,"asset.petIsland.content.pos");
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("petIsland.frame.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpframe.addToContent(_bgHelp);
            _helpframe.addToContent(_content);
            _helpframe.addToContent(_btnOk);
         }
         LayerManager.Instance.addToLayer(_helpframe,3,true,2);
      }
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            _helpframe.parent.removeChild(_helpframe);
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helpframe.parent.removeChild(_helpframe);
      }
      
      private function completeHandler(param1:Event) : void
      {
         blackBg.visible = false;
      }
      
      private function __useSkillChange(param1:PetIslandEvent) : void
      {
         _skillTimesTxt.text = String(ServerConfigManager.instance.petDisappearSkillMaxTimes - PetIslandManager.instance.model.saveLifeCount);
      }
      
      private function __useSkillTwoChange(param1:PetIslandEvent) : void
      {
         _skillTimesTxt1.text = String(ServerConfigManager.instance.petDisappearSkillTwoMaxTimes - PetIslandManager.instance.model.saveLife2Count);
      }
      
      private function __saveLifeCountChange(param1:PetIslandEvent) : void
      {
         if(param1.resultData == 1)
         {
            checkOneTypeAll();
         }
         else if(param1.resultData == 2)
         {
            crossDestroy();
         }
      }
      
      private function __currentLevelChange(param1:PetIslandEvent) : void
      {
         if(PetIslandManager.instance.model.currentLevel <= ServerConfigManager.instance.petDisappearMaxLevel)
         {
            PetIslandManager.instance.model.infoStr = LanguageMgr.GetTranslation("ddt.petIsland.gamePass",PetIslandManager.instance.model.currentLevel - 1) + "\n" + LanguageMgr.GetTranslation("ddt.petIsland.attackInfo",param1.resultData) + "\n" + PetIslandManager.instance.model.infoStr;
            _info.htmlText = PetIslandManager.instance.model.infoStr;
         }
         setTimeout(doSuccess,1000);
         var _loc2_:Boolean = false;
         this.mouseEnabled = _loc2_;
         this.mouseChildren = _loc2_;
         npcHead.gotoAndStop(PetIslandManager.instance.model.currentLevel);
         prizeView.setPrizeView();
      }
      
      private function doSuccess() : void
      {
         var _loc1_:Boolean = true;
         this.mouseEnabled = _loc1_;
         this.mouseChildren = _loc1_;
         success.play();
         blackBg.visible = true;
      }
      
      private function __opentypeChange(param1:PetIslandEvent) : void
      {
         if(PetIslandManager.instance.model.openType == 2)
         {
            gameOver = true;
            fail.play();
            blackBg.visible = true;
         }
         setBegin();
      }
      
      private function __playerBloodChange(param1:PetIslandEvent) : void
      {
         if(param1.resultData > 0)
         {
            bloodFlash.x = 6;
            bloodFlash.y = 91;
            bloodFlash.rotationY = 0;
            bloodFlash.play();
            if(PetIslandManager.instance.model.playerBlood != 0 && PetIslandManager.instance.model.openType != 2)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petIsland.nextRound"));
            }
            PetIslandManager.instance.model.infoStr = LanguageMgr.GetTranslation("ddt.petIsland.defenceInfo",param1.resultData) + "\n" + PetIslandManager.instance.model.infoStr;
            _info.htmlText = PetIslandManager.instance.model.infoStr;
            if(gameOver)
            {
               gameOver = false;
               PetIslandManager.instance.model.infoStr = LanguageMgr.GetTranslation("ddt.petIsland.gameOver",PetIslandManager.instance.model.currentLevel) + "\n" + PetIslandManager.instance.model.infoStr;
               _info.htmlText = PetIslandManager.instance.model.infoStr;
            }
         }
         if(PetIslandManager.instance.model.currentLevel > ServerConfigManager.instance.petDisappearMaxLevel)
         {
            playerMask.width = Math.floor(PetIslandManager.instance.model.playerBlood / ServerConfigManager.instance.petDisappearPlayerBlood[ServerConfigManager.instance.petDisappearMaxLevel - 1] * _playerBlood.width * 100) / 100;
            _playerBloodTxt.text = PetIslandManager.instance.model.playerBlood + "/" + ServerConfigManager.instance.petDisappearPlayerBlood[ServerConfigManager.instance.petDisappearMaxLevel - 1];
         }
         else
         {
            playerMask.width = Math.floor(PetIslandManager.instance.model.playerBlood / ServerConfigManager.instance.petDisappearPlayerBlood[PetIslandManager.instance.model.currentLevel - 1] * _playerBlood.width * 100) / 100;
            _playerBloodTxt.text = PetIslandManager.instance.model.playerBlood + "/" + ServerConfigManager.instance.petDisappearPlayerBlood[PetIslandManager.instance.model.currentLevel - 1];
         }
      }
      
      private function __npcBloodChange(param1:PetIslandEvent) : void
      {
         if(param1.resultData > 0)
         {
            bloodFlash.x = 992;
            bloodFlash.y = 91;
            bloodFlash.rotationY = 180;
            bloodFlash.play();
            if(PetIslandManager.instance.model.openType != 2)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petIsland.nextRound"));
            }
            PetIslandManager.instance.model.infoStr = LanguageMgr.GetTranslation("ddt.petIsland.attackInfo",param1.resultData) + "\n" + PetIslandManager.instance.model.infoStr;
            _info.htmlText = PetIslandManager.instance.model.infoStr;
            if(gameOver)
            {
               gameOver = false;
               PetIslandManager.instance.model.infoStr = LanguageMgr.GetTranslation("ddt.petIsland.gameOver",PetIslandManager.instance.model.currentLevel) + "\n" + PetIslandManager.instance.model.infoStr;
               _info.htmlText = PetIslandManager.instance.model.infoStr;
            }
         }
         if(PetIslandManager.instance.model.currentLevel > ServerConfigManager.instance.petDisappearMaxLevel)
         {
            npcMask.width = Math.floor(PetIslandManager.instance.model.npcBlood / ServerConfigManager.instance.petDisappearNPCBlood[ServerConfigManager.instance.petDisappearMaxLevel - 1] * _npcBlood.width * 100) / 100;
            _npcBloodTxt.text = PetIslandManager.instance.model.npcBlood + "/" + ServerConfigManager.instance.petDisappearNPCBlood[ServerConfigManager.instance.petDisappearMaxLevel - 1];
         }
         else
         {
            npcMask.width = Math.floor(PetIslandManager.instance.model.npcBlood / ServerConfigManager.instance.petDisappearNPCBlood[PetIslandManager.instance.model.currentLevel - 1] * _npcBlood.width * 100) / 100;
            _npcBloodTxt.text = PetIslandManager.instance.model.npcBlood + "/" + ServerConfigManager.instance.petDisappearNPCBlood[PetIslandManager.instance.model.currentLevel - 1];
         }
         npcMask.x = _npcBlood.x + _npcBlood.width - npcMask.width;
      }
      
      private function __rewardRecordChange(param1:PetIslandEvent) : void
      {
         prizeView.setPrizeView();
      }
      
      private function __stepChange(param1:PetIslandEvent) : void
      {
         setStep();
      }
      
      private function __currentRoundChange(param1:PetIslandEvent) : void
      {
         if(PetIslandManager.instance.model.currentLevel > ServerConfigManager.instance.petDisappearMaxLevel)
         {
            _roundTxt.text = LanguageMgr.GetTranslation("ddt.petIsland.roundTxt",PetIslandManager.instance.model.round,ServerConfigManager.instance.petDisappearPlaycount[ServerConfigManager.instance.petDisappearMaxLevel - 1]);
            return;
         }
         _roundTxt.text = LanguageMgr.GetTranslation("ddt.petIsland.roundTxt",PetIslandManager.instance.model.round,ServerConfigManager.instance.petDisappearPlaycount[PetIslandManager.instance.model.currentLevel - 1]);
      }
      
      private function __beginBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         switch(int(PetIslandManager.instance.model.openType))
         {
            case 0:
               if(PetIslandManager.instance.model.currentLevel > ServerConfigManager.instance.petDisappearMaxLevel)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petIsland.todayGameIsEnding"));
                  return;
               }
               SocketManager.Instance.out.petIslandInit(3);
               PetIslandManager.instance.model.openType = 1;
               break;
            case 1:
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petIsland.gameIsPlaying"));
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("ddt.petIsland.useMoney",ServerConfigManager.instance.petDisappearRecoverPrice);
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               alert.addEventListener("response",__onRecoverResponse);
         }
      }
      
      private function __onRecoverResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         alert.removeEventListener("response",__onRecoverResponse);
         var _loc2_:int = ServerConfigManager.instance.petDisappearRecoverPrice;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            alert.dispose();
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               alart1 = LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.petIslandInit(2);
         }
         alert.dispose();
      }
      
      private function __onRecoverResponse1(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         alert.removeEventListener("response",__onRecoverResponse1);
         var _loc2_:int = useSkillType == 1?ServerConfigManager.instance.petDisappearSkillMoney[PetIslandManager.instance.model.saveLifeCount]:ServerConfigManager.instance.petDisappearSkillTwoMoney[PetIslandManager.instance.model.saveLife2Count];
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            alert.dispose();
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               alart1 = LeavePageManager.showFillFrame();
               return;
            }
            canClick = false;
            canClickNum = Number(canClickNum) + 1;
            var _loc3_:Boolean = false;
            this.mouseChildren = _loc3_;
            this.mouseEnabled = _loc3_;
            SocketManager.Instance.out.petIslandBuyBlood(useSkillType);
         }
         alert.dispose();
      }
      
      private function __buySkillTwoBtnClickHandler(param1:MouseEvent) : void
      {
         if(PetIslandManager.instance.model.openType != 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petIsland.gameNoBegin"));
            return;
         }
         if(PetIslandManager.instance.model.saveLife2Count >= ServerConfigManager.instance.petDisappearSkillTwoMaxTimes)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petIsland.overMaxUse"));
            return;
         }
         useSkillType = 2;
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.petIsland.useMoney",ServerConfigManager.instance.petDisappearSkillTwoMoney[PetIslandManager.instance.model.saveLife2Count]);
         alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
         alert.addEventListener("response",__onRecoverResponse1);
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         if(PetIslandManager.instance.model.openType != 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petIsland.gameNoBegin"));
            return;
         }
         if(PetIslandManager.instance.model.saveLifeCount >= ServerConfigManager.instance.petDisappearSkillMaxTimes)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petIsland.overMaxUse"));
            return;
         }
         useSkillType = 1;
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.petIsland.useMoney",ServerConfigManager.instance.petDisappearSkillMoney[PetIslandManager.instance.model.saveLifeCount]);
         alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
         alert.addEventListener("response",__onRecoverResponse1);
      }
      
      private function _npcScoreChange(param1:PetIslandEvent) : void
      {
         setNpcScore();
      }
      
      private function _playerScoreChange(param1:PetIslandEvent) : void
      {
         setPlayerScore();
      }
      
      private function __petClickHandler(param1:PetIslandEvent) : void
      {
         if(!canClick)
         {
            return;
         }
         canClick = false;
         var _loc3_:PetIslandCell = param1.resultData as PetIslandCell;
         var _loc2_:Array = checkRoundShine(_loc3_._row,_loc3_._col);
         clearShine();
         if(_loc2_.length > 0)
         {
            isMove = true;
            var _loc4_:Boolean = false;
            this.mouseChildren = _loc4_;
            this.mouseEnabled = _loc4_;
            swap([_loc3_._row,_loc3_._col],_loc2_);
         }
         else
         {
            pList[_loc3_._row][_loc3_._col].isShine = true;
            canClick = true;
         }
      }
      
      private function clearShine() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < pList.length)
         {
            _loc1_ = 0;
            while(_loc1_ < pList[_loc2_].length)
            {
               pList[_loc2_][_loc1_].isShine = false;
               _loc1_++;
            }
            _loc2_++;
         }
      }
      
      private function __onReturn(param1:PetIslandEvent) : void
      {
         SoundManager.instance.play("008");
         StateManager.setState("main");
      }
      
      private function checkOneTypeAll() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = [0,0,0,0];
         _loc5_ = 0;
         while(_loc5_ < pList.length)
         {
            _loc3_ = 0;
            while(_loc3_ < pList[_loc5_].length)
            {
               _loc4_ = pList[_loc5_][_loc3_].type;
               var _loc6_:* = _loc2_;
               var _loc7_:* = _loc4_ - 1;
               var _loc8_:* = Number(_loc6_[_loc7_]) + 1;
               _loc6_[_loc7_] = _loc8_;
               _loc3_++;
            }
            _loc5_++;
         }
         var _loc1_:Number = Math.max(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3]);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc1_ == _loc2_[_loc5_])
            {
               _loc4_ = _loc5_ + 1;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < pList.length)
         {
            _loc3_ = 0;
            while(_loc3_ < pList[_loc5_].length)
            {
               if(pList[_loc5_][_loc3_].type == _loc4_)
               {
                  saveDestroyArr.push({
                     "row":_loc5_,
                     "col":_loc3_,
                     "type":pList[_loc5_][_loc3_].type
                  });
               }
               _loc3_++;
            }
            _loc5_++;
         }
         checkAndDestroy();
      }
      
      private function crossDestroy(param1:int = 3, param2:int = 3) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < pList.length)
         {
            _loc3_ = 0;
            while(_loc3_ < pList[_loc4_].length)
            {
               if(_loc4_ + 1 == param1 || _loc3_ + 1 == param2)
               {
                  if(_loc4_ + 1 == param1 && _loc3_ + 1 == param2)
                  {
                     saveDestroyArr.unshift({
                        "row":_loc4_,
                        "col":_loc3_,
                        "type":pList[_loc4_][_loc3_].type
                     });
                  }
                  else
                  {
                     saveDestroyArr.push({
                        "row":_loc4_,
                        "col":_loc3_,
                        "type":pList[_loc4_][_loc3_].type
                     });
                  }
               }
               _loc3_++;
            }
            _loc4_++;
         }
         checkAndDestroy();
      }
      
      private function checkAndDestroy() : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(!tweenFlag)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < pList.length)
         {
            _loc4_ = 1;
            while(_loc4_ < pList[_loc6_].length - 1)
            {
               if(pList[_loc6_][_loc4_].type == pList[_loc6_][_loc4_ - 1].type && pList[_loc6_][_loc4_].type == pList[_loc6_][_loc4_ + 1].type)
               {
                  saveDestroyArr.push({
                     "row":_loc6_,
                     "col":_loc4_,
                     "type":pList[_loc6_][_loc4_].type
                  });
                  saveDestroyArr.push({
                     "row":_loc6_,
                     "col":_loc4_ - 1,
                     "type":pList[_loc6_][_loc4_ - 1].type
                  });
                  saveDestroyArr.push({
                     "row":_loc6_,
                     "col":_loc4_ + 1,
                     "type":pList[_loc6_][_loc4_ + 1].type
                  });
                  while(true)
                  {
                     _loc4_++;
                     if(_loc4_ < pList[_loc6_].length - 1 && pList[_loc6_][_loc4_].type == pList[_loc6_][_loc4_ + 1].type)
                     {
                        saveDestroyArr.push({
                           "row":_loc6_,
                           "col":_loc4_ + 1,
                           "type":pList[_loc6_][_loc4_ + 1].type
                        });
                        continue;
                     }
                     break;
                  }
               }
               _loc4_++;
            }
            _loc6_++;
         }
         _loc4_ = 0;
         while(_loc4_ < pList[0].length)
         {
            _loc6_ = 1;
            while(_loc6_ < pList.length - 1)
            {
               if(pList[_loc6_][_loc4_].type == pList[_loc6_ - 1][_loc4_].type && pList[_loc6_][_loc4_].type == pList[_loc6_ + 1][_loc4_].type)
               {
                  saveDestroyArr.push({
                     "row":_loc6_,
                     "col":_loc4_,
                     "type":pList[_loc6_][_loc4_].type
                  });
                  saveDestroyArr.push({
                     "row":_loc6_ - 1,
                     "col":_loc4_,
                     "type":pList[_loc6_ - 1][_loc4_].type
                  });
                  saveDestroyArr.push({
                     "row":_loc6_ + 1,
                     "col":_loc4_,
                     "type":pList[_loc6_ + 1][_loc4_].type
                  });
                  while(true)
                  {
                     _loc6_++;
                     if(_loc6_ < pList.length - 1 && pList[_loc6_][_loc4_].type == pList[_loc6_ + 1][_loc4_].type)
                     {
                        saveDestroyArr.push({
                           "row":_loc6_ + 1,
                           "col":_loc4_,
                           "type":pList[_loc6_][_loc4_].type
                        });
                        continue;
                     }
                     break;
                  }
               }
               _loc6_++;
            }
            _loc4_++;
         }
         if(saveDestroyArr.length == 0)
         {
            if(useSkillType != 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("ddt.petIsland.skill").split("|")[useSkillType - 1];
               PetIslandManager.instance.model.infoStr = LanguageMgr.GetTranslation("ddt.petIsland.useSkillInfo",_loc2_,useSkillScore) + "\n" + PetIslandManager.instance.model.infoStr;
               _info.htmlText = PetIslandManager.instance.model.infoStr;
               useSkillType = 0;
               useSkillScore = 0;
            }
            if(isMove)
            {
               SocketManager.Instance.out.petIslandPlay(0,0);
               _currentStep = Number(_currentStep) + 1;
            }
            canClickNum = Number(canClickNum) + 1;
            if(canClickNum == 2)
            {
               canClick = true;
               canClickNum = 0;
            }
            isMove = false;
            var _loc7_:Boolean = true;
            this.mouseChildren = _loc7_;
            this.mouseEnabled = _loc7_;
            if(_currentStep == ServerConfigManager.instance.petDisappearPlaySoncount[PetIslandManager.instance.model.currentLevel - 1])
            {
               SocketManager.Instance.out.petIslandPlay(1,0,true);
            }
            return;
         }
         nowPoints = 0;
         var _loc3_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < saveDestroyArr.length)
         {
            if(pList[saveDestroyArr[_loc1_].row][saveDestroyArr[_loc1_].col] && _contain.contains(pList[saveDestroyArr[_loc1_].row][saveDestroyArr[_loc1_].col]))
            {
               _contain.setChildIndex(pList[saveDestroyArr[_loc1_].row][saveDestroyArr[_loc1_].col],_contain.numChildren - 1);
               pList[saveDestroyArr[_loc1_].row][saveDestroyArr[_loc1_].col].destroy();
               points = Number(points) + 1;
               nowPoints = nowPoints + ServerConfigManager.instance.petDisappearAddScore;
               if(!_loc3_)
               {
                  _loc3_ = true;
                  flyFlash.visible = true;
                  flyFlash.x = pList[saveDestroyArr[_loc1_].row][saveDestroyArr[_loc1_].col].x + _contain.x + pList[saveDestroyArr[_loc1_].row][saveDestroyArr[_loc1_].col].width / 2 - flyFlash.width / 2;
                  flyFlash.y = pList[saveDestroyArr[_loc1_].row][saveDestroyArr[_loc1_].col].y + _contain.y + pList[saveDestroyArr[_loc1_].row][saveDestroyArr[_loc1_].col].height / 2 - flyFlash.height / 2;
                  try
                  {
                     TweenLite.to(flyFlash,0.6,{
                        "delay":0.4,
                        "x":210,
                        "y":195,
                        "onComplete":flyFlashCom
                     });
                  }
                  catch(e:Error)
                  {
                     return;
                  }
               }
            }
            _loc1_++;
         }
         if(isMove)
         {
            isMove = false;
            SocketManager.Instance.out.petIslandPlay(0,nowPoints);
            _currentStep = Number(_currentStep) + 1;
         }
         else
         {
            if(useSkillType != 0)
            {
               useSkillScore = useSkillScore + nowPoints;
            }
            SocketManager.Instance.out.petIslandPlay(1,nowPoints);
         }
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("petIsland.view.pointsPaopao");
         addChild(_loc5_);
         _loc5_.text = "+" + String(nowPoints);
         try
         {
            TweenLite.to(_loc5_,1.8,{
               "y":110,
               "alpha":0,
               "onComplete":tweenComplete,
               "onCompleteParams":[_loc5_]
            });
            saveDestroyArr = [];
            TweenLite.to(_contain,0.4,{"onComplete":dropBlock});
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function flyFlashCom() : void
      {
         if(flyFlash)
         {
            flyFlash.visible = false;
         }
      }
      
      private function __destroyHandler(param1:PetIslandEvent) : void
      {
         var _loc2_:PetIslandCell = param1.resultData as PetIslandCell;
         _contain.removeChild(pList[_loc2_._row][_loc2_._col]);
         pList[_loc2_._row][_loc2_._col] = null;
      }
      
      private function tweenComplete(param1:FilterFrameText) : void
      {
         if(param1 && param1.parent.contains(param1))
         {
            param1.parent.removeChild(param1);
            param1 = null;
         }
      }
      
      private function dropBlock() : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Boolean = false;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(!tweenFlag)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < numberArr[0].length)
         {
            _loc6_ = numberArr.length - 1;
            while(_loc6_ >= 0)
            {
               if(pList[_loc6_][_loc3_] == null && _loc6_ != 0)
               {
                  _loc5_ = false;
                  _loc4_ = _loc6_ - 1;
                  while(_loc4_ >= 0)
                  {
                     if(pList[_loc4_][_loc3_] != null)
                     {
                        try
                        {
                           TweenLite.to(pList[_loc4_][_loc3_],0.5,{
                              "x":_loc3_ * 70,
                              "y":_loc6_ * 70,
                              "ease":Elastic.easeOut,
                              "easeParams":[10,10]
                           });
                        }
                        catch(e:Error)
                        {
                           return;
                        }
                        pList[_loc6_][_loc3_] = pList[_loc4_][_loc3_];
                        pList[_loc6_][_loc3_]._row = _loc6_;
                        pList[_loc6_][_loc3_]._col = _loc3_;
                        pList[_loc4_][_loc3_] = null;
                        _loc5_ = true;
                        break;
                     }
                     _loc4_--;
                  }
                  if(!_loc5_)
                  {
                     _loc1_ = new PetIslandCell(randomInt(4),_loc6_,_loc3_);
                     _contain.addChild(_loc1_);
                     _loc1_.x = _loc3_ * 70;
                     _loc1_.y = -70;
                     try
                     {
                        TweenLite.to(_loc1_,0.5,{
                           "x":_loc3_ * 70,
                           "y":_loc6_ * 70,
                           "ease":Elastic.easeOut,
                           "easeParams":[10,10]
                        });
                     }
                     catch(e:Error)
                     {
                        return;
                     }
                     pList[_loc6_][_loc3_] = _loc1_;
                     _loc5_ = true;
                  }
               }
               else if(pList[_loc6_][_loc3_] == null && _loc6_ == 0)
               {
                  _loc2_ = new PetIslandCell(randomInt(4),_loc6_,_loc3_);
                  _contain.addChild(_loc2_);
                  _loc2_.x = _loc3_ * 70;
                  _loc2_.y = -70;
                  try
                  {
                     TweenLite.to(_loc2_,0.5,{
                        "x":_loc3_ * 70,
                        "y":_loc6_ * 70,
                        "ease":Elastic.easeOut,
                        "easeParams":[10,10]
                     });
                  }
                  catch(e:Error)
                  {
                     return;
                  }
                  pList[_loc6_][_loc3_] = _loc2_;
               }
               _loc6_--;
            }
            _loc3_++;
         }
         try
         {
            TweenLite.to(_contain,0.5,{"onComplete":checkAndDestroy});
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function swap(param1:Array, param2:Array) : void
      {
         var _loc8_:int = pList[param1[0]][param1[1]].x;
         var _loc5_:int = pList[param1[0]][param1[1]].y;
         var _loc7_:int = pList[param2[0]][param2[1]].x;
         var _loc6_:int = pList[param2[0]][param2[1]].y;
         try
         {
            TweenLite.to(pList[param1[0]][param1[1]],0.4,{
               "x":_loc7_,
               "y":_loc6_
            });
            TweenLite.to(pList[param2[0]][param2[1]],0.4,{
               "x":_loc8_,
               "y":_loc5_,
               "onComplete":checkAndDestroy
            });
         }
         catch(e:Error)
         {
            return;
         }
         pList[param1[0]][param1[1]]._row = param2[0];
         pList[param1[0]][param1[1]]._col = param2[1];
         pList[param2[0]][param2[1]]._row = param1[0];
         pList[param2[0]][param2[1]]._col = param1[1];
         var _loc4_:PetIslandCell = pList[param1[0]][param1[1]];
         pList[param1[0]][param1[1]] = pList[param2[0]][param2[1]];
         pList[param2[0]][param2[1]] = _loc4_;
         var _loc3_:int = numberArr[param1[0]][param1[1]];
         numberArr[param1[0]][param1[1]] = numberArr[param2[0]][param2[1]];
         numberArr[param2[0]][param2[1]] = _loc3_;
      }
      
      private function checkRoundShine(param1:int, param2:int) : Array
      {
         if(param1 > 0 && pList[param1 - 1][param2] && pList[param1 - 1][param2].isShine)
         {
            return [param1 - 1,param2];
         }
         if(param2 > 0 && pList[param1][param2 - 1] && pList[param1][param2 - 1].isShine)
         {
            return [param1,param2 - 1];
         }
         if(param1 < pList.length - 1 && pList[param1 + 1][param2] && pList[param1 + 1][param2].isShine)
         {
            return [param1 + 1,param2];
         }
         if(param2 < pList.length - 1 && pList[param1][param2 + 1] && pList[param1][param2 + 1].isShine)
         {
            return [param1,param2 + 1];
         }
         return [];
      }
      
      private function randomInt(param1:int) : int
      {
         return Math.floor(1 + param1 * Math.random());
      }
      
      private function checkArr(param1:int, param2:int, param3:Array) : Boolean
      {
         if(param3[param1][param2 - 2] && param3[param1][param2 - 1])
         {
            if(param3[param1][param2 - 2] == param3[param1][param2] && param3[param1][param2 - 1] == param3[param1][param2])
            {
               return false;
            }
         }
         if(param3[param1][param2 - 1] && param3[param1][param2 + 1])
         {
            if(param3[param1][param2 - 1] == param3[param1][param2] && param3[param1][param2] == param3[param1][param2 + 1])
            {
               return false;
            }
         }
         if(param3[param1][param2 + 1] && param3[param1][param2 + 2])
         {
            if(param3[param1][param2] == param3[param1][param2 + 1] && param3[param1][param2] == param3[param1][param2 + 2])
            {
               return false;
            }
         }
         if(param1 >= 2)
         {
            if(param3[param1 - 2][param2] == param3[param1][param2] && param3[param1 - 1][param2] == param3[param1][param2])
            {
               return false;
            }
         }
         if(param1 <= param3.length - 3)
         {
            if(param3[param1 + 2][param2] == param3[param1][param2] && param3[param1 + 1][param2] == param3[param1][param2])
            {
               return false;
            }
         }
         if(param1 > 0 && param1 < param3.length - 1)
         {
            if(param3[param1 + 1][param2] == param3[param1][param2] && param3[param1 - 1][param2] == param3[param1][param2])
            {
               return false;
            }
         }
         return true;
      }
      
      private function removeEvent() : void
      {
         PetIslandManager.instance.removeEventListener("return_petIsLand",__onReturn);
         PetIslandManager.instance.removeEventListener("pet_click",__petClickHandler);
         PetIslandManager.instance.removeEventListener("destroy",__destroyHandler);
         PetIslandManager.instance.model.removeEventListener("npcscore",_npcScoreChange);
         PetIslandManager.instance.model.removeEventListener("playerscore",_playerScoreChange);
         PetIslandManager.instance.model.removeEventListener("round",__currentRoundChange);
         PetIslandManager.instance.model.removeEventListener("step",__stepChange);
         PetIslandManager.instance.model.removeEventListener("rewardRecord",__rewardRecordChange);
         PetIslandManager.instance.model.removeEventListener("playerBlood",__playerBloodChange);
         PetIslandManager.instance.model.removeEventListener("npcBlood",__npcBloodChange);
         PetIslandManager.instance.model.removeEventListener("openType",__opentypeChange);
         PetIslandManager.instance.model.removeEventListener("currentLevel",__currentLevelChange);
         PetIslandManager.instance.model.removeEventListener("useSkill",__useSkillChange);
         PetIslandManager.instance.model.removeEventListener("useSkillTwo",__useSkillTwoChange);
         PetIslandManager.instance.removeEventListener("saveLifeCount",__saveLifeCountChange);
         PetIslandManager.instance.removeEventListener("refresh",refresh);
         PetIslandManager.instance.removeEventListener("stepChange",stepChangeHandler);
         _beginBtn.removeEventListener("click",__beginBtnClickHandler);
         _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         _buySkillTwoBtn.removeEventListener("click",__buySkillTwoBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         success.removeEventListener("com",completeHandler);
         fail.removeEventListener("com",completeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         tweenFlag = false;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_contain);
         _contain = null;
         ObjectUtils.disposeObject(flyFlash);
         flyFlash = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_buySkillTwoBtn);
         _buySkillTwoBtn = null;
         ObjectUtils.disposeObject(_redBall);
         _redBall = null;
         ObjectUtils.disposeObject(_redBallTwo);
         _redBallTwo = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_playerMathContain);
         _playerMathContain = null;
         ObjectUtils.disposeObject(_npcMathContain);
         _npcMathContain = null;
         ObjectUtils.disposeObject(_beginBtn);
         _beginBtn = null;
         ObjectUtils.disposeObject(_begin);
         _begin = null;
         ObjectUtils.disposeObject(_continue);
         _continue = null;
         ObjectUtils.disposeObject(_playerScore);
         _playerScore = null;
         ObjectUtils.disposeObject(_npcScore);
         _npcScore = null;
         ObjectUtils.disposeObject(_roundTxt);
         _roundTxt = null;
         ObjectUtils.disposeObject(_roundMc);
         _roundMc = null;
         ObjectUtils.disposeObject(_bloodContain);
         _bloodContain = null;
         ObjectUtils.disposeObject(_info);
         _info = null;
         ObjectUtils.disposeObject(_playerBlood);
         _playerBlood = null;
         ObjectUtils.disposeObject(playerMask);
         playerMask = null;
         ObjectUtils.disposeObject(_npcBlood);
         _playerBlood = null;
         ObjectUtils.disposeObject(npcMask);
         playerMask = null;
         ObjectUtils.disposeObject(prizeView);
         prizeView = null;
         ObjectUtils.disposeObject(_playerBloodTxt);
         _playerBloodTxt = null;
         ObjectUtils.disposeObject(_npcBloodTxt);
         _npcBloodTxt = null;
         ObjectUtils.disposeObject(bloodFlash);
         bloodFlash = null;
         ObjectUtils.disposeObject(success);
         success = null;
         ObjectUtils.disposeObject(fail);
         fail = null;
         ObjectUtils.disposeObject(beginFlash);
         beginFlash = null;
         ObjectUtils.disposeObject(npcHead);
         npcHead = null;
         ObjectUtils.disposeObject(playerHead);
         playerHead = null;
         ObjectUtils.disposeObject(blackBg);
         blackBg = null;
         ObjectUtils.disposeObject(stopPlayBlackBg);
         stopPlayBlackBg = null;
         ObjectUtils.disposeObject(_bgHelp);
         _bgHelp = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_btnOk);
         _btnOk = null;
         ObjectUtils.disposeObject(_helpframe);
         _helpframe = null;
         if(_headLoader)
         {
            _headLoader.dispose();
            _headLoader = null;
         }
         ObjectUtils.disposeObject(_headBitmap);
         _headBitmap = null;
         ObjectUtils.disposeObject(_skillTimesTxt);
         _skillTimesTxt = null;
         ObjectUtils.disposeObject(_skillTimesTxt1);
         _skillTimesTxt1 = null;
         if(alert)
         {
            alert.removeEventListener("response",__onRecoverResponse);
            alert.removeEventListener("response",__onRecoverResponse1);
            ObjectUtils.disposeObject(alert);
         }
         ObjectUtils.disposeObject(alart1);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
