package bagAndInfo.amulet
{
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
   
   public class EquipAmuletActivatePhaseTips extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _title:FilterFrameText;
      
      private var _text1:FilterFrameText;
      
      private var _text2:FilterFrameText;
      
      public function EquipAmuletActivatePhaseTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activatePhaseTipsBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateTips.titleText");
         _text1 = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateTips.phaseText");
         PositionUtils.setPos(_text1,"equipAmulet.activateTip.textPos1");
         _text2 = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateTips.phaseText");
         PositionUtils.setPos(_text2,"equipAmulet.activateTip.textPos2");
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
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:InventoryItemInfo = param1 as InventoryItemInfo;
         if(_loc10_)
         {
            _loc9_ = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_loc10_.StrengthenLevel);
            _title.text = LanguageMgr.GetTranslation("tank.equipAmulet.activatePhase",_loc9_.Phase);
            _loc5_ = _title.y + _title.height;
            _loc7_ = _title.x + _title.width;
            _loc3_ = "";
            _loc2_ = "";
            _loc8_ = 1;
            while(_loc8_ <= 9)
            {
               _loc4_ = HorseAmuletManager.instance.getByExtendType(_loc8_);
               _loc6_ = LanguageMgr.GetTranslation("tank.equipAmulet.activatePhaseTip",_loc4_,_loc9_["property" + _loc8_]) + "\n";
               if(_loc8_ % 2 == 0)
               {
                  _loc3_ = _loc3_ + _loc6_;
               }
               else
               {
                  _loc2_ = _loc2_ + _loc6_;
               }
               _loc8_++;
            }
            _text1.htmlText = _loc3_;
            _loc5_ = _text1.y + _text1.height > _loc5_?_text1.y + _text1.height:_loc5_;
            _loc7_ = _text1.x + _text1.width > _loc7_?_text1.x + _text1.width:_loc7_;
            _text2.htmlText = _loc2_;
            _loc5_ = _text2.y + _text2.height > _loc5_?_text2.y + _text2.height:_loc5_;
            _loc7_ = _text2.x + _text2.width > _loc7_?_text2.x + _text2.width:_loc7_;
            _bg.width = _loc7_ + 5;
            _bg.height = _loc5_ + 5;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_text1);
         _text1 = null;
         ObjectUtils.disposeObject(_text2);
         _text2 = null;
      }
   }
}
