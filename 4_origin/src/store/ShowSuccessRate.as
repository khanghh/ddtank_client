package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.StripTip;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class ShowSuccessRate extends Sprite
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _showTxtI:FilterFrameText;
      
      private var _showTxtII:FilterFrameText;
      
      private var _showTxtIII:FilterFrameText;
      
      private var _showTxtIV:FilterFrameText;
      
      private var _showTxtVIP:FilterFrameText;
      
      private var _showTxtILabel:FilterFrameText;
      
      private var _showTxtIILabel:FilterFrameText;
      
      private var _showTxtIIILabel:FilterFrameText;
      
      private var _showTxtIVLabel:Image;
      
      private var _showTxtVipLabel:FilterFrameText;
      
      private var _showStripI:StripTip;
      
      private var _showStripII:StripTip;
      
      private var _showStripIII:StripTip;
      
      private var _showStripIV:StripTip;
      
      private var _showStripVIP:StripTip;
      
      public function ShowSuccessRate()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.ShowSuccessRateBg");
         _bg.setFrame(1);
         _showTxtI = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextBasic");
         _showTxtI.text = "0%";
         _showTxtII = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextLucky");
         _showTxtII.text = "0%";
         _showTxtIII = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextGuild");
         _showTxtIII.text = "0%";
         _showTxtIV = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextTotal");
         _showTxtIV.text = "0%";
         _showTxtILabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextBasicLabel");
         _showTxtILabel.text = LanguageMgr.GetTranslation("store.Strength.SuccessRate.BasicText");
         _showTxtIILabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextLuckyLabel");
         _showTxtIILabel.text = LanguageMgr.GetTranslation("store.Strength.SuccessRate.LuckyText");
         _showTxtIIILabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextGuildLabel");
         _showTxtIIILabel.text = LanguageMgr.GetTranslation("store.Strength.SuccessRate.GuildText");
         _showTxtIVLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextTotalLabel");
         _showStripI = ComponentFactory.Instance.creatCustomObject("ddtstore.view.basallevelStrip");
         _showStripII = ComponentFactory.Instance.creatCustomObject("ddtstore.view.luckyStrip");
         _showStripIII = ComponentFactory.Instance.creatCustomObject("ddtstore.view.consortiaStrip");
         _showStripIV = ComponentFactory.Instance.creatCustomObject("ddtstore.view.percentageStrip");
         addChild(_bg);
         addChild(_showTxtI);
         addChild(_showTxtII);
         addChild(_showTxtIII);
         addChild(_showTxtIV);
         addChild(_showTxtILabel);
         addChild(_showTxtIILabel);
         addChild(_showTxtIIILabel);
         addChild(_showTxtIVLabel);
         addChild(_showStripI);
         addChild(_showStripII);
         addChild(_showStripIII);
         addChild(_showStripIV);
      }
      
      public function showVIPRate() : void
      {
         _bg.setFrame(2);
         _showTxtVIP = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextVip");
         _showTxtVIP.text = "0%";
         _showTxtVipLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.SuccessRateTextVipLabel");
         _showTxtVipLabel.text = LanguageMgr.GetTranslation("store.Strength.SuccessRate.VipText");
         _showStripVIP = ComponentFactory.Instance.creatCustomObject("ddtstore.view.VIPStrip");
         PositionUtils.setPos(_showTxtI,"ddtstore.showSuccessRateTxtIPos");
         PositionUtils.setPos(_showTxtII,"ddtstore.showSuccessRateTxtIIPos");
         PositionUtils.setPos(_showTxtIII,"ddtstore.showSuccessRateTxtIIIPos");
         PositionUtils.setPos(_showTxtIV,"ddtstore.showSuccessRateTxtIVPos");
         PositionUtils.setPos(_showTxtILabel,"ddtstore.showSuccessRateTxtILabelPos");
         PositionUtils.setPos(_showTxtIILabel,"ddtstore.showSuccessRateTxtIILabelPos");
         PositionUtils.setPos(_showTxtIIILabel,"ddtstore.showSuccessRateTxtIIILabelPos");
         PositionUtils.setPos(_showTxtIVLabel,"ddtstore.showSuccessRateTxtIVLabelPos");
         PositionUtils.setPos(_showStripI,"ddtstore.view.showStripIPos");
         _showStripI.width = _showStripI.width - 10;
         PositionUtils.setPos(_showStripII,"ddtstore.view.showStripIIPos");
         _showStripII.width = _showStripII.width - 10;
         PositionUtils.setPos(_showStripIII,"ddtstore.view.showStripIIIPos");
         _showStripIII.width = _showStripIII.width - 10;
         PositionUtils.setPos(_showStripIV,"ddtstore.view.showStripIVPos");
         _showStripIV.width = _showStripIV.width - 10;
         addChild(_showTxtVIP);
         addChild(_showTxtVipLabel);
         addChild(_showStripVIP);
      }
      
      public function showAllTips(strI:String, strII:String, strIII:String, strIV:String) : void
      {
         _showStripI.tipData = strI;
         _showStripII.tipData = strII;
         _showStripIII.tipData = strIII;
         _showStripIV.tipData = strIV;
      }
      
      public function showVIPTip(tipData:String) : void
      {
         _showStripVIP.tipData = tipData;
      }
      
      public function showAllNum(numI:Number, numII:Number, numIII:Number, numIV:Number) : void
      {
         _showTxtI.text = String(numI) + "%";
         _showTxtII.text = String(numII) + "%";
         _showTxtIII.text = String(numIII) + "%";
         _showTxtIV.text = String(numIV) + "%";
      }
      
      public function showVIPNum(num:Number) : void
      {
         _showTxtVIP.text = String(num) + "%";
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
         if(_showTxtII)
         {
            ObjectUtils.disposeObject(_showTxtII);
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
         if(_showStripII)
         {
            ObjectUtils.disposeObject(_showStripII);
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
         if(_showTxtIILabel)
         {
            ObjectUtils.disposeObject(_showTxtIILabel);
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
         _showTxtII = null;
         _showTxtIII = null;
         _showTxtIV = null;
         _showTxtVIP = null;
         _showStripI = null;
         _showStripII = null;
         _showStripIII = null;
         _showStripIV = null;
         _showStripVIP = null;
         _showTxtILabel = null;
         _showTxtIILabel = null;
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
