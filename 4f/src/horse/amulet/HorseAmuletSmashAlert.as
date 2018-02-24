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
      
      public function HorseAmuletSmashAlert(){super();}
      
      public function show(param1:Array, param2:Boolean) : void{}
      
      private function initView() : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      private function calculateSmashNum() : void{}
      
      private function __onTextInputKeyDown(param1:KeyboardEvent) : void{}
      
      public function get textInput() : TextInput{return null;}
      
      public function get isConfirm() : Boolean{return false;}
      
      public function checkInputCorrect() : Boolean{return false;}
      
      public function get placeList() : Array{return null;}
      
      override public function dispose() : void{}
   }
}
