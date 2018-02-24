package ddtKingFloat.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddtKingFloat.DDTKingFloatManager;
   import ddtKingFloat.components.DDTKingFloatNameCell;
   import ddtKingFloat.data.DDTKingFloatPlayerInfo;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class DDTKingFloatMissileFrame extends Frame
   {
       
      
      private var _labelBg:Bitmap;
      
      private var _labelTxt:FilterFrameText;
      
      private var _listBg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _submitBtn:TextButton;
      
      private var _list:Array;
      
      private var _playerList:Vector.<DDTKingFloatPlayerInfo>;
      
      private var _threeBtnView:DDTKingFloatThreeBtnView;
      
      public function DDTKingFloatMissileFrame(){super();}
      
      private function initView() : void{}
      
      private function setList() : void{}
      
      private function initEvents() : void{}
      
      protected function __cellClick(param1:MouseEvent) : void{}
      
      protected function __submitBtnClick(param1:MouseEvent) : void{}
      
      public function setThreeBtnView(param1:DDTKingFloatThreeBtnView) : void{}
      
      protected function _response(param1:FrameEvent) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
   }
}
