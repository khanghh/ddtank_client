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
      
      public function show(list:Array, isConfirm:Boolean) : void
      {
         _list = list;
         _isConfirm = isConfirm;
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
      
      override protected function onResponse(type:int) : void
      {
         if(type == 2 || type == 3)
         {
            if(_isConfirm && !checkInputCorrect())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.smashYesFail"));
               return;
            }
         }
         super.onResponse(type);
      }
      
      private function calculateSmashNum() : void
      {
         var i:int = 0;
         var info:* = null;
         var vo:* = null;
         var bag:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         var count:int = 0;
         for(i = 0; i < _list.length; )
         {
            info = bag.getItemAt(_list[i]);
            if(info)
            {
               vo = HorseAmuletManager.instance.data[info.TemplateID] as HorseAmuletVo;
               count = count + vo.ShatterNum;
            }
            i++;
         }
         _countTips.htmlText = LanguageMgr.GetTranslation("tank.horseAmulet.smashCountTips",count);
      }
      
      private function __onTextInputKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            onResponse(3);
            event.stopPropagation();
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
