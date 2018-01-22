package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import ddt.data.store.FineSuitVo;
   import ddt.manager.FineSuitManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   
   public class FineSuitTipsSimple extends BaseTip
   {
       
      
      private var _icon:ScaleFrameImage;
      
      private var _typeText:FilterFrameText;
      
      private var _typeNameArr:Array;
      
      private var _title:FilterFrameText;
      
      private var _defenceTxt:FilterFrameText;
      
      private var _luckTxt:FilterFrameText;
      
      private var _magicDefTxt:FilterFrameText;
      
      private var _armorTxt:FilterFrameText;
      
      private var _agilityTxt:FilterFrameText;
      
      private var _healthTxt:FilterFrameText;
      
      private var _detail:FilterFrameText;
      
      public function FineSuitTipsSimple()
      {
         _typeNameArr = ["Trang phục đá","Trang phục đồng","Trang phục bạc","Trang phục vàng","Trang phục ngọc","Trang phục ngọc"];
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         tipbackgound = ComponentFactory.Instance.creat("core.simpleSuitTipsBg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.image");
         PositionUtils.setPos(_icon,"suitTip.iconImg.Pos");
         addChild(_icon);
         _typeText = ComponentFactory.Instance.creat("storeFine.simpleTip.typeText");
         PositionUtils.setPos(_typeText,"suitTip.iconTxt.Pos");
         addChild(_typeText);
         _title = ComponentFactory.Instance.creat("storeFine.simpleTip.titleText");
         PositionUtils.setPos(_title,"suitTip.title.Pos");
         _title.text = "Tiền thưởng";
         addChild(_title);
         _defenceTxt = ComponentFactory.Instance.creat("storeFine.simpleTip.propertyText");
         PositionUtils.setPos(_defenceTxt,"suitTip.por0.Pos");
         addChild(_defenceTxt);
         _luckTxt = ComponentFactory.Instance.creat("storeFine.simpleTip.propertyText");
         PositionUtils.setPos(_luckTxt,"suitTip.por1.Pos");
         addChild(_luckTxt);
         _magicDefTxt = ComponentFactory.Instance.creat("storeFine.simpleTip.propertyText");
         PositionUtils.setPos(_magicDefTxt,"suitTip.por2.Pos");
         addChild(_magicDefTxt);
         _armorTxt = ComponentFactory.Instance.creat("storeFine.simpleTip.propertyText");
         PositionUtils.setPos(_armorTxt,"suitTip.por3.Pos");
         addChild(_armorTxt);
         _agilityTxt = ComponentFactory.Instance.creat("storeFine.simpleTip.propertyText");
         PositionUtils.setPos(_agilityTxt,"suitTip.por4.Pos");
         addChild(_agilityTxt);
         _healthTxt = ComponentFactory.Instance.creat("storeFine.simpleTip.propertyText");
         PositionUtils.setPos(_healthTxt,"suitTip.por5.Pos");
         addChild(_healthTxt);
         _detail = ComponentFactory.Instance.creat("storeFine.simpleTip.propertyText");
         PositionUtils.setPos(_detail,"storeFine.detailPos");
         _detail.width = 162;
         _detail.height = 75;
         _detail.wordWrap = true;
         _detail.text = LanguageMgr.GetTranslation("storeFine.forge.detail");
         addChild(_detail);
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc5_:FineSuitVo = FineSuitManager.Instance.getFineSuitPropertyByExp(int(param1));
         var _loc4_:FineSuitVo = FineSuitManager.Instance.getSuitVoByExp(int(param1));
         var _loc3_:int = _loc4_.level / 14;
         var _loc2_:int = _loc4_.level % 14;
         _icon.setFrame(Math.min(_loc3_ + 1,5));
         if(_loc3_ == 5)
         {
            _typeText.text = "[" + _typeNameArr[_loc3_] + "]";
         }
         else
         {
            _typeText.text = "[" + _typeNameArr[_loc3_] + "] " + _loc2_ + "/14";
         }
         _typeText.textFormatStyle = "finesuit.simpleTip.tf" + _loc3_.toString();
         _typeText.filterString = "finesuit.simpleTip.gf" + _loc3_.toString();
         _defenceTxt.htmlText = "Phòng thủ <font color=\'#76ff80\'>+" + _loc5_.Defence + "</font>";
         _luckTxt.htmlText = "May mắn <font color=\'#76ff80\'>+" + _loc5_.Luck + "</font>";
         _magicDefTxt.htmlText = "Ma Kháng <font color=\'#76ff80\'>+" + _loc5_.MagicDefence + "</font>";
         _armorTxt.htmlText = "Hộ giáp <font color=\'#76ff80\'>+" + _loc5_.Armor + "</font>";
         _agilityTxt.htmlText = "Nhanh nhẹn <font color=\'#76ff80\'>+" + _loc5_.Agility + "</font>";
         _healthTxt.htmlText = "HP <font color=\'#76ff80\'>+" + _loc5_.hp + "</font>";
      }
   }
}
