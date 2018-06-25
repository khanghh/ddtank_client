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
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.horse.HorseFrameRightBottomItemCell;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TreeUpgradeCondenser extends Sprite implements Disposeable
   {
       
      
      private var _title:Bitmap;
      
      private var _loadingBg:Bitmap;
      
      private var _loading:MovieClip;
      
      private var _exp:FilterFrameText;
      
      private var _checkBox:SelectedCheckButton;
      
      private var _condenserBtn:BaseButton;
      
      private var _itemCell:HorseFrameRightBottomItemCell;
      
      private var _currentExp:Number;
      
      private var _totalExp:Number;
      
      private var _frameIndex:int;
      
      private var _isUpgrade:Boolean;
      
      public function TreeUpgradeCondenser()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creat("asset.farm.treeUpgrade.condenserTitle");
         addChild(_title);
         _loadingBg = ComponentFactory.Instance.creat("asset.farm.treeUpgrade.loadingBg");
         addChild(_loadingBg);
         _loading = ComponentFactory.Instance.creat("asset.farm.treeUpgrade.consenderLoading");
         PositionUtils.setPos(_loading,"farm.treeUpgrade.consenderLoading");
         addChild(_loading);
         _loading.stop();
         _exp = ComponentFactory.Instance.creatComponentByStylename("farm.tree.treeExpTxt");
         addChild(_exp);
         _checkBox = ComponentFactory.Instance.creatComponentByStylename("farm.tree.checkBox");
         PositionUtils.setPos(_checkBox,"farm.treeUpgrade.condenserView.checkBoxPos");
         addChild(_checkBox);
         _checkBox.text = LanguageMgr.GetTranslation("farm.tree.upgradeCondenser.checkBoxText");
         _checkBox.selected = true;
         _condenserBtn = ComponentFactory.Instance.creatComponentByStylename("farm.treeUpgradeView.condenserBtn");
         _condenserBtn.tipData = LanguageMgr.GetTranslation("farm.tree.upgradeCondenserBtn.tipsText");
         addChild(_condenserBtn);
         _itemCell = new HorseFrameRightBottomItemCell(11957,1195701);
         PositionUtils.setPos(_itemCell,"farm.treeUpgrade.condenserView.itemCellPos");
         addChild(_itemCell);
      }
      
      private function initEvent() : void
      {
         _condenserBtn.addEventListener("click",__onCondenserBtnClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,25),__onCondenser);
      }
      
      protected function __onCondenser(event:PkgEvent) : void
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
      
      public function setExp(currentExp:Number, totalExp:Number, levelNum:int) : void
      {
         _currentExp = currentExp;
         _totalExp = totalExp;
         _exp.text = _currentExp + "/" + _totalExp;
         _condenserBtn.enable = true;
         frameIndex = _currentExp * 105 / _totalExp;
         _loading.gotoAndStop(_frameIndex);
         _loading.loading.gotoAndStop(_frameIndex);
      }
      
      private function setLoadingFrame() : void
      {
         FarmModelController.instance.dispatchEvent(new FarmEvent("farmPoultry_upgrading",[true]));
         _loading.gotoAndPlay(_loading.currentFrame);
         _loading.loading.gotoAndPlay(_loading.currentFrame);
         addEventListener("enterFrame",__onEnterFrame);
      }
      
      protected function __onEnterFrame(event:Event) : void
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
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.farmUpgrade.condenserUpgrade"));
            }
         }
      }
      
      protected function __onCondenserBtnClick(event:MouseEvent) : void
      {
         var num:int = 1;
         var needNum:int = (_totalExp - _currentExp) / 10;
         var hasNum:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11957);
         if(hasNum > 0)
         {
            SoundManager.instance.playButtonSound();
            _condenserBtn.enable = false;
            if(_checkBox.selected)
            {
               num = Math.min(hasNum,needNum);
            }
            frameIndex = (_currentExp + num * 10) * 105 / _totalExp;
            if(_checkBox.selected && hasNum >= needNum)
            {
               _isUpgrade = true;
               frameIndex = 105;
            }
            SocketManager.Instance.out.farmCondenser(num);
         }
         else
         {
            _itemCell.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function set frameIndex(value:int) : void
      {
         if(value == 0)
         {
            _loading.visible = false;
            _frameIndex = 1;
         }
         else
         {
            _loading.visible = true;
            _frameIndex = value;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__onEnterFrame);
         SocketManager.Instance.removeEventListener(PkgEvent.format(81,25),__onCondenser);
         if(_condenserBtn)
         {
            _condenserBtn.removeEventListener("click",__onCondenserBtnClick);
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
         if(_condenserBtn)
         {
            _condenserBtn.dispose();
            _condenserBtn = null;
         }
         if(_loading)
         {
            _loading.gotoAndStop(1);
            ObjectUtils.disposeAllChildren(_loading);
            _loading = null;
         }
         if(_itemCell)
         {
            _itemCell.dispose();
            _itemCell = null;
         }
      }
   }
}
