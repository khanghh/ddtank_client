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
      
      public function HorseAmuletEquipTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.bg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.vBox");
         _titleText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.titleText");
         _titleText.text = LanguageMgr.GetTranslation("tank.horseAmulet.propertyAdd");
         _vBox.addChild(_titleText);
         _vBox.addChild(ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.line"));
         _baseHpText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.baseHpText");
         _baseHpText.text = LanguageMgr.GetTranslation("tank.horseAmulet.baseAdd");
         _vBox.addChild(_baseHpText);
         _addHpText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.addHpText");
         _vBox.addChild(_addHpText);
         _vBox.addChild(ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.line"));
         _extendText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.extendText");
         _extendText.text = LanguageMgr.GetTranslation("tank.horseAmulet.extendAdd");
         _vBox.addChild(_extendText);
         _propertyList = new Vector.<FilterFrameText>();
         _property = LanguageMgr.GetTranslation("tank.horseAmulet.propertyList").split(",");
         _loc2_ = 0;
         while(_loc2_ < _property.length)
         {
            _propertyList[_loc2_] = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.propertyText");
            _propertyList[_loc2_].text = _property[_loc2_] + "      +0";
            _vBox.addChild(_propertyList[_loc2_]);
            _loc2_++;
         }
         _vBox.addChild(ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.line"));
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.tipsHelpText");
         _loc1_.text = LanguageMgr.GetTranslation("tank.horseAmulet.tipsHelp");
         _vBox.addChild(_loc1_);
         super.init();
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc2_:PlayerInfo = param1 as PlayerInfo;
         if(_loc2_.isSelf)
         {
            updateSelfTips();
         }
         else
         {
            updateTips(_loc2_);
         }
      }
      
      private function updateSelfTips() : void
      {
         var _loc1_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc2_:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         var _loc4_:Dictionary = new Dictionary();
         _loc9_ = 0;
         while(_loc9_ < 9)
         {
            _loc8_ = _loc2_.getItemAt(_loc9_) as InventoryItemInfo;
            if(_loc8_)
            {
               _loc7_ = HorseAmuletManager.instance.getHorseAmuletVo(_loc8_.TemplateID);
               _loc1_ = _loc1_ + _loc7_.BaseType1Value;
               if(_loc4_[_loc7_.ExtendType1])
               {
                  var _loc10_:* = _loc7_.ExtendType1;
                  var _loc11_:* = _loc4_[_loc10_] + _loc8_.Hole1;
                  _loc4_[_loc10_] = _loc11_;
               }
               else
               {
                  _loc4_[_loc7_.ExtendType1] = _loc8_.Hole1;
               }
            }
            _loc9_++;
         }
         _addHpText.text = LanguageMgr.GetTranslation("MaxHp") + "      +" + _loc1_;
         _loc5_ = 0;
         while(_loc5_ < 9)
         {
            _loc6_ = (_loc5_ + 1).toString();
            _loc3_ = _loc4_[_loc6_] || 0;
            _propertyList[_loc5_].text = _property[_loc5_] + "      +" + _loc3_;
            _loc5_++;
         }
         _vBox.arrange();
      }
      
      private function updateTips(param1:PlayerInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _addHpText.text = LanguageMgr.GetTranslation("MaxHp") + "      +" + param1.horseAmuletHp;
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = param1.horseAmuletProperty.length > _loc3_?param1.horseAmuletProperty[_loc3_]:0;
            _propertyList[_loc3_].text = _property[_loc3_] + "      +" + _loc2_;
            _loc3_++;
         }
         _vBox.arrange();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addChild(_bg);
         }
         if(_vBox)
         {
            addChild(_vBox);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_vBox);
         ObjectUtils.disposeAllChildren(this);
         _vBox = null;
         _titleText = null;
         _baseHpText = null;
         _addHpText = null;
         _extendText = null;
         _propertyText = null;
         super.dispose();
      }
   }
}
