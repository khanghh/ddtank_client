package bagAndInfo.bag.ring
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.bag.ring.data.RingSystemData;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionSkillInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class RingSystemView extends Frame
   {
       
      
      private var _helpBtn:BaseButton;
      
      private var _bg:Bitmap;
      
      private var _progress:RingSystemLevel;
      
      private var _ringCell:BagCell;
      
      private var _currentData:FilterFrameText;
      
      private var _nextData:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _coupleNum:RingSystemFilterInfo;
      
      private var _dungeonNum:RingSystemFilterInfo;
      
      private var _propsNum:RingSystemFilterInfo;
      
      private var _skill:ScaleFrameImage;
      
      public function RingSystemView()
      {
         super();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.titleText");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystem.helpBtn");
         addToContent(_helpBtn);
         _bg = ComponentFactory.Instance.creat("asset.bagAndInfo.bag.RingSystemView.bg");
         addToContent(_bg);
         _progress = new RingSystemLevel();
         PositionUtils.setPos(_progress,"bagAndInfo.RingSystem.ProgressPos");
         addToContent(_progress);
         _ringCell = new BagCell(0,PlayerManager.Instance.Self.Bag.items[16]);
         _ringCell.setBgVisible(false);
         _ringCell.setContentSize(70,70);
         _ringCell.deleteEnchantMc();
         PositionUtils.setPos(_ringCell,"bagAndInfo.RingSystem.ringPos");
         addToContent(_ringCell);
         _currentData = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.currentData");
         addToContent(_currentData);
         _nextData = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.nextData");
         addToContent(_nextData);
         _skill = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.skill");
         _skill.width = 56;
         _skill.height = 56;
         addToContent(_skill);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.infoText");
         _infoText.text = LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.infoText2");
         PositionUtils.setPos(_infoText,"bagAndInfo.RingSystem.skillPos");
         addToContent(_infoText);
         _coupleNum = new RingSystemFilterInfo(1);
         PositionUtils.setPos(_coupleNum,"bagAndInfo.RingSystem.couplePos");
         addToContent(_coupleNum);
         _dungeonNum = new RingSystemFilterInfo(2);
         PositionUtils.setPos(_dungeonNum,"bagAndInfo.RingSystem.dungeonPos");
         addToContent(_dungeonNum);
         _propsNum = new RingSystemFilterInfo(2);
         PositionUtils.setPos(_propsNum,"bagAndInfo.RingSystem.propsPos");
         addToContent(_propsNum);
         setViewInfo();
         setSkillTipData();
      }
      
      private function initEvent() : void
      {
         _helpBtn.addEventListener("click",__onHelpClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onUpdateProperty);
      }
      
      protected function __onHelpClick(param1:MouseEvent) : void
      {
         HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),ComponentFactory.Instance.creat("asset.bagAndInfo.bag.RingSystem.heopInfo"),408,488);
      }
      
      protected function setViewInfo() : void
      {
         var _loc3_:RingSystemData = BagAndInfoManager.Instance.getCurrentRingData();
         _currentData.text = _loc3_.Attack + "%\n" + _loc3_.Defence + "%\n" + _loc3_.Agility + "%\n" + _loc3_.Luck + "%";
         var _loc1_:RingSystemData = BagAndInfoManager.Instance.RingData[_loc3_.Level + 1];
         if(_loc1_ != null)
         {
            _nextData.text = _loc1_.Attack + "%\n" + _loc1_.Defence + "%\n" + _loc1_.Agility + "%\n" + _loc1_.Luck + "%";
         }
         else
         {
            PlayerManager.Instance.Self.RingExp = _loc3_.Exp;
         }
         var _loc2_:int = !!_loc1_?_loc1_.Exp:int(_loc3_.Exp);
         _progress.setProgress(PlayerManager.Instance.Self.RingExp - _loc3_.Exp,_loc3_.Level,_loc2_ - _loc3_.Exp);
      }
      
      private function setSkillTipData() : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:int = BagAndInfoManager.Instance.getCurrentRingData().Level / 10;
         if(_loc1_ == 0)
         {
            _loc2_ = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0,1)[0];
            _loc4_ = {};
            _loc4_["name"] = _loc2_.name;
            _loc4_["content"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.notGet");
         }
         else
         {
            _loc2_ = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0,_loc1_)[0];
            _loc4_ = {};
            _loc4_["name"] = _loc2_.name + "Lv" + _loc1_;
            _loc4_["content"] = _loc2_.descript.replace("{0}",_loc2_.value);
         }
         if(_loc1_ < RingSystemData.TotalLevel * 0.1)
         {
            _loc3_ = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0,_loc1_ + 1)[0];
            _loc4_["nextLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.nextLevel",_loc3_.name,_loc1_ + 1,_loc3_.descript.replace("{0}",_loc3_.value));
            _loc4_["limitLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.nextUnLock",(_loc1_ + 1) * 10);
         }
         else
         {
            _loc4_["nextLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.fullLevel");
            _loc4_["limitLevel"] = "";
         }
         _skill.tipData = _loc4_;
         if(_loc1_ <= 0)
         {
            _skill.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      private function __onUpdateProperty(param1:PlayerPropertyEvent) : void
      {
         var _loc2_:* = null;
         if(param1.changedProperties["ringUseNum"])
         {
            _loc2_ = PlayerManager.Instance.Self.ringUseNum;
            _coupleNum.setInfoText({
               "info":getSurplusCount(_loc2_[0],20) + "/20",
               "tipData":LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.infoText3")
            });
            _dungeonNum.setInfoText({
               "info":getSurplusCount(_loc2_[1],4) + "/4",
               "tipData":LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.infoText4")
            });
            _propsNum.setInfoText({
               "info":getSurplusCount(_loc2_[2],5) + "/5",
               "tipData":LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.infoText5")
            });
         }
      }
      
      private function getSurplusCount(param1:int, param2:int) : int
      {
         return param2 - param1;
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.getPlayerSpecialProperty(2);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onUpdateProperty);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
