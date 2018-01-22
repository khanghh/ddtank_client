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
      
      public function EquipAmuletActivatePhaseTips(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      override public function dispose() : void{}
   }
}
