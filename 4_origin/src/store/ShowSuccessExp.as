package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import ddt.command.StripTip;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class ShowSuccessExp extends Sprite
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _showTxtI:FilterFrameText;
      
      private var _showTxtIII:FilterFrameText;
      
      private var _showTxtIV:FilterFrameText;
      
      private var _showTxtVIP:FilterFrameText;
      
      private var _showTxtILabel:FilterFrameText;
      
      private var _showTxtIIILabel:FilterFrameText;
      
      private var _showTxtIVLabel:FilterFrameText;
      
      private var _showTxtVipLabel:FilterFrameText;
      
      private var _showStripI:StripTip;
      
      private var _showStripIII:StripTip;
      
      private var _showStripIV:StripTip;
      
      private var _showStripVIP:StripTip;
      
      public function ShowSuccessExp()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.ShowSuccessExpBg");
         _bg.setFrame(1);
         _showTxtI = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessExpTextBasic");
         _showTxtI.text = "0";
         _showTxtIII = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessExpTextGuild");
         setTxtIIIText("0");
         _showTxtIV = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessExpTextTotal");
         _showTxtIV.text = "0";
         _showTxtILabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessExpTextBasicLabel");
         _showTxtILabel.text = LanguageMgr.GetTranslation("store.Strength.SuccessExp.BasicText");
         _showTxtIIILabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessExpTextGuildLabel");
         _showTxtIIILabel.text = LanguageMgr.GetTranslation("store.Strength.SuccessExp.GuildText");
         _showTxtIVLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessExpTextTotalLabel");
         _showTxtIVLabel.text = LanguageMgr.GetTranslation("store.Strength.SuccessExp.TotalText");
         _showStripI = ComponentFactory.Instance.creatCustomObject("ddtstore.view.basallevelStrip");
         _showStripIII = ComponentFactory.Instance.creatCustomObject("ddtstore.view.consortiaStrip");
         _showStripIV = ComponentFactory.Instance.creatCustomObject("ddtstore.view.percentageStrip");
         addChild(_bg);
         addChild(_showTxtI);
         addChild(_showTxtIII);
         addChild(_showTxtIV);
         addChild(_showTxtILabel);
         addChild(_showTxtIIILabel);
         addChild(_showTxtIVLabel);
         addChild(_showStripI);
         addChild(_showStripIII);
         addChild(_showStripIV);
      }
      
      public function showVIPRate() : void
      {
         _bg.setFrame(2);
         _showTxtVIP = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessExpTextVip");
         _showTxtVIP.text = "0";
         _showTxtVipLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessExpTextVipLabel");
         _showTxtVipLabel.text = LanguageMgr.GetTranslation("store.Strength.SuccessExp.VipText");
         _showStripVIP = ComponentFactory.Instance.creatCustomObject("ddtstore.view.VIPStrip");
         PositionUtils.setPos(_showStripI,"ddtstore.view.showStripIExpPos");
         _showStripI.width = _showStripI.width - 10;
         PositionUtils.setPos(_showStripIII,"ddtstore.view.showStripIIIExpPos");
         _showStripIII.width = _showStripIII.width - 10;
         PositionUtils.setPos(_showStripIV,"ddtstore.view.showStripIVExpPos");
         _showStripIV.width = _showStripIV.width - 10;
         PositionUtils.setPos(_showStripVIP,"ddtstore.view.showStripVIPExpPos");
         _showStripVIP.width = _showStripVIP.width - 10;
         addChild(_showTxtVIP);
         addChild(_showTxtVipLabel);
         addChild(_showStripVIP);
      }
      
      public function showAllTips(strI:String, strIII:String, strIV:String) : void
      {
         _showStripI.tipData = strI;
         _showStripIII.tipData = strIII;
         _showStripIV.tipData = strIV;
      }
      
      public function showVIPTip(tipData:String) : void
      {
         _showStripVIP.tipData = tipData;
      }
      
      public function showAllNum(numI:Number, numIII:Number, numVIP:Number, numIV:Number) : void
      {
         _showTxtI.text = String(numI);
         setTxtIIIText(numIII.toString());
         _showTxtVIP.text = String(numVIP);
         _showTxtIV.text = String(numIV);
      }
      
      private function setTxtIIIText(numIII:String) : void
      {
         var isShowConsortiaDomainTips:Boolean = false;
         var allBuildInfo:* = null;
         var eachBuildInfo:* = null;
         if(ConsortiaDomainManager.instance.activeState == 1)
         {
            isShowConsortiaDomainTips = true;
            _showTxtIII.htmlText = LanguageMgr.GetTranslation("consortiadomain.buildState.fight");
         }
         else if(ConsortiaDomainManager.instance.activeState == 0 || ConsortiaDomainManager.instance.activeState == 100)
         {
            allBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo;
            if(allBuildInfo)
            {
               eachBuildInfo = allBuildInfo[4];
            }
            if(eachBuildInfo && eachBuildInfo.Repair > 0)
            {
               isShowConsortiaDomainTips = true;
               _showTxtIII.htmlText = LanguageMgr.GetTranslation("consortiadomain.buildState.waitRepair");
            }
         }
         if(!isShowConsortiaDomainTips)
         {
            _showTxtIII.text = numIII;
         }
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         if(_showTxtI)
         {
            ObjectUtils.disposeObject(_showTxtI);
         }
         if(_showTxtIII)
         {
            ObjectUtils.disposeObject(_showTxtIII);
         }
         if(_showTxtIV)
         {
            ObjectUtils.disposeObject(_showTxtIV);
         }
         if(_showTxtVIP)
         {
            ObjectUtils.disposeObject(_showTxtVIP);
         }
         if(_showStripI)
         {
            ObjectUtils.disposeObject(_showStripI);
         }
         if(_showStripIII)
         {
            ObjectUtils.disposeObject(_showStripIII);
         }
         if(_showStripIV)
         {
            ObjectUtils.disposeObject(_showStripIV);
         }
         if(_showStripVIP)
         {
            ObjectUtils.disposeObject(_showStripVIP);
         }
         if(_showTxtILabel)
         {
            ObjectUtils.disposeObject(_showTxtILabel);
         }
         if(_showTxtIIILabel)
         {
            ObjectUtils.disposeObject(_showTxtIIILabel);
         }
         if(_showTxtIVLabel)
         {
            ObjectUtils.disposeObject(_showTxtIVLabel);
         }
         if(_showTxtVipLabel)
         {
            ObjectUtils.disposeObject(_showTxtVipLabel);
         }
         _bg = null;
         _showTxtI = null;
         _showTxtIII = null;
         _showTxtIV = null;
         _showTxtVIP = null;
         _showStripI = null;
         _showStripIII = null;
         _showStripIV = null;
         _showStripVIP = null;
         _showTxtILabel = null;
         _showTxtIIILabel = null;
         _showTxtIVLabel = null;
         _showTxtVipLabel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
