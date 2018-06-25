package bagAndInfo.amulet
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import horse.HorseAmuletManager;
   
   public class EquipAmuletActivateItem extends Sprite implements Disposeable
   {
       
      
      private var _lock:ScaleFrameImage;
      
      private var _lockSpr:Sprite;
      
      private var _propertyText:FilterFrameText;
      
      private var _valueText:FilterFrameText;
      
      private var _startLevelText:FilterFrameText;
      
      private var _lockBool:Boolean;
      
      private var _type:int;
      
      private var _value:int;
      
      private var _startLevel:int;
      
      public function EquipAmuletActivateItem(showLock:Boolean = true)
      {
         super();
         _propertyText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.actifvatePropertyText");
         _valueText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.actifvateValueText");
         _startLevelText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.starLevelText");
         addChild(_propertyText);
         addChild(_valueText);
         addChild(_startLevelText);
         if(showLock)
         {
            _lock = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.lock");
            _lockSpr = new Sprite();
            _lockSpr.x = -4;
            _lockSpr.buttonMode = true;
            _lockSpr.addChild(_lock);
            addChild(_lockSpr);
            _lockSpr.addEventListener("click",__onClikc);
            lockBool = false;
            _valueText.setFrame(1);
         }
         else
         {
            _valueText.setFrame(2);
         }
         update(1,100);
      }
      
      private function __onClikc(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_type <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.notPropertyLock"));
         }
         else if(EquipAmuletManager.Instance.lockNum == 3 && !_lockBool)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.lockPropertyTip"));
         }
         else
         {
            lockBool = !_lockBool;
         }
      }
      
      public function update(property:int, value:int, probability:int = 0) : void
      {
         _type = property;
         _value = value;
         var level:int = int(probability / 1000) + 1;
         _startLevel = level > 10?10:level;
         if(_type <= 0)
         {
            _propertyText.visible = false;
            _valueText.visible = false;
            _startLevelText.visible = false;
            if(_lockSpr)
            {
               _lockSpr.visible = false;
            }
         }
         else
         {
            _propertyText.text = HorseAmuletManager.instance.getByExtendType(property);
            _propertyText.visible = true;
            _valueText.text = value.toString();
            _valueText.visible = true;
            if(_lockSpr)
            {
               _lockSpr.visible = true;
            }
            _startLevelText.setFrame(int((_startLevel - 1) / 3) + 1);
            _startLevelText.text = LanguageMgr.GetTranslation("tank.equipAmulet.starTip",_startLevel);
            _startLevelText.visible = true;
         }
      }
      
      public function set lockBool(value:Boolean) : void
      {
         _lockBool = value;
         if(_lock)
         {
            _lock.setFrame(!_lockBool?1:2);
         }
         dispatchEvent(new Event("change"));
      }
      
      public function get lockBool() : Boolean
      {
         return _lockBool;
      }
      
      public function get propertyType() : int
      {
         return _type;
      }
      
      public function get propertyValue() : int
      {
         return _value;
      }
      
      public function get startLevel() : int
      {
         return _startLevel;
      }
      
      public function dispose() : void
      {
         if(_lockSpr)
         {
            _lockSpr.removeEventListener("click",__onClikc);
         }
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeAllChildren(this);
         _lock = null;
         _lockSpr = null;
         _propertyText = null;
         _valueText = null;
         _startLevelText = null;
      }
   }
}
