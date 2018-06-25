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
      
      override public function set tipData(value:Object) : void
      {
         var vo:* = null;
         var t1:* = null;
         var t2:* = null;
         var i:int = 0;
         var p:* = null;
         var k:* = null;
         var heightMax:int = 0;
         var widthMax:int = 0;
         var info:InventoryItemInfo = value as InventoryItemInfo;
         if(info)
         {
            vo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(info.StrengthenLevel);
            _title.text = LanguageMgr.GetTranslation("tank.equipAmulet.activatePhase",vo.Phase);
            heightMax = _title.y + _title.height;
            widthMax = _title.x + _title.width;
            t1 = "";
            t2 = "";
            for(i = 1; i <= 9; )
            {
               p = HorseAmuletManager.instance.getByExtendType(i);
               k = LanguageMgr.GetTranslation("tank.equipAmulet.activatePhaseTip",p,vo["property" + i]) + "\n";
               if(i % 2 == 0)
               {
                  t1 = t1 + k;
               }
               else
               {
                  t2 = t2 + k;
               }
               i++;
            }
            _text1.htmlText = t1;
            heightMax = _text1.y + _text1.height > heightMax?_text1.y + _text1.height:heightMax;
            widthMax = _text1.x + _text1.width > widthMax?_text1.x + _text1.width:widthMax;
            _text2.htmlText = t2;
            heightMax = _text2.y + _text2.height > heightMax?_text2.y + _text2.height:heightMax;
            widthMax = _text2.x + _text2.width > widthMax?_text2.x + _text2.width:widthMax;
            _bg.width = widthMax + 5;
            _bg.height = heightMax + 5;
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
