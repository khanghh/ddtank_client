package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class PetWashBoneProItem extends Sprite implements Disposeable
   {
      
      public static const CLICK_LOCK:String = "clickLock";
       
      
      private var _proType:String;
      
      private var _lockImg:ScaleFrameImage;
      
      private var _proName:FilterFrameText;
      
      private var _proMaxValue:FilterFrameText;
      
      private var _isLock:Boolean = false;
      
      private var _petInfo:PetInfo;
      
      private var _proState:ScaleFrameImage;
      
      private var _oldProValue:int;
      
      public function PetWashBoneProItem(proType:String, petInfo:PetInfo)
      {
         _proType = proType;
         _petInfo = petInfo;
         _isLock = false;
         _oldProValue = -1;
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _lockImg = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.proItem.lockImg");
         addChild(_lockImg);
         _lockImg.setFrame(1);
         _proName = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.proItem.name");
         addChild(_proName);
         _proState = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.proItem.stateIcon");
         addChild(_proState);
         _proState.setFrame(2);
         _proState.visible = false;
         _proMaxValue = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.proMaxValue");
         addChild(_proMaxValue);
      }
      
      private function initData() : void
      {
         update(_petInfo);
      }
      
      private function initEvent() : void
      {
         if(_lockImg)
         {
            _lockImg.addEventListener("click",__lockClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_lockImg)
         {
            _lockImg.removeEventListener("click",__lockClickHandler);
         }
      }
      
      private function __lockClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         isLock = !isLock;
         this.dispatchEvent(new CEvent("clickLock",this));
      }
      
      public function update(petInfo:PetInfo) : void
      {
         var proValue:int = 0;
         var datumValue:int = 0;
         var index:int = 0;
         if(petInfo == null)
         {
            return;
         }
         _petInfo = petInfo;
         var propertiesRate:Number = PetconfigAnalyzer.PetCofnig.PropertiesRate;
         if(_petInfo && _petInfo.hasOwnProperty(_proType))
         {
            proValue = _petInfo[_proType];
         }
         _proName.text = LanguageMgr.GetTranslation("ddt.pets.washBone.pro" + _proType,(proValue / propertiesRate).toFixed(2));
         if(_petInfo.hasOwnProperty(_proType + "Datum"))
         {
            datumValue = _petInfo[_proType + "Datum"];
            index = PetsBagManager.instance().getPetQualityIndex(datumValue);
            _proName.setFrame(index + 1);
         }
         _proState.visible = _oldProValue >= 0;
         if(int(proValue) > _oldProValue)
         {
            _proState.setFrame(3);
         }
         else if(int(proValue) == _oldProValue)
         {
            _proState.setFrame(2);
         }
         else
         {
            _proState.setFrame(1);
         }
         var maxValue:int = !!_petInfo.hasOwnProperty("High" + _proType)?_petInfo["High" + _proType]:0;
         _proMaxValue.text = (maxValue / propertiesRate).toFixed(2);
         _oldProValue = int(proValue);
      }
      
      public function set isLock(value:Boolean) : void
      {
         _isLock = value;
         _lockImg.setFrame(!!isLock?2:1);
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_proName);
         _proName = null;
         ObjectUtils.disposeObject(_proMaxValue);
         _proMaxValue = null;
         ObjectUtils.disposeObject(_proState);
         _proState = null;
         _petInfo = null;
      }
   }
}
