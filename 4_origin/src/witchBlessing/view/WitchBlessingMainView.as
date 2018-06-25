package witchBlessing.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import witchBlessing.WitchBlessingManager;
   import witchBlessing.data.WitchBlessingModel;
   
   public class WitchBlessingMainView extends Frame implements Disposeable
   {
       
      
      private var _leftView:Sprite;
      
      private var _rightView:Sprite;
      
      private var _bottom:ScaleBitmapImage;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var lv1Btn:SelectedButton;
      
      private var lv2Btn:SelectedButton;
      
      private var lv3Btn:SelectedButton;
      
      private var lv1View:WitchBlessingRightView;
      
      private var lv2View:WitchBlessingRightView;
      
      private var lv3View:WitchBlessingRightView;
      
      private var titleMc:MovieClip;
      
      private var _awardsTxt:FilterFrameText;
      
      private var _takeAwayTxt:FilterFrameText;
      
      private var _timeOpenTxt:FilterFrameText;
      
      private var _doubleTimeTxt:FilterFrameText;
      
      private var _progressTxtImage:Bitmap;
      
      private var _progressBg:Bitmap;
      
      private var _progressCover:Bitmap;
      
      private var _progressTxt:FilterFrameText;
      
      private var _blessLvTxt:FilterFrameText;
      
      private var blessBtn:BaseButton;
      
      private var talkBoxMc:MovieClip;
      
      private var blessHarderBtn:BaseButton;
      
      private var _witchBlessingFrame:WitchBlessingFrame;
      
      private var itemInfo:ItemTemplateInfo;
      
      private var cell:BagCell;
      
      private var maxNumInBag:int;
      
      private var maxMoneyCount:int;
      
      private const ITEMID:int = int(ServerConfigManager.instance.getWitchBlessItemId);
      
      private const ONCE_BLESS_EXP:int = ServerConfigManager.instance.getWitchBlessGP[0];
      
      private const ONCE_HARDER_BLESS_EXP:int = ServerConfigManager.instance.getWitchBlessGP[2];
      
      private const ONCE_BLESS_MONEY:int = ServerConfigManager.instance.getWitchBlessMoney;
      
      private var expArr:Array;
      
      private var awardsNums:Array;
      
      private var doubleMoney:Array;
      
      public var nowLv:int = 0;
      
      private var needExp:int;
      
      private var allHarderBlessMax:int;
      
      private var allBlessMax:int;
      
      private var nextLvBlessMax:int;
      
      private var nextLvHarderBlessMax:int;
      
      private var _allIn:SelectedCheckButton;
      
      public function WitchBlessingMainView()
      {
         expArr = [0,500,1200,2200];
         awardsNums = [3,3,3];
         doubleMoney = [0,0,0];
         var model:WitchBlessingModel = WitchBlessingManager.Instance.model;
         expArr = model.ExpArr;
         awardsNums = model.AwardsNums;
         doubleMoney = model.DoubleMoney;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         itemInfo = ItemManager.Instance.getTemplateById(ITEMID) as ItemTemplateInfo;
         maxNumInBag = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(itemInfo.TemplateID);
         maxMoneyCount = int(PlayerManager.Instance.Self.Money / ONCE_BLESS_MONEY);
         this.titleText = LanguageMgr.GetTranslation("witchBlessing.view.title");
         _leftView = new Sprite();
         _rightView = new Sprite();
         lv1View = new WitchBlessingRightView(1,awardsNums[0],doubleMoney[0]);
         lv2View = new WitchBlessingRightView(2,awardsNums[1],doubleMoney[1]);
         lv3View = new WitchBlessingRightView(3,awardsNums[2],doubleMoney[2]);
         lv2View.visible = false;
         lv3View.visible = false;
         titleMc = ComponentFactory.Instance.creat("witchBlessing.titleMc");
         titleMc.gotoAndStop(1);
         PositionUtils.setPos(titleMc,"witchBlessing.titleMcPos");
         PositionUtils.setPos(_leftView,"witchBlessing.leftViewPos");
         PositionUtils.setPos(_rightView,"witchBlessing.rightViewPos");
         _bottom = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.frameBottom");
         var _leftBg:Bitmap = ComponentFactory.Instance.creat("asset.witchBlessing.leftBg");
         var _rightBg:Bitmap = ComponentFactory.Instance.creat("asset.witchBlessing.rightBg");
         var _rightViewBigBg:Bitmap = ComponentFactory.Instance.creat("asset.witchBlessing.rightViewBigBg");
         var _purpleBg:Bitmap = ComponentFactory.Instance.creat("asset.witchBlessing.purpleBg");
         var _nextTimeBg:Bitmap = ComponentFactory.Instance.creat("asset.witchBlessing.nextTimeBg");
         lv1Btn = ComponentFactory.Instance.creatComponentByStylename("blessingLv1.btn");
         lv2Btn = ComponentFactory.Instance.creatComponentByStylename("blessingLv2.btn");
         lv3Btn = ComponentFactory.Instance.creatComponentByStylename("blessingLv3.btn");
         _takeAwayTxt = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.takeAwayTxt");
         _takeAwayTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.takeAwayTxt",ServerConfigManager.instance.getWitchBlessGP[1]);
         _timeOpenTxt = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.timeOpenTxt");
         _timeOpenTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.timeOpenTxt",WitchBlessingManager.Instance.model.activityTime);
         _doubleTimeTxt = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.doubletimeOpenTxt");
         _doubleTimeTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.doubleBlessTimeTxt",ServerConfigManager.instance.getWitchBlessDoubleGpTime);
         PositionUtils.setPos(_doubleTimeTxt,"witchBlessing.doubleTimePos");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(lv1Btn);
         _btnGroup.addSelectItem(lv2Btn);
         _btnGroup.addSelectItem(lv3Btn);
         _btnGroup.selectIndex = 0;
         _progressTxtImage = ComponentFactory.Instance.creatBitmap("asset.witchBlessing.progressTxt");
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.witchBlessing.progressBg");
         _progressCover = ComponentFactory.Instance.creatBitmap("asset.witchBlessing.progress");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.progressTxt");
         _progressTxt.text = "0/0";
         _blessLvTxt = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.blessingLvTxt");
         blessBtn = ComponentFactory.Instance.creat("witchBlessing.blessBtn");
         blessHarderBtn = ComponentFactory.Instance.creat("witchBlessing.blessHarderBtn");
         _allIn = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.allIn");
         _allIn.text = LanguageMgr.GetTranslation("ddt.pets.risingStar.tisingStarTxt");
         _allIn.selected = true;
         cell = new BagCell(0,itemInfo,false,null,false);
         cell.setBgVisible(false);
         cell.setContentSize(62,62);
         cell.setCount(maxNumInBag);
         PositionUtils.setPos(cell,"witchBlessing.cellPos");
         talkBoxMc = ComponentFactory.Instance.creat("asset.witchBlessing.talkBoxMc");
         var talkTxt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.talkTxt");
         talkBoxMc.addChild(talkTxt);
         talkTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.doubleBlessing");
         talkBoxMc.visible = false;
         PositionUtils.setPos(talkBoxMc,"witchBlessing.talkBoxMcPos");
         _leftView.addChild(_leftBg);
         _leftView.addChild(_timeOpenTxt);
         _leftView.addChild(_doubleTimeTxt);
         _leftView.addChild(_progressTxtImage);
         _leftView.addChild(_progressBg);
         _leftView.addChild(_progressCover);
         _leftView.addChild(_progressTxt);
         _leftView.addChild(_blessLvTxt);
         _leftView.addChild(_allIn);
         _leftView.addChild(blessBtn);
         _leftView.addChild(blessHarderBtn);
         _leftView.addChild(cell);
         _leftView.addChild(talkBoxMc);
         _rightView.addChild(lv1Btn);
         _rightView.addChild(lv2Btn);
         _rightView.addChild(lv3Btn);
         _rightView.addChild(_rightViewBigBg);
         _rightView.addChild(_nextTimeBg);
         _rightView.addChild(lv1View);
         _rightView.addChild(lv2View);
         _rightView.addChild(lv3View);
         _rightView.addChild(titleMc);
         addToContent(_bottom);
         addToContent(_rightBg);
         addToContent(_leftView);
         addToContent(_rightView);
      }
      
      public function flushData() : void
      {
         var i:int = 0;
         talkBoxMc.visible = WitchBlessingManager.Instance.model.isDouble;
         var nowExp:int = WitchBlessingManager.Instance.model.totalExp;
         var viewArr:Array = [lv1View,lv2View,lv3View];
         for(i = 3; i > 0; )
         {
            if(nowExp == expArr[3])
            {
               nowLv = 3;
               needExp = 0;
               break;
            }
            if(nowExp < expArr[i] && nowExp >= expArr[i - 1])
            {
               nowLv = i - 1;
               needExp = expArr[i] - nowExp;
               break;
            }
            if(nowExp == expArr[0])
            {
               nowLv = 0;
               needExp = expArr[1];
               break;
            }
            i--;
         }
         if(WitchBlessingManager.Instance.model.isDouble)
         {
            allHarderBlessMax = Math.ceil((expArr[3] - nowExp) / (ONCE_HARDER_BLESS_EXP * 2));
            allBlessMax = Math.ceil((expArr[3] - nowExp) / (ONCE_BLESS_EXP * 2));
            if(nowLv != 3)
            {
               nextLvHarderBlessMax = Math.ceil((expArr[nowLv + 1] - nowExp) / (ONCE_HARDER_BLESS_EXP * 2));
               nextLvBlessMax = Math.ceil((expArr[nowLv + 1] - nowExp) / (ONCE_BLESS_EXP * 2));
            }
         }
         else
         {
            allHarderBlessMax = Math.ceil((expArr[3] - nowExp) / ONCE_HARDER_BLESS_EXP);
            allBlessMax = Math.ceil((expArr[3] - nowExp) / ONCE_BLESS_EXP);
            if(nowLv != 3)
            {
               nextLvHarderBlessMax = Math.ceil((expArr[nowLv + 1] - nowExp) / ONCE_HARDER_BLESS_EXP);
               nextLvBlessMax = Math.ceil((expArr[nowLv + 1] - nowExp) / ONCE_BLESS_EXP);
            }
         }
         flushEXP(nowExp);
         maxNumInBag = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(itemInfo.TemplateID);
         maxMoneyCount = int(PlayerManager.Instance.Self.Money / ONCE_BLESS_MONEY);
         cell.setCount(maxNumInBag);
         _blessLvTxt.text = nowLv + "";
         lv1View.flushGetAwardsTimes(WitchBlessingManager.Instance.model.lv1GetAwardsTimes);
         lv2View.flushGetAwardsTimes(WitchBlessingManager.Instance.model.lv2GetAwardsTimes);
         lv3View.flushGetAwardsTimes(WitchBlessingManager.Instance.model.lv3GetAwardsTimes);
         lv1View.flushCDTime(WitchBlessingManager.Instance.model.lv1CD);
         lv2View.flushCDTime(WitchBlessingManager.Instance.model.lv2CD);
         lv3View.flushCDTime(WitchBlessingManager.Instance.model.lv3CD);
      }
      
      private function flushEXP(nowExp:int) : void
      {
         var curHasExp:int = 0;
         var nowLvNeedExp:int = 0;
         if(nowLv == 3)
         {
            _progressTxt.text = "0/0";
            _progressCover.scaleX = 1;
         }
         else
         {
            curHasExp = nowExp - expArr[nowLv];
            nowLvNeedExp = curHasExp + needExp;
            _progressTxt.text = curHasExp + "/" + nowLvNeedExp;
            _progressCover.scaleX = curHasExp / nowLvNeedExp;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _btnGroup.addEventListener("change",__changeHandler);
         lv1Btn.addEventListener("click",__soundPlay);
         lv2Btn.addEventListener("click",__soundPlay);
         lv3Btn.addEventListener("click",__soundPlay);
         blessHarderBtn.addEventListener("click",__blessHarderFunc);
         blessBtn.addEventListener("click",__blessFunc);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__changeHandler);
         }
         if(lv1Btn)
         {
            lv1Btn.removeEventListener("click",__soundPlay);
         }
         if(lv2Btn)
         {
            lv2Btn.removeEventListener("click",__soundPlay);
         }
         if(lv3Btn)
         {
            lv3Btn.removeEventListener("click",__soundPlay);
         }
         if(blessHarderBtn)
         {
            blessHarderBtn.removeEventListener("click",__blessHarderFunc);
         }
         if(blessBtn)
         {
            blessBtn.removeEventListener("click",__blessFunc);
         }
      }
      
      private function __changeHandler(event:Event) : void
      {
         var index:int = _btnGroup.selectIndex + 1;
         hideRightAllView();
         titleMc.gotoAndStop(index);
         (this["lv" + index + "View"] as WitchBlessingRightView).visible = true;
      }
      
      private function __blessFunc(e:MouseEvent) : void
      {
         var sendNum:int = 0;
         if(nowLv == 3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("witchBlessing.view.nowLvIsThree"));
            return;
         }
         if(maxNumInBag > 0)
         {
            sendNum = 1;
            if(_allIn.selected)
            {
               sendNum = nextLvBlessMax;
            }
            SocketManager.Instance.out.sendWitchBless(sendNum);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("witchBlessing.view.youCannotBlessing"));
         }
      }
      
      private function __blessHarderFunc(e:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(nowLv == 3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("witchBlessing.view.nowLvIsThree"));
            return;
         }
         if(maxMoneyCount > 0)
         {
            _witchBlessingFrame = new WitchBlessingFrame();
            _witchBlessingFrame = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.WitchBlessingFrame");
            _witchBlessingFrame.addEventListener("response",__framResponse);
            _witchBlessingFrame.show(getNeedCount(),needExp,maxMoneyCount,nextLvHarderBlessMax);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("witchBlessing.view.doubleBlessingNoMoney"));
         }
      }
      
      private function __framResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               _witchBlessingFrame.dispose();
               break;
            case 2:
            case 3:
            case 4:
               SocketManager.Instance.out.sendWitchBless(_witchBlessingFrame.count,true);
               _witchBlessingFrame.dispose();
         }
      }
      
      private function getNeedCount() : int
      {
         var count:int = needExp / ONCE_BLESS_EXP;
         return count;
      }
      
      private function hideRightAllView() : void
      {
         lv1View.visible = false;
         lv2View.visible = false;
         lv3View.visible = false;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
      
      private function __soundPlay(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      override public function dispose() : void
      {
         SocketManager.Instance.out.witchBlessing_enter(1);
         super.dispose();
         removeEvent();
         lv1View.dispose();
         lv2View.dispose();
         lv3View.dispose();
         ObjectUtils.disposeAllChildren(this);
         WitchBlessingManager.Instance.hide();
         if(_leftView)
         {
            _leftView = null;
         }
         if(_rightView)
         {
            _rightView = null;
         }
         if(_bottom)
         {
            _bottom = null;
         }
         if(_btnGroup)
         {
            _btnGroup = null;
         }
         if(lv1Btn)
         {
            lv1Btn = null;
         }
         if(lv2Btn)
         {
            lv2Btn = null;
         }
         if(lv3Btn)
         {
            lv3Btn = null;
         }
         if(lv1View)
         {
            lv1View = null;
         }
         if(lv2View)
         {
            lv2View = null;
         }
         if(lv3View)
         {
            lv3View = null;
         }
         if(titleMc)
         {
            titleMc = null;
         }
         if(_awardsTxt)
         {
            _awardsTxt = null;
         }
         if(_takeAwayTxt)
         {
            _takeAwayTxt = null;
         }
         if(_timeOpenTxt)
         {
            _timeOpenTxt = null;
         }
         if(_doubleTimeTxt)
         {
            _doubleTimeTxt = null;
         }
         if(_progressTxtImage)
         {
            _progressTxtImage = null;
         }
         if(_progressBg)
         {
            _progressBg = null;
         }
         if(_progressCover)
         {
            _progressCover = null;
         }
         if(_progressTxt)
         {
            _progressTxt = null;
         }
         if(_blessLvTxt)
         {
            _blessLvTxt = null;
         }
         if(blessBtn)
         {
            blessBtn = null;
         }
         if(talkBoxMc)
         {
            talkBoxMc = null;
         }
         if(blessHarderBtn)
         {
            blessHarderBtn = null;
         }
         if(_witchBlessingFrame && _witchBlessingFrame.parent)
         {
            _witchBlessingFrame.parent.removeChild(_witchBlessingFrame);
            _witchBlessingFrame = null;
         }
         if(itemInfo)
         {
            itemInfo = null;
         }
         if(cell)
         {
            cell = null;
         }
      }
   }
}
