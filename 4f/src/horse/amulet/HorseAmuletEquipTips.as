package horse.amulet
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   
   public class HorseAmuletEquipTips extends BaseTip implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _titleText:FilterFrameText;
      
      private var _baseHpText:FilterFrameText;
      
      private var _addHpText:FilterFrameText;
      
      private var _extendText:FilterFrameText;
      
      private var _propertyText:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _propertyList:Vector.<FilterFrameText>;
      
      private var _property:Array;
      
      public function HorseAmuletEquipTips(){super();}
      
      override protected function init() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      private function updateSelfTips() : void{}
      
      private function updateTips(param1:PlayerInfo) : void{}
      
      override protected function addChildren() : void{}
      
      override public function dispose() : void{}
   }
}
