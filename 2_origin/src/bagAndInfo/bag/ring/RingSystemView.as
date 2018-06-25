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
      
      protected function __onHelpClick(event:MouseEvent) : void
      {
         HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),ComponentFactory.Instance.creat("asset.bagAndInfo.bag.RingSystem.heopInfo"),408,488);
      }
      
      protected function setViewInfo() : void
      {
         var data:RingSystemData = BagAndInfoManager.Instance.getCurrentRingData();
         _currentData.text = data.Attack + "%\n" + data.Defence + "%\n" + data.Agility + "%\n" + data.Luck + "%";
         var nextData:RingSystemData = BagAndInfoManager.Instance.RingData[data.Level + 1];
         if(nextData != null)
         {
            _nextData.text = nextData.Attack + "%\n" + nextData.Defence + "%\n" + nextData.Agility + "%\n" + nextData.Luck + "%";
         }
         else
         {
            PlayerManager.Instance.Self.RingExp = data.Exp;
         }
         var nexExp:int = !!nextData?nextData.Exp:int(data.Exp);
         _progress.setProgress(PlayerManager.Instance.Self.RingExp - data.Exp,data.Level,nexExp - data.Exp);
      }
      
      private function setSkillTipData() : void
      {
         var level:* = null;
         var obj:* = null;
         var nextLevel:* = null;
         var skillLevel:int = BagAndInfoManager.Instance.getCurrentRingData().Level / 10;
         if(skillLevel == 0)
         {
            level = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0,1)[0];
            obj = {};
            obj["name"] = level.name;
            obj["content"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.notGet");
         }
         else
         {
            level = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0,skillLevel)[0];
            obj = {};
            obj["name"] = level.name + "Lv" + skillLevel;
            obj["content"] = level.descript.replace("{0}",level.value);
         }
         if(skillLevel < RingSystemData.TotalLevel * 0.1)
         {
            nextLevel = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(0,skillLevel + 1)[0];
            obj["nextLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.nextLevel",nextLevel.name,skillLevel + 1,nextLevel.descript.replace("{0}",nextLevel.value));
            obj["limitLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.nextUnLock",(skillLevel + 1) * 10);
         }
         else
         {
            obj["nextLevel"] = LanguageMgr.GetTranslation("tank.bagAndInfo.ringSkill.fullLevel");
            obj["limitLevel"] = "";
         }
         _skill.tipData = obj;
         if(skillLevel <= 0)
         {
            _skill.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      private function __onUpdateProperty(event:PlayerPropertyEvent) : void
      {
         var obj:* = null;
         if(event.changedProperties["ringUseNum"])
         {
            obj = PlayerManager.Instance.Self.ringUseNum;
            _coupleNum.setInfoText({
               "info":getSurplusCount(obj[0],20) + "/20",
               "tipData":LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.infoText3")
            });
            _dungeonNum.setInfoText({
               "info":getSurplusCount(obj[1],4) + "/4",
               "tipData":LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.infoText4")
            });
            _propsNum.setInfoText({
               "info":getSurplusCount(obj[2],5) + "/5",
               "tipData":LanguageMgr.GetTranslation("ddt.bagandinfo.ringSystem.infoText5")
            });
         }
      }
      
      private function getSurplusCount(useNum:int, total:int) : int
      {
         return total - useNum;
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
