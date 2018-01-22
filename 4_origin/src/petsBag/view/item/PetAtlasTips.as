package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PetInfoManager;
   import ddt.utils.PositionUtils;
   import petsBag.data.PetAtlasInfo;
   
   public class PetAtlasTips extends BaseTip
   {
       
      
      private var _info:PetAtlasInfo;
      
      private var _nameText:FilterFrameText;
      
      private var _line1:ScaleBitmapImage;
      
      private var _activateText:FilterFrameText;
      
      private var _atkText:FilterFrameText;
      
      private var _defText:FilterFrameText;
      
      private var _spdText:FilterFrameText;
      
      private var _lukText:FilterFrameText;
      
      private var _line2:ScaleBitmapImage;
      
      private var _activate:FilterFrameText;
      
      public function PetAtlasTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         tipbackgound = ComponentFactory.Instance.creat("core.GoodsTipBg");
         ObjectUtils.copyPropertyByRectangle(_tipbackgound,ComponentFactory.Instance.creatCustomObject("petsBag.atlasTips.bgRect"));
         _nameText = ComponentFactory.Instance.creat("petsBag.atlasTip.nameText");
         _line1 = ComponentFactory.Instance.creat("petsBag.atlasTip.line");
         PositionUtils.setPos(_line1,"petsBag.atlasTips.line1Pos");
         _activateText = ComponentFactory.Instance.creat("petsBag.atlasTip.activateText");
         _activateText.text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.propertyNameTxt");
         _atkText = ComponentFactory.Instance.creat("petsBag.atlasTip.propertyText");
         _defText = ComponentFactory.Instance.creat("petsBag.atlasTip.propertyText");
         PositionUtils.setPos(_defText,"petsBag.atlasTips.defPos");
         _spdText = ComponentFactory.Instance.creat("petsBag.atlasTip.propertyText");
         PositionUtils.setPos(_spdText,"petsBag.atlasTips.spdPos");
         _lukText = ComponentFactory.Instance.creat("petsBag.atlasTip.propertyText");
         PositionUtils.setPos(_lukText,"petsBag.atlasTips.lukPos");
         _line2 = ComponentFactory.Instance.creat("petsBag.atlasTip.line");
         PositionUtils.setPos(_line2,"petsBag.atlasTips.line2Pos");
         _activate = ComponentFactory.Instance.creat("petsBag.atlasTip.activate");
         _activate.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.inactive");
         addChild(_nameText);
         addChild(_line1);
         addChild(_activateText);
         addChild(_atkText);
         addChild(_defText);
         addChild(_spdText);
         addChild(_lukText);
         addChild(_line2);
         addChild(_activate);
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(param1)
         {
            _info = param1 as PetAtlasInfo;
            update();
         }
      }
      
      private function update() : void
      {
         var _loc2_:String = PetInfoManager.getPetByCollectID(_info.ID).Name;
         _atkText.text = LanguageMgr.GetTranslation("attack") + "+" + _info.Attack;
         _defText.text = LanguageMgr.GetTranslation("defence") + "+" + _info.Defence;
         _spdText.text = LanguageMgr.GetTranslation("agility") + "+" + _info.Agility;
         _lukText.text = LanguageMgr.GetTranslation("luck") + "+" + _info.Lucky;
         var _loc1_:Array = LanguageMgr.GetTranslation("avatarCollection.itemTip.activityTxt").split(",");
         if(_info.isActivate)
         {
            _nameText.text = _loc2_ + " Lv." + _info.level;
            _activate.text = _loc1_[0];
            _activate.textColor = 3273482;
         }
         else
         {
            _nameText.text = _loc2_;
            _activate.text = _loc1_[1];
            _activate.textColor = 16711680;
         }
      }
      
      override public function get tipData() : Object
      {
         return _info;
      }
   }
}
