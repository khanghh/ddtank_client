package horse.horsePicCherish
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.getTimer;
   import horse.HorseControl;
   import horse.HorseManager;
   import horse.data.HorsePicCherishVo;
   
   public class HorsePicCherishItem extends Component
   {
       
      
      private var _index:int;
      
      private var _bg:Bitmap;
      
      private var _horseIcon:Bitmap;
      
      private var _data:HorsePicCherishVo;
      
      private var _horseName:FilterFrameText;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      private var _state:Array;
      
      private var _useBtn:TextButton;
      
      private var _activeBtn:TextButton;
      
      private var _stateArr:Array;
      
      private var _propertyTxtArr:Array;
      
      private var _propertyValueArr:Array;
      
      private var _lastClickTime:int = 0;
      
      public function HorsePicCherishItem(param1:int, param2:HorsePicCherishVo){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __changeHorseHandler(param1:Event) : void{}
      
      protected function __activeHandler(param1:MouseEvent) : void{}
      
      protected function __useHandler(param1:MouseEvent) : void{}
      
      private function updateView() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
