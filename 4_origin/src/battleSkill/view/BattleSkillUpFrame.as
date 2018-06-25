package battleSkill.view
{
   import baglocked.BaglockedManager;
   import battleSkill.BattleSkillManager;
   import battleSkill.BattleSkillOptionType;
   import battleSkill.event.BattleSkillEvent;
   import battleSkill.info.BattleSkillSkillInfo;
   import battleSkill.info.BattleSkillUpdateInfo;
   import battleSkill.info.BattleSkillUpdateMaterialInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class BattleSkillUpFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _activateMaterialImgTxt:Bitmap;
      
      private var _updateMaterialImgTxt:Bitmap;
      
      private var _activateBtn:BaseButton;
      
      private var _updateBtn:BaseButton;
      
      private var _curInfo:BattleSkillSkillInfo;
      
      private var _nextInfo:BattleSkillSkillInfo;
      
      private var _type:int;
      
      private var _curSkillLevTxt:FilterFrameText;
      
      private var _NextSkillLevTxt:FilterFrameText;
      
      private var _materialHBox:HBox;
      
      private var _curSkillCell:BattleSkillCell;
      
      private var _nextSkillCell:BattleSkillCell;
      
      private var _isCanUp:Boolean = false;
      
      private var _lastUpClickTime:int = 0;
      
      private var _materialCell:BattleSkillMaterialCell;
      
      public function BattleSkillUpFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _type = BattleSkillOptionType.UPDATE;
         _isCanUp = false;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.battleSkill.update.bg");
         addToContent(_bg);
         _activateMaterialImgTxt = ComponentFactory.Instance.creatBitmap("asset.battleSkill.activateNeedMaterial");
         addToContent(_activateMaterialImgTxt);
         _updateMaterialImgTxt = ComponentFactory.Instance.creatBitmap("asset.battleSkill.updateNeedMaterial");
         addToContent(_updateMaterialImgTxt);
         _updateBtn = ComponentFactory.Instance.creatComponentByStylename("battleSkill.updateBigBtn");
         addToContent(_updateBtn);
         _activateBtn = ComponentFactory.Instance.creatComponentByStylename("battleSkill.activateBigBtn");
         addToContent(_activateBtn);
         _curSkillLevTxt = ComponentFactory.Instance.creatComponentByStylename("battleSkill.upSkill.curSkillLevelTxt");
         addToContent(_curSkillLevTxt);
         _NextSkillLevTxt = ComponentFactory.Instance.creatComponentByStylename("battleSkill.upSkill.NextSkillLevelTxt");
         addToContent(_NextSkillLevTxt);
         _materialHBox = ComponentFactory.Instance.creatComponentByStylename("battleSkill.updateSkill.materialCell");
         addToContent(_materialHBox);
         _curSkillCell = new BattleSkillCell();
         _curSkillCell.x = 80;
         _curSkillCell.y = 50;
         addToContent(_curSkillCell);
         _nextSkillCell = new BattleSkillCell();
         _nextSkillCell.x = 211;
         _nextSkillCell.y = 50;
         addToContent(_nextSkillCell);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _updateBtn.addEventListener("click",updateSkill_Handler);
         _activateBtn.addEventListener("click",updateSkill_Handler);
         BattleSkillManager.instance.addEventListener(BattleSkillEvent.UPDATE_SKILL,refreshView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _updateBtn.removeEventListener("click",updateSkill_Handler);
         _activateBtn.removeEventListener("click",updateSkill_Handler);
         BattleSkillManager.instance.removeEventListener(BattleSkillEvent.UPDATE_SKILL,refreshView);
      }
      
      private function refreshView(evt:BattleSkillEvent) : void
      {
         var str:* = null;
         if(_type == BattleSkillOptionType.UPDATE)
         {
            str = "ddt.battleSkill.UpSuccess";
            §§push("ddt.battleSkill.UpSuccess");
         }
         else
         {
            str = "ddt.battleSkill.ActivateSuccess";
            §§push("ddt.battleSkill.ActivateSuccess");
         }
         §§pop();
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(str));
         _type = BattleSkillOptionType.UPDATE;
         var skillId:int = evt.data as int;
         _curInfo = BattleSkillManager.instance.getBattleSKillInfoBySkillID(skillId);
         updateView();
      }
      
      private function updateSkill_Handler(evt:MouseEvent) : void
      {
         if(getTimer() - _lastUpClickTime <= 1000)
         {
            return;
         }
         _lastUpClickTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         BattleSkillManager.instance.sendUpSkill(_curInfo.SkillID);
      }
      
      public function show(info:BattleSkillSkillInfo, type:int) : void
      {
         _curInfo = info;
         _type = type;
         updateView();
      }
      
      private function updateView() : void
      {
         if(_type == BattleSkillOptionType.UPDATE)
         {
            titleText = LanguageMgr.GetTranslation("ddt.battleSkill.skillUp");
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("ddt.battleSkill.skillActivate");
         }
         updateSkillCell();
         updateMaterialCell();
         updateState();
      }
      
      private function updateState() : void
      {
         var isUp:* = _type == BattleSkillOptionType.UPDATE;
         _updateMaterialImgTxt.visible = isUp;
         _updateBtn.visible = isUp;
         var _loc2_:* = !isUp;
         _activateBtn.visible = _loc2_;
         _activateMaterialImgTxt.visible = _loc2_;
         _curSkillCell.filters = !!isUp?null:ComponentFactory.Instance.creatFilters("grayFilter");
         if(_isCanUp)
         {
            _updateBtn.filters = null;
            _updateBtn.enable = true;
            _activateBtn.filters = null;
            _activateBtn.enable = true;
         }
         else
         {
            _updateBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _updateBtn.enable = false;
            _activateBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _activateBtn.enable = false;
         }
      }
      
      private function updateSkillCell() : void
      {
         if(_type == BattleSkillOptionType.ACTIVATE)
         {
            _nextInfo = _curInfo;
            _curSkillLevTxt.text = "LV.0";
            _NextSkillLevTxt.text = "LV." + _nextInfo.Level;
         }
         else
         {
            _nextInfo = BattleSkillManager.instance.getNextlevelSkillInfo(_curInfo.SkillID);
            _curSkillLevTxt.text = "LV." + _curInfo.Level;
            if(_nextInfo == null)
            {
               _NextSkillLevTxt.text = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.fullLevel");
               _nextInfo = _curInfo;
            }
            else
            {
               _NextSkillLevTxt.text = "LV." + _nextInfo.Level;
            }
         }
         _curSkillCell.info = _curInfo;
         _nextSkillCell.info = _nextInfo;
      }
      
      private function updateMaterialCell() : void
      {
         if(_materialHBox && _materialHBox.numChildren > 0)
         {
            ObjectUtils.disposeAllChildren(_materialHBox);
         }
         var upInfo:BattleSkillUpdateInfo = BattleSkillManager.instance.getUpMaterialArr(_nextInfo.SkillID);
         _isCanUp = true;
         if(upInfo == null)
         {
            return;
         }
         var len:int = upInfo.UpdateMaterialInfo.length;
         var index:int = 0;
         var haveCount:int = 0;
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var _loc9_:int = 0;
         var _loc8_:* = upInfo.UpdateMaterialInfo;
         for each(var materialInfo in upInfo.UpdateMaterialInfo)
         {
            haveCount = bagInfo.getItemCountByTemplateId(materialInfo.TemplateID);
            _materialCell = new BattleSkillMaterialCell(materialInfo.TemplateID,materialInfo.Count,haveCount,materialInfo.OrderID);
            _materialHBox.addChild(_materialCell);
            if(haveCount < materialInfo.Count)
            {
               _isCanUp = false;
            }
         }
         var temX:* = _bg.width - _materialHBox.width >> 1;
         _materialHBox.x = temX;
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _isCanUp = false;
         super.dispose();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         if(_activateMaterialImgTxt)
         {
            ObjectUtils.disposeObject(_activateMaterialImgTxt);
         }
         if(_updateMaterialImgTxt)
         {
            ObjectUtils.disposeObject(_updateMaterialImgTxt);
         }
         if(_activateBtn)
         {
            ObjectUtils.disposeObject(_activateBtn);
         }
         if(_updateBtn)
         {
            ObjectUtils.disposeObject(_updateBtn);
         }
         if(_curSkillLevTxt)
         {
            ObjectUtils.disposeObject(_curSkillLevTxt);
         }
         if(_NextSkillLevTxt)
         {
            ObjectUtils.disposeObject(_NextSkillLevTxt);
         }
         if(_materialHBox)
         {
            ObjectUtils.disposeAllChildren(_materialHBox);
            ObjectUtils.disposeObject(_materialHBox);
         }
         if(_curSkillCell)
         {
            ObjectUtils.disposeObject(_curSkillCell);
         }
         if(_nextSkillCell)
         {
            ObjectUtils.disposeObject(_nextSkillCell);
         }
         _bg = null;
         _activateMaterialImgTxt = null;
         _updateMaterialImgTxt = null;
         _activateBtn = null;
         _updateBtn = null;
         _curInfo = null;
         _nextInfo = null;
         _curSkillLevTxt = null;
         _NextSkillLevTxt = null;
         _materialHBox = null;
         _curSkillCell = null;
         _nextSkillCell = null;
         _isCanUp = false;
         if(this && this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
