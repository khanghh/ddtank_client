package bagAndInfo.amulet
{
   import bagAndInfo.amulet.vo.EquipAmuletActivateGradeVo;
   import bagAndInfo.amulet.vo.EquipAmuletPhaseVo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import horse.HorseAmuletManager;
   
   public class EquipAmuletActivateGradeTips extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _title:FilterFrameText;
      
      private var _text:FilterFrameText;
      
      private var _text1:FilterFrameText;
      
      private var _text2:FilterFrameText;
      
      public function EquipAmuletActivateGradeTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateGradeTipsBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateTips.titleText");
         _text = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateTips.phaseText");
         PositionUtils.setPos(_text,"equipAmulet.activateTip.textPos");
         _text1 = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateTips.gradeText");
         PositionUtils.setPos(_text1,"equipAmulet.activateTip.textPos3");
         _text2 = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateTips.gradeText");
         PositionUtils.setPos(_text2,"equipAmulet.activateTip.textPos4");
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addChild(_bg);
         }
         if(_title)
         {
            addChild(_title);
         }
         if(_text)
         {
            addChild(_text);
         }
         if(_text1)
         {
            addChild(_text1);
         }
         if(_text2)
         {
            addChild(_text2);
         }
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc9_:* = null;
         var _loc11_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc10_:int = 0;
         var _loc12_:* = null;
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc13_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:InventoryItemInfo = param1 as InventoryItemInfo;
         if(_loc8_)
         {
            _loc9_ = EquipAmuletManager.Instance.getAmuletActivateGradeVo(_loc8_.StrengthenExp);
            _title.text = LanguageMgr.GetTranslation("tank.equipAmulet.activateGrade",_loc9_.wahsGrade);
            _loc13_ = _title.y + _title.height;
            _loc7_ = _title.x + _title.width;
            _loc11_ = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_loc8_.StrengthenLevel);
            _loc5_ = EquipAmuletManager.Instance.getAmuletActivateNeedCount(_loc8_.StrengthenExp);
            _text.text = LanguageMgr.GetTranslation("tank.equipAmulet.activateGradeCount",_loc8_.StrengthenExp,_loc5_);
            _loc13_ = _text.y + _text.height > _loc13_?_text.y + _text.height:_loc13_;
            _loc7_ = _text.x + _text.width > _loc7_?_text.x + _text.width:_loc7_;
            _loc4_ = "";
            _loc3_ = "";
            _loc10_ = 1;
            while(_loc10_ <= 9)
            {
               _loc12_ = HorseAmuletManager.instance.getByExtendType(_loc10_);
               _loc2_ = Math.floor(int(_loc11_["property" + _loc10_]) * (_loc9_.minValue / _loc9_.maxValue));
               _loc6_ = LanguageMgr.GetTranslation("tank.equipAmulet.activateGradeTip",_loc12_,_loc2_ > 0?_loc2_:1) + "\n";
               if(_loc10_ % 2 == 0)
               {
                  _loc4_ = _loc4_ + _loc6_;
               }
               else
               {
                  _loc3_ = _loc3_ + _loc6_;
               }
               _loc10_++;
            }
            _text1.htmlText = _loc4_;
            _loc13_ = _text1.y + _text1.height > _loc13_?_text1.y + _text1.height:_loc13_;
            _loc7_ = _text1.x + _text1.width > _loc7_?_text1.x + _text1.width:_loc7_;
            _text2.htmlText = _loc3_;
            _loc13_ = _text2.y + _text2.height > _loc13_?_text2.y + _text2.height:_loc13_;
            _loc7_ = _text2.x + _text2.width > _loc7_?_text2.x + _text2.width:_loc7_;
            _bg.width = _loc7_ + 5;
            _bg.height = _loc13_ + 5;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_text1);
         _text1 = null;
         ObjectUtils.disposeObject(_text2);
         _text2 = null;
      }
   }
}
