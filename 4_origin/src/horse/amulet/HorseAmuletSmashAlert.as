package horse.amulet
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.events.KeyboardEvent;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   
   public class HorseAmuletSmashAlert extends BaseAlerFrame
   {
       
      
      private var _countTips:FilterFrameText;
      
      private var _tipsText:FilterFrameText;
      
      private var _yesText:FilterFrameText;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _textInput:TextInput;
      
      private var _list:Array;
      
      private var _isConfirm:Boolean;
      
      public function HorseAmuletSmashAlert()
      {
         super();
         info = new AlertInfo(LanguageMgr.GetTranslation("tank.horseAmulet.smashTips"));
      }
      
      public function show(param1:Array, param2:Boolean) : void
      {
         _list = param1;
         _isConfirm = param2;
         initView();
         LayerManager.Instance.addToLayer(this,1,true,1);
         if(_textInput)
         {
            _textInput.setFocus();
         }
      }
      
      private function initView() : void
      {
         _countTips = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashFrame.countText");
         addToContent(_countTips);
         calculateSmashNum();
         if(_isConfirm)
         {
            this.height = 220;
            _tipsText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashFrame.qualityText");
            _tipsText.htmlText = LanguageMgr.GetTranslation("tank.horseAmulet.smashQualityTips");
            addToContent(_tipsText);
            _yesText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashFrame.yesText");
            _yesText.text = LanguageMgr.GetTranslation("tank.horseAmulet.smashYES");
            _inputBg = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashFrame.inputBg");
            addToContent(_inputBg);
            _textInput = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.smashFrame.inputText");
            _textInput.addEventListener("keyDown",__onTextInputKeyDown);
            addToContent(_textInput);
         }
      }
      
      override protected function onResponse(param1:int) : void
      {
         if(param1 == 2 || param1 == 3)
         {
            if(_isConfirm && !checkInputCorrect())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.smashYesFail"));
               return;
            }
         }
         super.onResponse(param1);
      }
      
      private function calculateSmashNum() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         var _loc1_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _list.length)
         {
            _loc4_ = _loc2_.getItemAt(_list[_loc5_]);
            if(_loc4_)
            {
               _loc3_ = HorseAmuletManager.instance.data[_loc4_.TemplateID] as HorseAmuletVo;
               _loc1_ = _loc1_ + _loc3_.ShatterNum;
            }
            _loc5_++;
         }
         _countTips.htmlText = LanguageMgr.GetTranslation("tank.horseAmulet.smashCountTips",_loc1_);
      }
      
      private function __onTextInputKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            onResponse(3);
            param1.stopPropagation();
         }
      }
      
      public function get textInput() : TextInput
      {
         return _textInput;
      }
      
      public function get isConfirm() : Boolean
      {
         return _isConfirm;
      }
      
      public function checkInputCorrect() : Boolean
      {
         return _textInput.text.toLocaleUpperCase() == "YES";
      }
      
      public function get placeList() : Array
      {
         return _list;
      }
      
      override public function dispose() : void
      {
         if(_textInput)
         {
            _textInput.removeEventListener("keyDown",__onTextInputKeyDown);
         }
         ObjectUtils.disposeObject(_textInput);
         _textInput = null;
         ObjectUtils.disposeObject(_countTips);
         _countTips = null;
         ObjectUtils.disposeObject(_tipsText);
         _tipsText = null;
         ObjectUtils.disposeObject(_yesText);
         _yesText = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         _list = null;
         super.dispose();
      }
   }
}
