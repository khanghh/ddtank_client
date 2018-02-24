package ddt.view.roulette
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   
   public class RouletteBoxPanel extends Frame
   {
       
      
      private var _view:RouletteView;
      
      private var _templateIDList:Array;
      
      private var _keyCount:int;
      
      private var _oldBjYYVolNum:int;
      
      private var _oldYxYYVolNum:int;
      
      public function RouletteBoxPanel(){super();}
      
      private function initII() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function _responseII(param1:FrameEvent) : void{}
      
      public function set templateIDList(param1:Array) : void{}
      
      public function set keyCount(param1:int) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
