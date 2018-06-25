package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import road7th.utils.DateUtils;
   
   public class BuildingLevelItem extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _type:int = 0;
      
      private var _tipData:Object;
      
      private var _isShowConsortiaDomainTips:Boolean;
      
      private var _background:MutipleImage;
      
      private var _level:FilterFrameText;
      
      private var _buildId:int;
      
      public function BuildingLevelItem(type:int)
      {
         super();
         _type = type;
         if(_type == 1)
         {
            _buildId = 3;
         }
         else if(_type == 2)
         {
            _buildId = 4;
         }
         else if(_type == 3)
         {
            _buildId = 1;
         }
         else if(_type == 4)
         {
            _buildId = 2;
         }
         initView();
      }
      
      private function initView() : void
      {
         ShowTipManager.Instance.addTip(this);
         switch(int(_type) - 1)
         {
            case 0:
               _background = ComponentFactory.Instance.creatComponentByStylename("consortion.shop");
               break;
            case 1:
               _background = ComponentFactory.Instance.creatComponentByStylename("consortion.store");
               break;
            case 2:
               _background = ComponentFactory.Instance.creatComponentByStylename("consortion.bank");
               break;
            case 3:
               _background = ComponentFactory.Instance.creatComponentByStylename("consortion.skill");
         }
         _level = ComponentFactory.Instance.creatComponentByStylename("consortion.buildLevel");
         addChild(_background);
         addChild(_level);
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(vaule:Object) : void
      {
         var allBuildInfo:* = null;
         var eachBuildInfo:* = null;
         var waitRepairTip:* = null;
         if(ConsortiaDomainManager.instance.activeState == 1)
         {
            _isShowConsortiaDomainTips = true;
            _tipData = LanguageMgr.GetTranslation("consortiadomain.buildStopUse.activeOpen");
            _level.htmlText = LanguageMgr.GetTranslation("consortiadomain.buildState.fight");
         }
         else if(ConsortiaDomainManager.instance.activeState == 0 || ConsortiaDomainManager.instance.activeState == 100)
         {
            allBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo;
            if(allBuildInfo)
            {
               eachBuildInfo = allBuildInfo[_buildId];
            }
            if(eachBuildInfo && eachBuildInfo.Repair > 0)
            {
               _isShowConsortiaDomainTips = true;
               waitRepairTip = LanguageMgr.GetTranslation("consortiadomain.buildStopUse.waitRepair",DateUtils.dateFormat5(ConsortiaDomainManager.instance.model.autoRepairCompleteTime));
               _tipData = waitRepairTip;
               _level.htmlText = LanguageMgr.GetTranslation("consortiadomain.buildState.waitRepair");
            }
         }
         if(!_isShowConsortiaDomainTips)
         {
            _tipData = ConsortionModelManager.Instance.model.getLevelString(_type,vaule as int);
            _level.text = "Lv." + vaule;
         }
      }
      
      public function get tipDirctions() : String
      {
         return "3";
      }
      
      public function set tipDirctions(value:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 0;
      }
      
      public function set tipGapH(value:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 0;
      }
      
      public function set tipGapV(value:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         if(_isShowConsortiaDomainTips)
         {
            return "ddt.view.tips.OneLineTip";
         }
         return "consortion.ConsortiaLevelTip";
      }
      
      public function set tipStyle(value:String) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         ObjectUtils.disposeAllChildren(this);
         _background = null;
         _level = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
