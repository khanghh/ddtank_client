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
         var i:int = 0;
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
         for(i = 0; i < _property.length; )
         {
            _propertyList[i] = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.propertyText");
            _propertyList[i].text = _property[i] + "      +0";
            _vBox.addChild(_propertyList[i]);
            i++;
         }
         _vBox.addChild(ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.line"));
         var tipsHelpText:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.equipTips.tipsHelpText");
         tipsHelpText.text = LanguageMgr.GetTranslation("tank.horseAmulet.tipsHelp");
         _vBox.addChild(tipsHelpText);
         super.init();
      }
      
      override public function set tipData(value:Object) : void
      {
         var player:PlayerInfo = value as PlayerInfo;
         if(player.isSelf)
         {
            updateSelfTips();
         }
         else
         {
            updateTips(player);
         }
      }
      
      private function updateSelfTips() : void
      {
         var hp:int = 0;
         var i:int = 0;
         var info:* = null;
         var vo:* = null;
         var j:int = 0;
         var key:* = null;
         var p:int = 0;
         var bag:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         var data:Dictionary = new Dictionary();
         for(i = 0; i < 9; )
         {
            info = bag.getItemAt(i) as InventoryItemInfo;
            if(info)
            {
               vo = HorseAmuletManager.instance.getHorseAmuletVo(info.TemplateID);
               hp = hp + vo.BaseType1Value;
               if(data[vo.ExtendType1])
               {
                  var _loc10_:* = vo.ExtendType1;
                  var _loc11_:* = data[_loc10_] + info.Hole1;
                  data[_loc10_] = _loc11_;
               }
               else
               {
                  data[vo.ExtendType1] = info.Hole1;
               }
            }
            i++;
         }
         _addHpText.text = LanguageMgr.GetTranslation("MaxHp") + "      +" + hp;
         for(j = 0; j < 9; )
         {
            key = (j + 1).toString();
            p = data[key] || 0;
            _propertyList[j].text = _property[j] + "      +" + p;
            j++;
         }
         _vBox.arrange();
      }
      
      private function updateTips(info:PlayerInfo) : void
      {
         var j:int = 0;
         var p:int = 0;
         _addHpText.text = LanguageMgr.GetTranslation("MaxHp") + "      +" + info.horseAmuletHp;
         for(j = 0; j < 9; )
         {
            p = info.horseAmuletProperty.length > j?info.horseAmuletProperty[j]:0;
            _propertyList[j].text = _property[j] + "      +" + p;
            j++;
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
