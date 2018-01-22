package farm.viewx.poultry
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TreeUpgradeWater extends Sprite implements Disposeable
   {
       
      
      private var _levelNum:int;
      
      private var _title:Bitmap;
      
      private var _level:FilterFrameText;
      
      private var _loadingBg:Bitmap;
      
      private var _loading:MovieClip;
      
      private var _exp:FilterFrameText;
      
      private var _checkBox:SelectedCheckButton;
      
      private var _waterBtn:BaseButton;
      
      private var _currentExp:Number;
      
      private var _totalExp:Number;
      
      private var _loveNum:int;
      
      private var _frameIndex:int;
      
      private var _isUpgrade:Boolean;
      
      public function TreeUpgradeWater()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creat("asset.farm.treeUpgrade.water");
         addChild(_title);
         _level = ComponentFactory.Instance.creatComponentByStylename("farm.tree.levelTxt2");
         addChild(_level);
         _loadingBg = ComponentFactory.Instance.creat("asset.farm.treeUpgrade.loadingBg");
         addChild(_loadingBg);
         _loading = ComponentFactory.Instance.creat("asset.farm.treeUpgrade.waterLoading");
         PositionUtils.setPos(_loading,"farm.treeUpgrade.waterLoading");
         addChild(_loading);
         _loading.stop();
         _exp = ComponentFactory.Instance.creatComponentByStylename("farm.tree.treeExpTxt");
         addChild(_exp);
         _checkBox = ComponentFactory.Instance.creatComponentByStylename("farm.tree.checkBox");
         addChild(_checkBox);
         _checkBox.text = LanguageMgr.GetTranslation("farm.tree.upgradeWater.checkBoxText");
         _checkBox.selected = true;
         _waterBtn = ComponentFactory.Instance.creatComponentByStylename("farm.treeUpgradeView.waterBtn");
         _waterBtn.tipData = LanguageMgr.GetTranslation("farm.tree.upgradeWaterBtn.tipsText");
         addChild(_waterBtn);
      }
      
      private function initEvent() : void
      {
         _waterBtn.addEventListener("click",__onWaterBtnClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,32),__onWater);
      }
      
      protected function __onWater(param1:PkgEvent) : void
      {
         if(_checkBox.selected || _frameIndex == 105)
         {
            setLoadingFrame();
         }
         else
         {
            _loading.gotoAndStop(_frameIndex);
            _loading.loading.gotoAndStop(_frameIndex);
            SocketManager.Instance.out.initFarmTree();
         }
      }
      
      protected function __onWaterBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _waterBtn.enable = false;
         var _loc2_:int = 1;
         var _loc3_:int = _totalExp - _currentExp;
         if(_loveNum > 0)
         {
            if(_checkBox.selected)
            {
               _loc2_ = Math.min(_loveNum,_loc3_);
            }
            frameIndex = (_currentExp + 1) * 105 / _totalExp;
            if(_checkBox.selected && _loveNum >= _loc3_)
            {
               _isUpgrade = true;
               frameIndex = 105;
            }
            SocketManager.Instance.out.farmWater(_loc2_);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.farmTree.waterNotNeedTipsTxt"));
         }
      }
      
      public function setLevelNum(param1:int) : void
      {
         _levelNum = param1;
         _level.text = LanguageMgr.GetTranslation("ddt.cardSystem.CardEquipView.levelText") + _levelNum;
      }
      
      public function setExp(param1:Number, param2:Number) : void
      {
         _currentExp = param1;
         _totalExp = param2;
         _exp.text = _currentExp + "/" + _totalExp;
         _waterBtn.enable = _levelNum < FarmModelController.MAXLEVEL;
         frameIndex = _currentExp * 105 / _totalExp;
         _loading.gotoAndStop(_frameIndex);
         _loading.loading.gotoAndStop(_frameIndex);
      }
      
      public function setLoveNum(param1:int) : void
      {
         _loveNum = param1;
      }
      
      private function setLoadingFrame() : void
      {
         FarmModelController.instance.dispatchEvent(new FarmEvent("farmPoultry_upgrading",[true]));
         _loading.gotoAndPlay(_loading.currentFrame);
         _loading.loading.gotoAndPlay(_loading.currentFrame);
         addEventListener("enterFrame",__onEnterFrame);
      }
      
      protected function __onEnterFrame(param1:Event) : void
      {
         if(_frameIndex < 105 && _loading.currentFrame >= _frameIndex || _loading.currentFrame == _loading.totalFrames)
         {
            FarmModelController.instance.dispatchEvent(new FarmEvent("farmPoultry_upgrading",[false]));
            if(_frameIndex < 105 && _loading.currentFrame >= _frameIndex)
            {
               _loading.gotoAndStop(_frameIndex);
               _loading.loading.gotoAndStop(_frameIndex);
            }
            removeEventListener("enterFrame",__onEnterFrame);
            SocketManager.Instance.out.initFarmTree();
            if(_isUpgrade)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.farmUpgrade.waterUpgrade",_levelNum + 1));
            }
         }
      }
      
      private function set frameIndex(param1:int) : void
      {
         if(param1 == 0)
         {
            _loading.visible = false;
            _frameIndex = 1;
         }
         else
         {
            _loading.visible = true;
            _frameIndex = param1;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__onEnterFrame);
         SocketManager.Instance.removeEventListener(PkgEvent.format(81,32),__onWater);
         if(_waterBtn)
         {
            _waterBtn.removeEventListener("click",__onWaterBtnClick);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_title)
         {
            _title.bitmapData.dispose();
            _title = null;
         }
         if(_loadingBg)
         {
            _loadingBg.bitmapData.dispose();
            _loadingBg = null;
         }
         if(_level)
         {
            _level.dispose();
            _level = null;
         }
         if(_exp)
         {
            _exp.dispose();
            _exp = null;
         }
         if(_checkBox)
         {
            _checkBox.dispose();
            _checkBox = null;
         }
         if(_loading)
         {
            _loading.gotoAndStop(1);
            ObjectUtils.disposeAllChildren(_loading);
            _loading = null;
         }
         if(_waterBtn)
         {
            _waterBtn.dispose();
            _waterBtn = null;
         }
      }
   }
}
