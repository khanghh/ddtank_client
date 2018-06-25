package farm.viewx.poultry
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   
   public class FarmTreeUpgrade extends BaseAlerFrame
   {
       
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _bg:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _titleImage:MutipleImage;
      
      private var _loveBg:BaseButton;
      
      private var _loveNum:FilterFrameText;
      
      private var _callBtn:BaseButton;
      
      private var _levelNum:int;
      
      private var _control:DisplayObject;
      
      private var _upgradingFlag:Boolean;
      
      public function FarmTreeUpgrade()
      {
         super();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.initFarmTree();
      }
      
      private function initView() : void
      {
         escEnable = true;
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"farm.treeUpgradeView.helpBtn",null,LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),"farm.treeUpgrade.helpInfo",408,488) as SimpleBitmapButton;
         _titleImage = ComponentFactory.Instance.creatComponentByStylename("farm.treeUpgradeView.title");
         addToContent(_titleImage);
         _bg = ComponentFactory.Instance.creat("asset.farm.treeUpgrade.Bg");
         addToContent(_bg);
         _bg2 = ComponentFactory.Instance.creat("asset.farm.treeUpgrade.Bg2");
         addToContent(_bg2);
         _loveBg = ComponentFactory.Instance.creatComponentByStylename("farm.treeUpgradeView.loveNumBg");
         _loveBg.tipData = LanguageMgr.GetTranslation("farm.farmUpgrade.loveNumTipsTxt");
         addToContent(_loveBg);
         _loveNum = ComponentFactory.Instance.creatComponentByStylename("farm.tree.loveNumTxt");
         addToContent(_loveNum);
         _callBtn = ComponentFactory.Instance.creatComponentByStylename("farm.treeUpgradeView.callBtn");
         _callBtn.tipData = LanguageMgr.GetTranslation("farm.farmUpgrade.callBtnTxt");
         addToContent(_callBtn);
         if(FarmModelController.instance.model.PoultryState > 0)
         {
            _callBtn.enable = false;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__closeFarm);
         _callBtn.addEventListener("click",__onCallBtnClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,22),__onInitData);
         FarmModelController.instance.addEventListener("farmPoultry_setCallBtn",__onSetCallBtnEnable);
         FarmModelController.instance.addEventListener("farmPoultry_upgrading",__onUpgrading);
      }
      
      protected function __onUpgrading(event:FarmEvent) : void
      {
         _upgradingFlag = event.obj[0];
      }
      
      protected function __onSetCallBtnEnable(event:FarmEvent) : void
      {
         _callBtn.enable = false;
      }
      
      protected function __onInitData(event:PkgEvent) : void
      {
         var needExp:int = 0;
         var pkg:PackageIn = event.pkg;
         _levelNum = pkg.readInt();
         var loveNum:int = pkg.readInt();
         var treeExp:int = pkg.readInt() - FarmModelController.instance.model.farmPoultryInfo[_levelNum].Exp;
         var condenserExp:int = pkg.readInt();
         var needCondenserExp:int = FarmModelController.instance.model.farmPoultryInfo[_levelNum].CostExp;
         FarmModelController.instance.model.FarmTreeLevel = _levelNum;
         FarmModelController.instance.dispatchEvent(new FarmEvent("farmTree_updateTreeLevel"));
         _loveNum.text = loveNum.toString();
         if(_levelNum > 0 && _levelNum % 10 == 0 && treeExp == 0 && condenserExp < needCondenserExp)
         {
            if(_control)
            {
               if(_control is TreeUpgradeWater)
               {
                  TreeUpgradeWater(_control).dispose();
                  _control = new TreeUpgradeCondenser();
               }
            }
            else
            {
               _control = new TreeUpgradeCondenser();
            }
            TreeUpgradeCondenser(_control).setExp(condenserExp,needCondenserExp,_levelNum);
         }
         else
         {
            if(_control)
            {
               if(_control is TreeUpgradeCondenser)
               {
                  TreeUpgradeCondenser(_control).dispose();
                  _control = new TreeUpgradeWater();
               }
            }
            else
            {
               _control = new TreeUpgradeWater();
            }
            needExp = 0;
            if(_levelNum >= FarmModelController.MAXLEVEL)
            {
               needExp = 1;
               treeExp = 1;
            }
            else
            {
               needExp = FarmModelController.instance.model.farmPoultryInfo[_levelNum + 1].Exp - FarmModelController.instance.model.farmPoultryInfo[_levelNum].Exp;
            }
            TreeUpgradeWater(_control).setLevelNum(_levelNum);
            TreeUpgradeWater(_control).setExp(treeExp,needExp);
            TreeUpgradeWater(_control).setLoveNum(loveNum);
         }
         PositionUtils.setPos(_control,"asset.farm.controlPos");
         addToContent(_control);
      }
      
      protected function __onCallBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var callView:CallPoultryView = ComponentFactory.Instance.creatComponentByStylename("farm.poultry.callView");
         LayerManager.Instance.addToLayer(callView,2,true,1);
      }
      
      protected function __onHelpBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),ComponentFactory.Instance.creatCustomObject("farm.treeUpgrade.helpInfo"),408,488);
      }
      
      private function __closeFarm(event:FrameEvent) : void
      {
         if(!_upgradingFlag)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__closeFarm);
         _callBtn.removeEventListener("click",__onCallBtnClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(81,22),__onInitData);
         FarmModelController.instance.removeEventListener("farmPoultry_setCallBtn",__onSetCallBtnEnable);
         FarmModelController.instance.removeEventListener("farmPoultry_upgrading",__onUpgrading);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_bg2)
         {
            _bg2.bitmapData.dispose();
            _bg2 = null;
         }
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
            _helpBtn = null;
         }
         if(_loveBg)
         {
            _loveBg.dispose();
            _loveBg = null;
         }
         if(_titleImage)
         {
            _titleImage.dispose();
            _titleImage = null;
         }
         if(_loveNum)
         {
            _loveNum.dispose();
            _loveNum = null;
         }
         if(_callBtn)
         {
            _callBtn.dispose();
            _callBtn = null;
         }
         super.dispose();
      }
   }
}
